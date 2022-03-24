import 'package:flutter/material.dart';
import 'package:nextiz/common/properties/color.dart';
import 'package:nextiz/common/widgets/main_logo.dart';

import '../view_model.dart';
import 'otp_main_component.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class OtpPage extends HookConsumerWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final correctOtp = ref.read(mainBasicChangeProvider).loginOtpModelResponse.otp;
    final otpController = useTextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex:2,child: Container(
            color: NextizColors.primaryColor,
            child: NextizLogo(width: 127,),
          )),
          Expanded(flex:8,child: Container(
            color: NextizColors.primaryColor,
            child: Container(
              padding: EdgeInsets.only(left: 30,right:30,top: 40),
              decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
              color: Colors.white,
              // color: Colors.red[500]!,
              ),
              borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20))

              ),
              child: Column(
                children: [
                  Expanded(flex:4,child: Container(
                    // color: Colors.red[100],
                    color: Colors.white,
                    child: Align(
                       alignment: Alignment.topLeft,
                        child: Text('OTP \nVerify!',style: TextStyle(fontSize: 29),textAlign: TextAlign.start,)),
                  )
                  ),
                  Expanded(flex:3,child: Container(
                    // color: Colors.blue[100],
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter 6-digit code we have sent to at',style: TextStyle(color: NextizColors.secondaryColor,
                        fontSize: 13),),
                        Row(
                          children: [
                            Text('xyz@nextiz.com',style: TextStyle(color: Colors.blue,decoration:TextDecoration.underline,fontSize: 13),),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(Icons.edit,color: NextizColors.primaryColor,size: 20,),
                                ))
                          ],
                        )
                      ],

                    ),
                  )),
                  Expanded(flex:6,child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 12),
                    // margin: EdgeInsets.symmetric(horizontal: 12),
                    // color: Colors.red[100],
                    color: Colors.white,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(children: [],),
                       PinPutView(textEditingController: otpController),
                       Container(
                         width: double.infinity,
                         child: RichText(

                             text: TextSpan(
                                 text: 'Did`t get code? ',
                                 style: TextStyle(color: NextizColors.secondaryColor,fontSize: 13),
                                 children: [
                                   TextSpan(text: 'Resend code',style: TextStyle(decoration: TextDecoration.underline,
                                   color: NextizColors.blueVariantColor)),
                                   TextSpan()
                                 ]
                             )

                         ),
                       ),
                     ],
                   ),
                  )),
                  Expanded(flex:8,child: Container(
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
          )),
        ],
      ),
    );
  }
}
