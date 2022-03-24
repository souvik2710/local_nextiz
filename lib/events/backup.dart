

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextiz/common/properties/color.dart';

import '../common/widgets/text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EventListPageBackup extends HookConsumerWidget {
  const EventListPageBackup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUpcoming = useState(true);
    final isRegistered = useState(false);
    final isPast = useState(false);

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
          actions: [
            CircleAvatar(backgroundColor: Colors.red,
              radius: 20,
            )
          ],
          title: Center(
            child: Image.asset(
              'assets/nextiz_logo.png',
              color: Colors.black,
              width: 92,),

          ),
        ),
        body: Column(
          children: [
            Expanded(flex: 4,child: Stack(
              // clipBehavior: Clip.hardEdge,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30,top: 42),
                  color: NextizColors.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.red[100],
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Enter \nevent link',style: TextStyle(fontSize: 29,fontWeight: FontWeight.w600,color: Colors.white,height: 1.2,),textAlign: TextAlign.start,
                            )),
                      ),
                      Text('Paste your link below to attend your session',style: TextStyle(color: Colors.white,
                          fontSize: 13),),

                    ],
                  ),
                ),
                // Positioned(
                //   // alignment: Alignment.bottomCenter,
                //   bottom: -16,
                //   child: Container(
                //     width: 344,
                //     padding: const EdgeInsets.symmetric(horizontal: 13.0),
                //     child: EventTextField(),
                //   ),
                // ),
              ],
            ),),
            Expanded(flex: 2,child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Expanded(flex:1,child: Container(color: Colors.red[100])),
                      Expanded(flex:1,child: Container(color: Colors.blue[100])),
                    ],
                  ),),
                // Expanded(flex:1,child: Container(color: Colors.blue[100])),
                Positioned(
                  // alignment: Alignment.center,
                  left: 20,
                  // bottom: 20,
                  child: Container(
                    width: 344,
                    height: 72,
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: EventTextField(),
                  ),
                ),
              ],
            ),),
            Expanded(flex: 9,child: Container(color: Colors.red[100],
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Events',style: TextStyle(fontSize: 21,fontWeight: FontWeight.w600),),
                  Row(
                    children: [
                      EventChip(chipText:'Upcoming' ,isSwitched: isUpcoming ,),
                      EventChip(chipText:'Registered' ,isSwitched: isRegistered ,),
                      EventChip(chipText:'Past' ,isSwitched: isPast ,),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context,index){
                        return Container(
                          height:256,
                          width: 349,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6,
                            color: Colors.green,
                            // shape: RoundedRectangleBorder(
                            //    borderRadius: BorderRadius.circular(20.0),
                            //  ),
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              child: Column(
                                children: [
                                  Expanded(flex: 1,child: Container(

                                    // child: Container(width: 92,height: 44,color: Colors.black,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage('https://cdn.pixabay.com/photo/2016/03/27/20/54/wedding-reception-1284245_1280.jpg'),

                                      ),
                                    ),
                                  ),

                                  ),
                                  Expanded(flex: 1,child:Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                                    ),

                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    // color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(),
                                        Text('Virtual',style: TextStyle(fontSize: 12),),
                                        Text('Hitachi Regional IT\nConference for Americas 2021',style: TextStyle(fontWeight: FontWeight.w700),),
                                        Text('March 27h & 28th, 2022',style: TextStyle(fontSize: 12),)
                                      ],
                                    ),
                                  ),

                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                    ),
                  )
                ],
              ),
            ),),
          ],
        )

    );
  }
}

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
