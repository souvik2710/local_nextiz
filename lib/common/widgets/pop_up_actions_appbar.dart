import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nextiz/login/layout.dart';

import '../../api_provider.dart';
import '../../view_model.dart';

class PopUpAppBar extends HookConsumerWidget {
final Widget passWidget;
final BuildContext buildContext;
PopUpAppBar({required this.passWidget, required this.buildContext});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return   PopupMenuButton<String>(
      child: passWidget,
      tooltip: '', /*very important line removing tooltip=----> "Show Menu" */
      enabled: true,
      offset: const Offset(10, 56),
      // onSelected: handleClick('Logout',context),
      itemBuilder: (BuildContext context) {
        return {'Logout'}.map((String choice) {
          return PopupMenuItem<String>(
            onTap: (){
              handleClick('Logout',buildContext,ref);
            },
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
void handleClick(String value,BuildContext context,WidgetRef ref) async{
  switch (value) {
    case 'Logout':
      Globals.apiHeaders ={
        'content-Type': 'application/json',

      };
      Future<void>.delayed(
          const Duration(),
      () {
        ref.read(mainBasicChangeProvider).deleteLoginToken();
        return Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              (Route<dynamic> route) => route is LoginPage
        );
      },
      );
      // Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (BuildContext context) => SingleShowPage()),
      //         (Route<dynamic> route) => route is HomePage
      // );
      break;
    default:
      break;
    // case 'Settings':
    //   break;
  }
}