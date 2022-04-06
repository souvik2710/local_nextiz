import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nextiz/common/properties/color.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/widgets/pop_up_actions_appbar.dart';
import '../events/layout.dart';
import '../view_model.dart';

class SecondaryMainWebView extends HookConsumerWidget {
  final String initialUrl;
  int indexPass;
  int selectedIndex;
  bool onlyEvents;
  SecondaryMainWebView({required this.initialUrl,this.indexPass=0, this.selectedIndex =0,this.onlyEvents=false});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkNow = useState(true);
    final mainSelectedIndex = useState(selectedIndex);
    // if(checkNow.value){
    //   mainSelectedIndex.value = selectedIndex;
    //   checkNow.value = !checkNow.value;
    // }
    final Completer<WebViewController> _controller = Completer<WebViewController>();
    final watchBaseUrl =  !onlyEvents? null:ref.watch(mainBasicChangeProvider).getEventByUrlResponse.baseUrl;
    final watchBottomNavigationList = !onlyEvents? null:ref.watch(mainBasicChangeProvider).getEventByUrlResponse.data![indexPass].tabs;
    // final webController = use
    return Scaffold(
      appBar: onlyEvents?AppBar(backgroundColor: Colors.white,
        centerTitle: true,
        titleSpacing: 20,
        leading: InkWell(
            onTap: (){
              Navigator.of(context).popUntil(ModalRoute.withName('/events'));
            },
            child: Icon(Icons.arrow_back_outlined,color: Colors.black,)),
        actions: [
          ref.watch(mainBasicChangeProvider).mainToken!=''?
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child:  ref.watch(mainBasicChangeProvider).isEventLoading || ref.watch(mainBasicChangeProvider).isProfileLoading   ?
            CircleAvatar(
              backgroundColor: NextizColors.secondaryColor,
              radius: 26,
            ):InkWell(onTap:()async{
              handleClick('Logout',context,ref);
            },
                child: CircleAvatar(
                  backgroundColor: NextizColors.secondaryColor,
                  radius:26,child: Icon(Icons.logout,color: Colors.white,),)
            ),
          ):SizedBox(width: 0,),

        ],
        title: Image.asset(
          'assets/nextiz_logo.png',
          color: Colors.black,
          width: 92,),
      ):null,
      bottomNavigationBar: onlyEvents?BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        currentIndex: mainSelectedIndex.value,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // onTap: (var i){
        //   mainSelectedIndex.value = i;
        // },
        items:  <BottomNavigationBarItem>[
          ...List.generate(watchBottomNavigationList!.length, (index) => BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                mainSelectedIndex.value = index;
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondaryMainWebView(
                  onlyEvents: true,
                  initialUrl: '${watchBottomNavigationList[index].link}',
                  indexPass: indexPass,selectedIndex: index,)));

              },

              child: Container(
                width: 30,
                height: 40,
                child: Column(
                  children: [
                    Image.network('$watchBaseUrl${watchBottomNavigationList[index].icon}'),
                    // Text('${watchBottomNavigationList[index].tabName}',
                    // style: TextStyle(color: mainSelectedIndex==index?Colors.black:Colors.grey),)
                  ],
                ),),
            ),

            // activeIcon:Container(),
            label: '${watchBottomNavigationList[index].tabName}',


          ), )
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.call),
          //   activeIcon:Icon(Icons.call),
          //   label: 'Calls',
          // ),
          // BottomNavigationBarItem(
          //   icon: Container(),
          //   activeIcon: Container(),
          //   label: 'Camera',
          // ),
        ],
      ):null,
      body: SafeArea(
        child: WebView(
          initialUrl: '$initialUrl',
          // https://flutter.dev
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            // _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            // _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller!.canGoBack()) {
                  await controller.goBack();
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller!.canGoForward()) {
                  await controller.goForward();
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('No forward history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay,color: Colors.white,),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller!.reload();
              },
            ),
          ],
        );
      },
    );
  }
}