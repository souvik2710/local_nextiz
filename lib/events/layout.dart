

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nextiz/common/properties/color.dart';

import '../common/widgets/text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../models/get_all_events_model.dart';
import '../view_model.dart';
import '../webview/layout.dart';
import 'event_chip.dart';
import 'package:intl/src/intl/date_format.dart';
class EventListPage extends HookConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allEventsProvider = ref.watch(mainBasicChangeProvider);
    useEffect(() {
      ref.read(mainBasicChangeProvider).isEventLoading = true;
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        ref.read(mainBasicChangeProvider).vmGetAllEvents();
      });
      return () {
        // your dispose code
      };
    }, []);

    final isUpcoming = useState(true);
    final isRegistered = useState(false);
    final isPast = useState(false);
    final List<Datum>? listDatum = ref.watch(mainBasicChangeProvider).isEventLoading?[]:ref.watch(mainBasicChangeProvider).getAllEventsResponse.data;


    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: Colors.white,
          centerTitle: true,
          titleSpacing: 20,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 26,
                backgroundImage: NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
              ),
            )
          ],
          title: Image.asset(
            'assets/nextiz_logo.png',
            color: Colors.black,
            width: 92,),
        ),
        body: Column(
          children: [
            Expanded(flex: 5,child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Expanded(flex: 4,child: Container(
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
                      ),),
                      // Expanded(flex:1,child: Container(color: Colors.red[100])),
                      Expanded(flex:1,child: Container(color: NextizColors.greenLight)),
                    ],
                  ),),
                // Expanded(flex:1,child: Container(color: Colors.blue[100])),
                Positioned(
                  // alignment: Alignment.center,
                  left: 14,
                  bottom: 14,
                  child: Container(
                    width: 344,
                    height: 72,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: EventTextField(hintText: 'Event Link',),
                  ),
                ),
              ],
            ),),
            allEventsProvider.isEventLoading? Expanded(flex:9,child: Center(child: CircularProgressIndicator())):Expanded(flex: 9,child: Container(
              // color: Colors.red[100],
              color: NextizColors.greenLight,
              padding: EdgeInsets.symmetric(horizontal: 0,vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Events',style: TextStyle(fontSize: 21,fontWeight: FontWeight.w600),),
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        EventChip(chipText:'Upcoming' ,isSwitched: isUpcoming ,),
                        EventChip(chipText:'Registered' ,isSwitched: isRegistered ,),
                        EventChip(chipText:'Past' ,isSwitched: isPast ,),
                      ],
                    ),
                  ),
                  Expanded(
                    // child: Text('${listDatum!.length}'),
                    child: ListView.separated(
                      itemCount: listDatum!.length,
                      itemBuilder: (context,index){
                        return EventCardWidget(datum: listDatum[index],);

                      },
                      shrinkWrap: true, separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 20,);
                    },
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

class EventCardWidget extends StatelessWidget {
final Datum datum;
EventCardWidget({required this.datum});

  @override
  Widget build(BuildContext context) {
    final String imageLink = 'https://events-dev-ecs.nextiz.com'+'${datum.eventBanner}';
    // https://cdn.pixabay.com/photo/2016/03/27/20/54/wedding-reception-1284245_1280.jpg
    String splitOne = datum.eventTiming!.substring(0,19);
    String splitTwo = datum.eventTiming!.substring(22,41);
    debugPrint('Split 1->$splitOne');
    debugPrint('Split 2->$splitTwo');
    final dateStart = DateFormat('dd MMMM').format(DateTime.parse('$splitOne'));
    final timeStart = DateFormat('HH:mm a').format(DateTime.parse('$splitOne'));
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainWebView(initialUrl: '${datum.previewUrl}',)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
        height:256,
        width: 349,
        decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.circular(20),
          boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(flex: 1,child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),

                    // image: DecorationImage(
                    //   fit: BoxFit.fill,
                    //   image: NetworkImage('$imageLink'),

                    // ),
                  ),
                  child: CachedNetworkCustom(imageUrl: '$imageLink',),
                ),
                Align(
                  alignment:Alignment.bottomLeft,
                    child: Container(width: 92,height: 50,color: Colors.black,
                    padding:EdgeInsets.only(top:2),
                     child: Center(
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Text('$dateStart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                          Text('$timeStart',style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),)),
              ],
            ),

            ),
            Expanded(flex: 1,child:Container(
              decoration: BoxDecoration(
                // color: Colors.green[100],
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              ),

              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(),
                  Text('${datum.eventType}',style: TextStyle(fontSize: 12),),
                  Text('${datum.title}',style: TextStyle(fontWeight: FontWeight.w700),),
                  Text('March 27h & 28th, 2022',style: TextStyle(fontSize: 12),)
                  // '${datum.title}\nConference for Americas 2021'
                ],
              ),
            ),

            )
          ],
        ),
      ),
    );
  }
}

class CachedNetworkCustom extends StatelessWidget {
final String imageUrl;
CachedNetworkCustom({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$imageUrl",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color: Colors.black,
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
             ),
        ),
      ),
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('https://images.poshvine.com/b/default-thumbnail-image.jpg'),
            ),
          )
          )
          // Container(child: Image.network('http://via.placeholder.com/200x150')),
    );
  }
}

