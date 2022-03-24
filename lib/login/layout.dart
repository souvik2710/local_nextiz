import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nextiz/common/properties/color.dart';
import 'package:nextiz/webview/layout.dart';

import '../common/widgets/buttons.dart';
import '../common/widgets/text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../events/layout.dart';
import '../otp/layout.dart';
import '../view_model.dart';


class LoginPage extends  HookConsumerWidget{


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final emailController = useTextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
           // mainAxisSize: MainAxisSize.min,

          children: [
            Expanded(
              flex: 1,
                child: Container(
                  // color: Colors.red[100],
                 padding: EdgeInsets.all(12),
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   InkWell(onTap:(){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventListPage()));
                   },
                       child: Text('Skip',style: TextStyle(color: NextizColors.blueVariantColor,decoration: TextDecoration.underline),))
                ],

            ),)),
            Expanded(
              flex:3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    Text('Email\nRegistration',style: TextStyle(fontSize: 29,fontWeight: FontWeight.w500),),
                    Text('Please enter your official mail address. \n we will send you 4-digit code to verify account.',
                    style: TextStyle(fontSize: 13,),),

                  ],

                ),
              ),
            ),
            Expanded(
              flex:2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(),
                    Text('Enter your Business email address'),
                    CommonTextField(hintText: 'xyz@nextiz.com',textEditingController: emailController,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MainWebView(initialUrl: 'https://flutter.dev',)));
                      },
                      child: RichText(
                          text: TextSpan(
                          text: 'Please review our ',
                          style: TextStyle(color: NextizColors.secondaryColor,fontSize: 10),
                          children: [
                            TextSpan(text: 'Terms and condition policy',
                              style: TextStyle(decoration: TextDecoration.underline,color: NextizColors.blueVariantColor),),

                          ]
                        )

                      ),
                    )
                  ],
                ),
              ),
            ),
           Expanded(
             flex: 3,
             child: Container(
               child: Center(
                 child: SizedBox(
                   width:300,
                   height:40,
                   child: CommonWrapElevatedButtonWithIcon(
                     onbuttonPressed: () async{
                       await ref.read(mainBasicChangeProvider).vmGetOTPResponse(emailPass: "${emailController.text}");
                       final String otpString = ref.read(mainBasicChangeProvider).loginOtpModelResponse.otp.toString();
                       debugPrint("OTP ->>>> $otpString");
                       await ref.read(mainBasicChangeProvider).vmVerifyOTPResponse(emailPass: "${emailController.text}",otp: "$otpString");
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OtpPage()));
                     },
                     insideVerticalPadding: 20,
                     sizeType:14.0 , colorType:NextizColors.buttonColor,
                     buttonText: 'CONTINUE',
                     icon:  Icon(
                       Icons.arrow_forward,
                       color: Colors.white,
                       size: 24.0,
                     ),),
                 ),
               ),
             ),
           ),
            Expanded(flex:1,child: Container(
              padding: EdgeInsets.only(bottom: 10),
              // color: Colors.blue[100],
              color:Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Row(),
                  Text('2022 © Nextiz. All Rights Reserved.',
                    style: TextStyle(color: Color(0xffA4AABA),fontSize: 10
                    ),),
                  RichText(
                      text: TextSpan(
                          text: 'Powered by ',
                          style: TextStyle(color: Colors.black,fontSize: 10),
                          children: [
                            TextSpan(text: 'NVISH',style: TextStyle(fontWeight: FontWeight.w500)),
                          ]
                      )
                  ),
                ],
              ),
              // color: Colors.white,
            )),
          ],
        ),
      ),
    );
  }
}
