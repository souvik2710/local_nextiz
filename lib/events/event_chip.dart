import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../common/properties/color.dart';

class EventChip extends HookConsumerWidget {
  final String chipText;
  final ValueNotifier<bool> isSwitched;
  EventChip({required this.chipText, required this.isSwitched});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
      child: GestureDetector(
        onTap: (){
          isSwitched.value = !isSwitched.value;
        },
        child: Chip(label: Text(
          '$chipText',style: TextStyle(
            fontWeight: FontWeight.w300,
            color:isSwitched.value? Colors.white:NextizColors.secondaryColor,
            fontSize: 13),),
          backgroundColor: isSwitched.value?NextizColors.secondaryColor:Colors.white,),
      ),
    );
  }
}
