import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nextiz/api_provider.dart';
import 'package:nextiz/common/properties/color.dart';
import 'package:nextiz/events/backup.dart';
import 'package:pinput/pinput.dart';

import '../events/layout.dart';
import '../view_model.dart';


class PinPutView extends StatefulHookConsumerWidget {
  final TextEditingController textEditingController ;
  // final String exactOtp;
  PinPutView({required this.textEditingController});

  @override
  PinPutViewState createState() => PinPutViewState();
}

class PinPutViewState extends ConsumerState<PinPutView> {
  
  // final pinPutController = pinPutController;
  // final _pinPutController2 = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // final correctOtp = ref.watch(mainBasicChangeProvider).loginOtpModelResponse.otp.toString();
    // final pinPutController = widget.textEditingController;
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10),
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          child: Column(
               // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                darkRoundedPinPut()
                // Expanded(child: darkRoundedPinPut()),
                // Expanded(child: animatedBorders())
              ]),
        );
  }

  Widget darkRoundedPinPut() {
    final defaultPinTheme = PinTheme(
      // padding: EdgeInsets.symmetric(vertical: 90),
      // margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: 62,
      height: 62,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: NextizColors.secondaryColor),
    //   borderRadius: BorderRadius.circular(8),
    // );
    final focusedPinTheme = defaultPinTheme.copyWith(
      textStyle: defaultPinTheme.textStyle!.copyWith(

      ),
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
        border: Border.all(color: NextizColors.secondaryColor),
      ),
    );
    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      color: Colors.red,
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme =  defaultPinTheme.copyWith(
      textStyle: defaultPinTheme.textStyle!.copyWith(
      color: Colors.white
      ),
      decoration: defaultPinTheme.decoration!.copyWith(
        color: NextizColors.secondaryColor,
        border: Border.all(color: NextizColors.secondaryColor),
      ),
    );
    final followingPinTheme = defaultPinTheme.copyWith(
      textStyle: defaultPinTheme.textStyle!.copyWith(

      ),
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Pinput(
      length: 6,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onSubmitted: (String pin) {
        _showSnackBar(pin);
      },
      validator: (s) {
        if(s!.length==6){
          debugPrint("OTPPIN ->>>>${ref.read(mainBasicChangeProvider).loginOtpModelResponse.otp}***");
          debugPrint("ssss ->>>>$s***");
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventListPage()));
        }

        if(s.length==6 && s==ref.read(mainBasicChangeProvider).loginOtpModelResponse.otp.toString()){

         final fetchedHeader = ref.read(mainBasicChangeProvider).otpVerificationResponse.token;
         Globals.apiHeaders ={
           'content-Type': 'application/json',
           'Accept': 'application/json',
           'Authorization': 'Bearer $fetchedHeader',
         };
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventListPage()));
         return null;
        }else{
          return'Pin is incorrect';
        }
        // return s == '2222' ? null : 'Pin is incorrect';
        // if(s == '2222')
      },
      // wi: 50.0,
      // eachFieldHeight: 50.0,
      // withCursor: true,
      // fieldsCount: 5,
      controller: widget.textEditingController,
      // eachFieldMargin: EdgeInsets.symmetric(horizontal: 10),
      // onSubmit: (String pin) => _showSnackBar(pin),
      submittedPinTheme: submittedPinTheme,
      focusedPinTheme: focusedPinTheme,
      followingPinTheme: followingPinTheme,
      errorPinTheme: errorPinTheme,
      pinAnimationType: PinAnimationType.rotation,
      // textStyle: TextStyle(color: Colors.white,
      //     fontSize: 20.0,
      //     height: 1),
    );
  }

  // Widget animatedBorders() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Pinput(
  //       fieldsCount: 4,
  //       eachFieldHeight: 50.0,
  //       withCursor: true,
  //       onSubmit: (String pin) => _showSnackBar(pin),
  //       controller: _pinPutController2,
  //       submittedFieldDecoration: BoxDecoration(
  //         border: Border.all(color: Colors.black),
  //         borderRadius: BorderRadius.circular(15.0),
  //       ).copyWith(
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //       selectedFieldDecoration: BoxDecoration(
  //         color: Colors.green,
  //         border: Border.all(color: Colors.black),
  //         borderRadius: BorderRadius.circular(15.0),
  //       ),
  //       followingFieldDecoration: BoxDecoration(
  //         border: Border.all(color: Colors.black),
  //         borderRadius: BorderRadius.circular(15.0),
  //       ).copyWith(
  //         borderRadius: BorderRadius.circular(5.0),
  //         border: Border.all(
  //           color: Colors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showSnackBar(String pin) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 4),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted: $pin',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}




class AnimatedBorders extends StatelessWidget {
  const AnimatedBorders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

          // PinPut({
          // Key? key,
          // required int fieldsCount,
          // void Function(String)? onSubmit,
          // void Function(String?)? onSaved,
          // void Function(String)? onChanged,
          // void Function()? onTap,
          // void Function(String?)? onClipboardFound,
          // TextEditingController? controller,
          // FocusNode? focusNode,
          // Widget? preFilledWidget,
          // List<int> separatorPositions = const [],
          // Widget separator = const SizedBox(width: 15.0),
          // TextStyle? textStyle,
          // BoxDecoration? submittedFieldDecoration,
          // BoxDecoration? selectedFieldDecoration,
          // BoxDecoration? followingFieldDecoration,
          // BoxDecoration? disabledDecoration,
          // double? eachFieldWidth,
          // double? eachFieldHeight,
          // MainAxisAlignment fieldsAlignment = MainAxisAlignment.spaceBetween,
          // AlignmentGeometry eachFieldAlignment = Alignment.center,
          // EdgeInsetsGeometry? eachFieldMargin,
          // EdgeInsetsGeometry? eachFieldPadding,
          // BoxConstraints eachFieldConstraints = const BoxConstraints(minHeight: 40.0,
          // minWidth: 40.0),
          // InputDecoration? inputDecoration,
          // Curve animationCurve = Curves.linear,
          // Duration animationDuration = const Duration(milliseconds: 160),
          // PinAnimationType pinAnimationType = PinAnimationType.slide,
          // Offset? slideTransitionBeginOffset,
          // bool enabled = true,
          // bool checkClipboard = false,
          // bool useNativeKeyboard = true,
          // bool autofocus = false,
          // AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
          // bool withCursor = false,
          // Widget? cursor,
          // Brightness? keyboardAppearance,
          // List<TextInputFormatter>? inputFormatters,
          // String? Function(String?)? validator,
          // TextInputType keyboardType = TextInputType.number,
          // String? obscureText,
          // TextCapitalization textCapitalization = TextCapitalization.none,
          // TextInputAction? textInputAction,
          // ToolbarOptions? toolbarOptions = const ToolbarOptions(paste: true),
          // MainAxisSize mainAxisSize = MainAxisSize.max,
          // Iterable<String>? autofillHints,
          // bool enableIMEPersonalizedLearning = true,
          // String? initialValue,
          // SmartDashesType? smartDashesType,
          // SmartQuotesType? smartQuotesType,
          // bool enableSuggestions = true,
          // MaxLengthEnforcement? maxLengthEnforcement,
          // void Function()? onEditingComplete,
          // double cursorWidth = 2,
          // double? cursorHeight,
          // Radius? cursorRadius,
          // Color? cursorColor,
          // bool enableInteractiveSelection = true,
          // TextSelectionControls? selectionControls,
          // Widget? Function(BuildContext, {required int currentLength,
          // required bool isFocused,
          // required int? maxLength})? buildCounter,
          // String? restorationId
          // })
