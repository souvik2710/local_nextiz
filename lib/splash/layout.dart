import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nextiz/common/properties/color.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/src/hooks.dart';

import '../api_provider.dart';
import '../common/widgets/main_logo.dart';
import '../events/sliver_layout.dart';
import '../login/layout.dart';
import '../routes.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    useEffect(() {
      // ref.read(posChangeProvider).isCurrentOrderLoading = true;
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        // Navigator.of(context).pushNamed(AppRoutes.events);
        // Timer(Duration(seconds:3), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:
        //     (context) {
        //   return Globals.apiHeaders['Authorization']!=''?SliverEventListPage():LoginPage();
        //        }
        //      )
        //    )
        // );
        Timer(Duration(seconds:3), ()=>Navigator.pushReplacementNamed(context,
            Globals.apiHeaders['Authorization']!=''?
        AppRoutes.events:AppRoutes.login,
            )
        );
      });
      return () {
        // your dispose code
      };
    }, []);
    return Scaffold(body:
      Container(
       color: NextizColors.splashColor,
       child: Column(
         children: [
           Expanded(flex:6,child: NextizLogo(width: 200,), ),
           Expanded(flex:1,child: Center(
             child: Text('Your Virtual Event Partner',style: TextStyle(color: Colors.white,fontSize: 17,),),
           ), )

         ],
       ),
     ) );
  }
}


