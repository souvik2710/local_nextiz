import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../common/properties/color.dart';
import '../view_model.dart';

class EventChip extends HookConsumerWidget {
  final String chipText;
  final ValueNotifier<bool> isSwitched;
  int indexValue;
  final ValueNotifier<int> isMainSwitched;

  EventChip({required this.chipText, required this.isSwitched,required this.indexValue,required this.isMainSwitched});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sorting = ref.watch(sortingSelect.state);
    final isCheck = useState(false);
    return Padding(
      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 4),
      child: GestureDetector(
        onTap: ()async{
          await ref.read(mainBasicChangeProvider).sortEventsBasedOnDates(filterValue: "$chipText");
          // sortEventsBasedOnDates
          // isSwitched.value = !isSwitched.value;
          isMainSwitched.value = indexValue;
          sorting.state = indexValue;
          isCheck.value = !isCheck.value;
        },
        child: Chip(label: Text(
          '$chipText',style: TextStyle(
            fontWeight: FontWeight.w300,
            color: isMainSwitched.value == indexValue? Colors.white:NextizColors.secondaryColor,
            fontSize: 13),),
          backgroundColor: isMainSwitched.value == indexValue?NextizColors.secondaryColor:Colors.white,),
      ),
    );
  }
}
