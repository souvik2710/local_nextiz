import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/src/hooks.dart';



class CommonWrapElevatedButtonWithIcon extends HookConsumerWidget {
  bool isCapsule;
  String buttonText;
  Function()? onbuttonPressed;
  double insideVerticalPadding;
  double insideHorizontalPadding;
  double outSidePadding;
  double sizeType;
  Color colorType;
  Widget? icon;
  bool isEnabled;
  //isMobile, insideVerticalPadding, outSidePadding are optional
  //CommonElevatedButton

  CommonWrapElevatedButtonWithIcon({
    this.isEnabled = true,
    this.isCapsule = false,
    required this.buttonText,
    required this.onbuttonPressed,
    this.insideVerticalPadding = 18.0,
    this.insideHorizontalPadding = 18.0,
    this.outSidePadding = 5.0,
    required this.sizeType,
    required this.colorType,
    required this.icon,
  });
// DineOrderColors.buttonOrangeColor
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final colorState = useState(colorType);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: outSidePadding),
      child:  buttonText!= ''?ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: colorState.value,
          side: BorderSide(width: 1.0, color: colorType,),
          onPrimary: Colors.white,
          // onPrimary: isDark? isMobile ? Colors.white : Colors.white: Color(0xff518dd1),
          shadowColor: Colors.black.withOpacity(0.5),
          // padding: EdgeInsets.symmetric(vertical: insideVerticalPadding,horizontal: insideHorizontalPadding),
          shape:RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(20.0),
          ),

          elevation: 4,
        ),
        onHover:(bool v){
          // colorState.value = Colors.white;
        },
        // focusNode: ,
        onFocusChange: (var v){
          // colorState.value = colorType;
          colorState.value = Colors.white;
        },
        onPressed:isEnabled? onbuttonPressed:null,
        icon:  Text(
          '$buttonText',
          overflow: TextOverflow.ellipsis,
          // softWrap: false,
          style: TextStyle(
            fontFamily: "proxima",
            fontSize: sizeType,
          ),
        ) ,

        label:icon!,
      ):Visibility(
        visible: true,
        child: Container(
          width: 20,
          color: Colors.white,
          padding : const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.6),
          child: icon,
        ),
      ),
    );
  }
}