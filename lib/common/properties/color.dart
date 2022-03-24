

import 'package:flutter/material.dart';

class NextizColors {
  static const Color buttonColor = Color(0xff0a5b62);
  static const Color splashColor = Color(0xff03393e);
  static const Color primaryColor = Color(0xff03393E);
  static const Color secondaryColor = Color(0xff0a5b62);
  static const Color blueVariantColor = Color(0xff179BD7);
  static const Color greenLight = Color(0xffF0F4F2);

}

class HexColor extends Color {
  //this converts hex #ddddd to color
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}