import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nextiz/login/layout.dart';

import '../events/layout.dart';
import '../events/sliver_layout.dart';
import '../otp/layout.dart';
import '../splash/layout.dart';


class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: Container(color: Colors.green[100],)),
          Expanded(child: Container(color: Colors.white,child: SliverEventListPage(),)),
          Expanded(child: Container(color: Colors.green[100],))
        ],
      ),
    );
  }
}


