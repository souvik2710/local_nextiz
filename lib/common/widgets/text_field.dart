import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nextiz/common/properties/color.dart';

class CommonTextField extends StatelessWidget {
  final textEditingController;
  final hintText;
  final validator;
  final keyboardType;
  final inputFormatters;
  final prefixIcon;
  final labelText;
  final labelTextSize;
  final labelTextWeight;
  final labelTextColor;
  final textCapitalization;
  final onChanged;
  final onTap;
  final suffix;
  final bool readOnly;
  final autovalidate;
  final bool obscureText;

  CommonTextField({
    Key? key,
    this.textEditingController,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.labelText,
    this.labelTextSize = 14.0,
    this.labelTextWeight,
    this.labelTextColor,
    this.textCapitalization,
    this.onChanged,
    this.onTap,
    this.suffix,
    this.readOnly = false,
    this.autovalidate,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            // horizontal: 10.0
          ),
          child: TextFormField(
            autovalidateMode: autovalidate != null ? autovalidate : null,
            onChanged: onChanged,
            onTap: onTap,
            controller: textEditingController,
            textCapitalization: textCapitalization == null
                ? TextCapitalization.none
                : textCapitalization,
            readOnly: readOnly == null ? false : readOnly,
            obscureText: obscureText,
            decoration: InputDecoration(
              fillColor: Color(0xfff0f4f2),
              filled: true,
              contentPadding: EdgeInsets.all(10.0),
              // hintStyle: TextStyle(p),
              labelText: labelText,
              hintText: hintText,

              alignLabelWithHint: true,
              labelStyle: TextStyle(
                fontSize: labelTextSize,
                height: 1.5,
                color: Color(0xFF7e808c),
              ),
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color:NextizColors.buttonColor,
                // width: 0,
                // style: BorderStyle.none,
                ),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: NextizColors.buttonColor,
                  // width: 0,
                  // style: BorderStyle.none,
                ),
              ),
              errorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.red,
                  // width: 0,
                  // style: BorderStyle.none,
                ),
              ),
              // labelStyle: TextStyle(fontSize: 20),
              // contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            ),
            validator: validator,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}


void checkSubmitFunction(GlobalKey<FormState> _formKey ) {
  // final _formKey = GlobalKey<FormState>();
  final isValid = _formKey.currentState!.validate();
  if (!isValid) {
    return;
  }
  _formKey.currentState!.save();
}


void formSubmitFunction({required GlobalKey<FormState> formKey, required Function() submitFunction} ) {
  // final _formKey = GlobalKey<FormState>();
  final isValid = formKey.currentState!.validate();
  if (!isValid) {
    return;
  }else{
    submitFunction();
  }
  formKey.currentState!.save();
}

void changeControllerStateForError({required TextEditingController controller} ) {
  var c =  controller.text;
  controller.text = '';
  controller.text = c;
}


class EventTextField extends StatelessWidget {
  final textEditingController;
  final hintText;
  final validator;
  final keyboardType;
  final inputFormatters;
  final prefixIcon;
  final labelText;
  final labelTextSize;
  final labelTextWeight;
  final labelTextColor;
  final textCapitalization;
  final onChanged;
  final onTap;
  final suffix;
  final bool readOnly;
  final autovalidate;
  final bool obscureText;

  EventTextField({
    Key? key,
    this.textEditingController,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.labelText,
    this.labelTextSize = 14.0,
    this.labelTextWeight,
    this.labelTextColor,
    this.textCapitalization,
    this.onChanged,
    this.onTap,
    this.suffix,
    this.readOnly = false,
    this.autovalidate,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            // horizontal: 10.0
          ),
          child: TextFormField(
            autovalidateMode: autovalidate != null ? autovalidate : null,
            onChanged: onChanged,
            onTap: onTap,
            controller: textEditingController,
            textCapitalization: textCapitalization == null
                ? TextCapitalization.none
                : textCapitalization,
            readOnly: readOnly == null ? false : readOnly,
            obscureText: obscureText,
            decoration: InputDecoration(
             suffixIcon: ElevatedButton(
               child: Icon(Icons.arrow_forward,size: 25,color: Colors.white,),
              style: ElevatedButton.styleFrom(
              primary: NextizColors.secondaryColor,
                  // side: BorderSide(width: 1.0, color: colorType,),
                  onPrimary: Colors.white,
                  // onPrimary: isDark? isMobile ? Colors.white : Colors.white: Color(0xff518dd1),
                  shadowColor: Colors.black.withOpacity(0.5),
                  // padding: EdgeInsets.symmetric(vertical: insideVerticalPadding,horizontal: insideHorizontalPadding),
                  shape:RoundedRectangleBorder(
                  borderRadius:  BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
                  ),

                  elevation: 4,
                  ),
              onPressed: (){},
              ),
    //           suffix: IconButton(
    //           onPressed: (){},
    // icon: Icon(Icons.clear),
    // ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.all(10.0),
              // hintStyle: TextStyle(p),
              labelText: labelText,
              hintText: hintText,

              alignLabelWithHint: true,
              labelStyle: TextStyle(
                fontSize: labelTextSize,
                height: 1.5,
                color: Color(0xFF7e808c),
              ),
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color:NextizColors.buttonColor,
                  // width: 0,
                  // style: BorderStyle.none,
                ),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: NextizColors.buttonColor,
                  // width: 0,
                  // style: BorderStyle.none,
                ),
              ),
              errorBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.red,
                  // width: 0,
                  // style: BorderStyle.none,
                ),
              ),
              // labelStyle: TextStyle(fontSize: 20),
              // contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            ),
            validator: validator,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }
}