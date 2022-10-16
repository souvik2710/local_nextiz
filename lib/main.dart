import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nextiz/common/properties/color.dart';
import 'package:nextiz/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nextiz/splash/layout.dart';
import 'package:nextiz/view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_provider.dart';
import 'events/layout.dart';
import 'events/sliver_layout.dart';
import 'login/demo.dart';
import 'login/layout.dart';
import 'otp/layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  var localToken = sharedPreferences.getString('bearerToken')??'';
  Map<String, String> apiLiteHeader = {
      'content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': localToken!=''?'Bearer $localToken':'',
  };
  Globals.apiHeaders = apiLiteHeader;
  // ref.read(mainBasicChangeProvider).
  print(localToken);
  print('CCC->${Globals.apiHeaders['Authorization']}');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: NextizColors.primaryColor,
    //   systemNavigationBarDividerColor:Colors.blue,
    // systemNavigationBarColor: Colors.lightGreen,
    // statusBarBrightness: Brightness.dark,// status bar color
    //   statusBarIconBrightness:Brightness.dark,
  ));
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    String myLocalToken ='';
    useEffect(() {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        myFunction() async{
          final sharedPreferences = await SharedPreferences.getInstance();
          myLocalToken = sharedPreferences.getString('bearerToken')??'';
          ref.read(mainBasicChangeProvider).mainToken = myLocalToken;
        };
        myFunction();
      });
      return () {
        // your dispose code
      };
    }, []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // builder: EasyLoading.init(),
      title: 'Nextiz App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        // primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          // backwardsCompatibility: false, // 1
          systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        ),
      ),
      onGenerateRoute: (settings) =>
          AppRouter.onGenerateRoute(settings),
      home:SplashScreen(),
      // home:Globals.tempToken!.isNotEmpty?StaffMainPage():LoginMainPage(),

    );
  }
}

