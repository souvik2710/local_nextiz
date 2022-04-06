import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nextiz/events/layout.dart';
import 'package:nextiz/webview/part_web_view.dart';

import '../common/properties/color.dart';
import '../common/widgets/pop_up_actions_appbar.dart';
import '../view_model.dart';
import 'layout.dart';


class MainEventWebLayout extends HookConsumerWidget {
  final String initialUrl;
  int indexPass;
  int selectedIndex;
  MainEventWebLayout({required this.initialUrl,this.indexPass=0, this.selectedIndex =0});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final boolCheck = useState(true);
    final mainSelectedIndex = useState(selectedIndex);
    final watchBaseUrl =ref.watch(mainBasicChangeProvider).getAllEventsResponse.baseUrl;
    final watchBottomNavigationList =ref.watch(mainBasicChangeProvider).getAllEventsResponse.data![indexPass].tabs;
    final initialUrlMain = useState('${watchBottomNavigationList![0].link}');
    final initialIndexMain = useState(0);
    final checkWebUrl = useState('${watchBottomNavigationList[0].link}');
    // final webViewLink = ref.watch(mainWebViewLinkStateProvider.state);

    // if(boolCheck.value){
    //   webViewLink.state = '${watchBottomNavigationList[0].link}';
    //   boolCheck.value = false;
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,
        titleSpacing: 20,
        actions: [
          ref.watch(mainBasicChangeProvider).mainToken!=''?  PopUpAppBar(passWidget:  Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child:  ref.watch(mainBasicChangeProvider).isEventLoading || ref.watch(mainBasicChangeProvider).isProfileLoading   ?
            CircleAvatar(
              backgroundColor: NextizColors.secondaryColor,
              radius: 26,
            ):CachedNetworkCircle(imageUrl: '${ref.watch(mainBasicChangeProvider).profileModelResponse.data!.avatar}',),
          ),buildContext: context,):SizedBox(width: 0,)

        ],
        title: Image.asset(
          'assets/nextiz_logo.png',
          color: Colors.black,
          width: 92,),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          ...List.generate(watchBottomNavigationList.length, (index) => BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                mainSelectedIndex.value = index;
                initialUrlMain.value = '${watchBottomNavigationList[index].link}';
                initialIndexMain.value = index;
                debugPrint('kkk${mainSelectedIndex.value} kkk ${watchBottomNavigationList[index].link}');
                // ref.read(mainWebViewLinkStateProvider.state).state = '${watchBottomNavigationList[index].link}';
                checkWebUrl.value = '${watchBottomNavigationList[index].link}';
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainWebView(
                //   initialUrl: '${watchBottomNavigationList[index].link}',
                //   indexPass: indexPass,selectedIndex: index,)));
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

        ],
      ),
      body:PartWebView(
        initialUrl:checkWebUrl
      ),
    );
  }
}
