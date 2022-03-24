import 'package:flutter/material.dart';


class NextizLogo extends StatelessWidget {
NextizLogo({required this.width});
 final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/nextiz_logo.png',
        width: width,),
    );
  }
}