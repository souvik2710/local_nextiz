import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nextiz/common/properties/color.dart';
import 'package:nextiz/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nextiz/splash/layout.dart';

import 'events/layout.dart';
import 'events/sliver_layout.dart';
import 'login/demo.dart';
import 'login/layout.dart';
import 'otp/layout.dart';

void main() {
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

