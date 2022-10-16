import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nextiz/common/properties/color.dart';
import 'package:nextiz/events/sliver_layout.dart';
import 'package:nextiz/webview/layout.dart';

import '../common/widgets/buttons.dart';
import '../common/widgets/text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../events/layout.dart';
import '../otp/layout.dart';
import '../routes.dart';
import '../view_model.dart';


class LoginPage extends  HookConsumerWidget{


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final emailController = useTextEditingController();
    ref.watch(mainBasicChangeProvider).mainToken!='';
    final isContinueButtonEnabled = useState(true);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
             // mainAxisSize: MainAxisSize.min,

            children: [
              Expanded(
                flex: 2,
                  child: GestureDetector(
                    onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SliverEventListPage()));
                      Navigator.of(context).pushNamed(AppRoutes.events);
                      // Navigator.of(context).pushNamed(AppRoutes.addEditPreorder,arguments: {"id":0,"formState": "new"});
                    },
                    child: Container(

                      // color: Colors.red[100],
                     padding: EdgeInsets.all(12),
                     child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       Container(
                         width: 40,
                           child: Text('Skip',style: TextStyle(color: NextizColors.blueVariantColor,decoration: TextDecoration.underline),))
                    ],

              ),),
                  )),
              Expanded(
                flex:3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(),
                      Text('Email\nRegistration',style: TextStyle(fontSize: 29,fontWeight: FontWeight.w500),),
                      Text('Please enter your official mail address. \n we will send you 6-digit code to verify account.',
                      style: TextStyle(fontSize: 13,),),

                    ],

                  ),
                ),
              ),
              Expanded(
                flex:3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(),
                      Text('Enter your business email address'),
                      CommonTextField(hintText: 'xyz@nextiz.com',textEditingController: emailController,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')),
                        // ],
                        // autovalidate: AutovalidateMode.onUserInteraction,
                        onTap:(){
                          // isContinueButtonEnabled.value = true;
                        },
                        validator: (text) {
                          String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = new RegExp(p);
                          // return regExp.hasMatch(em);
                          if(regExp.hasMatch(text.toString().trim())){
                            return null;

                          }else{
                            return "Please enter a valid email address";
                          }
                            // if (text.length <5 ) {
                            //   return "Please enter a valid Email Address";
                            // }
                            // return null;
                          //souvik.das@nvish.com, souvikdas2710@gmail.com
                        },
                      ),
                      RichText(
                          text: TextSpan(
                          text: 'By signing in you agree to the  ',
                          style: TextStyle(color: NextizColors.secondaryColor,fontSize: 11),
                          children: [
                            WidgetSpan(child:InkWell(
                              onTap:(){
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MainWebView(initialUrl: 'https://flutter.dev',)));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context)=> MainWebView(initialUrl: 'https://www.nextiz.com/privacy-policy/',)));
                              },
                              child: Text('Privacy policy',
                                style: TextStyle(decoration: TextDecoration.underline,color: NextizColors.blueVariantColor,fontSize: 11),
                              ),
                            ),),
                            TextSpan(text: ' and the\n',
                              // style: TextStyle(decoration: TextDecoration.underline,color: NextizColors.blueVariantColor),
                            ),
                            WidgetSpan(child:InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MainWebView(initialUrl: 'https://www.nextiz.com/terms-of-use/',)));
                              },
                              child: Text('Terms of use',
                                style: TextStyle(decoration: TextDecoration.underline,color: NextizColors.blueVariantColor,fontSize: 11),),
                            ),),

                          ]
                        )

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
                     child: isContinueButtonEnabled.value?CommonWrapElevatedButtonWithIcon(
                       onbuttonPressed: () async{
                         final isValid = _formKey.currentState!.validate();
                         if (!isValid) {
                           return;
                         } else {
                           isContinueButtonEnabled.value = false;
                           await ref.read(mainBasicChangeProvider).vmGetOTPResponse(emailPass: "${emailController.text.toString().trim()}");
                           final String otpString = ref.read(mainBasicChangeProvider).loginOtpModelResponse.otp.toString();
                           debugPrint("OTP ->>>> $otpString");
                           if( ref.read(mainBasicChangeProvider).loginOtpModelResponse.status ==200) {
                             await ref.read(mainBasicChangeProvider).vmVerifyOTPResponse(emailPass: "${emailController.text.toString().trim()}", otp: "$otpString");
                             //CHANGING THE LOADING BUTTON BACK TO ORIGINAL STATE SO THAT LOADING STOPS ON BACK FROM PREVIOUS PAGE
                             isContinueButtonEnabled.value = true;
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpPage(otpPass: "${emailController.text.toString().trim()}",
                             )));
                           }else{
                             isContinueButtonEnabled.value = true;
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: const Duration(seconds: 4),content: new Text(" Email not exist!")));

                           }
                         }
                         _formKey.currentState!.save();
                       },
                       insideVerticalPadding: 20,
                       sizeType:14.0 , colorType:NextizColors.buttonColor,
                       buttonText: 'CONTINUE',
                       icon:  Icon(
                         Icons.arrow_forward,
                         color: Colors.white,
                         size: 24.0,
                       ),):
                     CommonWrapElevatedButtonWithIcon(
                       // isEnabled: false,
                       onbuttonPressed: () {},
                       insideVerticalPadding: 20,
                       sizeType:14.0 , colorType:NextizColors.buttonColor,
                       buttonText: ' ',
                       icon:  Center(child: CircularProgressIndicator(color: Colors.white,),),),
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
      ),
    );
  }
}
