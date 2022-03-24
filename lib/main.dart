import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nextiz/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nextiz/splash/layout.dart';

import 'events/layout.dart';
import 'login/demo.dart';
import 'login/layout.dart';
import 'otp/layout.dart';

void main() {
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
      ),
      onGenerateRoute: (settings) =>
          AppRouter.onGenerateRoute(settings),
      home:SplashScreen(),
      // home:Globals.tempToken!.isNotEmpty?StaffMainPage():LoginMainPage(),

    );
  }
}

