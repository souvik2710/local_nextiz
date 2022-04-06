import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'api_provider.dart';
import 'models/get_all_events_model.dart';
import 'models/get_event_by_url.dart';
import 'models/login_model.dart';
import 'models/otp_verification_model.dart';
import 'models/profile_model.dart';


final mainBasicChangeProvider = ChangeNotifierProvider<MainBasicResponse>((ref){
  return MainBasicResponse(ref:ref);
});


class MainBasicResponse extends ChangeNotifier{
  Ref? ref;
  ApiProvider? repo;
  bool isLoading = false;
  bool isEventLoading = false;
  bool isProfileLoading = false;
  dynamic error;
  // dynamic myAddDefaultCouponResponse;
  late LoginOtpModel loginOtpModelResponse;
  late GetAllEvents getAllEventsResponse;
  late GetAllEvents duplicateGetAllEventsResponse;

  late GetEventByUrl getEventByUrlResponse;
   // GetAllEvents getAllEventsResponse = GetAllEvents(status: status, message: message, errorMessage: errorMessage, data: data);
  late OtpVerificationModel otpVerificationResponse;
  late ProfileModel profileModelResponse;
  String mainToken ='';
   // ProfileModel profileModelResponse = ProfileModel(status: 1000, message: '', errorMessage: '', data: null);
  // EditFormDefaultCouponModel myEFDefaultCouponResponse=EditFormDefaultCouponModel(msg: "", status: '', response: null);


  MainBasicResponse({this.ref}) {
    repo = ref!.read(apiServiceProvider);
  }

  Future<void> vmGetOTPResponse({
    required String emailPass
  }) async {
    // try {
      isLoading = true;
      notifyListeners();
      loginOtpModelResponse = await repo!.getOTPResponse(emailPass);
      // debugPrint('3OOOOOO3OOOO');
      debugPrint('@@@@@${loginOtpModelResponse.message}');
      // error = null;
    // }
    // catch (e) {
    //   error = e;
    // } finally {
    //   isLoading = false;
      notifyListeners();
    // }
  }

  Future<void> vmVerifyOTPResponse({
    required String emailPass, required String otp
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      otpVerificationResponse = await repo!.verifyOTPResponse(emailPass,otp);
      debugPrint('3OOOOOO3OOOO');
      debugPrint('@@@@@${otpVerificationResponse.message}');
      error = null;
    }
    catch (e) {
      error = e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> vmGetAllEvents() async {
    try {
      isEventLoading = true;
      notifyListeners();
      getAllEventsResponse = await repo!.getAllEvents();
      duplicateGetAllEventsResponse = GetAllEvents.fromJson(jsonDecode(jsonEncode(getAllEventsResponse)));
      debugPrint('3OOOOOO3OOOO');
      debugPrint('@@@@@${getAllEventsResponse.message}');
      debugPrint('ccccccc  ${getAllEventsResponse.message}');
      error = null;
    }
    catch (e) {
      error = e;
    } finally {
      if(getAllEventsResponse.message!=null && getAllEventsResponse.message!='' ){
        debugPrint('ccccccc  ${getAllEventsResponse.message}');
        debugPrint('ccccccc  ${getAllEventsResponse.data!.length}');
        isEventLoading = false;
      }

      notifyListeners();
    }
  }

  Future<void> vmGetProfile() async {
    try {
      isProfileLoading = true;
    // profileModelResponse.data!.avatar = 'https://s.pngkit.com/png/small/202-2024572_png-file-svg-profile-icon-vector-png.png';
      notifyListeners();
      profileModelResponse = await repo!.getProfile();
      debugPrint('3OOOOOO3OOOO');
      debugPrint('PROFILE @@@@@${profileModelResponse.data!.avatar}');
      error = null;
    }
    catch (e) {
      error = e;
      debugPrint("ERROR -->>>>>>>>>$e");
    } finally {
      isProfileLoading = false;
      notifyListeners();
     }
  }


  Future<void> sortEventsBasedOnDates({required String filterValue}) async {
    getAllEventsResponse = GetAllEvents.fromJson(jsonDecode(jsonEncode(duplicateGetAllEventsResponse)));
    getAllEventsResponse.data = getAllEventsResponse.data!.where((e) {
      String splitOne = e.eventTiming!.substring(0,19);
      final aDateTimeStart = DateTime.parse('$splitOne');
      final nowDateTime = DateTime.now();
      // debugPrint('Start-->$dateStart And subtract --> ${aDateTimeStart.millisecondsSinceEpoch- nowDateTime.millisecondsSinceEpoch}');
      int subtractDateValue = aDateTimeStart.millisecondsSinceEpoch- nowDateTime.millisecondsSinceEpoch;
      debugPrint('filter value ---->$filterValue SUB-->$subtractDateValue');
      if(filterValue=='Upcoming'){
        return subtractDateValue>0;
      }else if(filterValue=='Past'){
        return subtractDateValue<0;
      }else{
        return (subtractDateValue>0 || subtractDateValue<=0);
      }
    } ).toList();
    // getAllEventsResponse.data!.where((e) => DateTime.parse('${e.eventTiming!.substring(0,19)}').millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch > 0).toList();
    getAllEventsResponse.data!.forEach((e) {
      debugPrint('MStart-->${e.eventTiming!.substring(0,19)} And subtract -->');
    });
      //debugPrint('Start-->$dateStart And subtract --> ${aDateTimeStart.millisecondsSinceEpoch- nowDateTime.millisecondsSinceEpoch}');
      notifyListeners();

  }


  Future<void> vmGetEventsByEventUrl(String eventUrl) async {
    try {
      // isEventLoading = true;
      // notifyListeners();
      getEventByUrlResponse = await repo!.getEventsByEventUrl(eventUrl);
      debugPrint('4OOOOOO4OOOO');
      debugPrint('@@@@@${getEventByUrlResponse.message}');
      error = null;
    }
    catch (e) {
      error = e;
      debugPrint("$e ERROR");
    } finally {
      // if(getAllEventsResponse.message!=null && getAllEventsResponse.message!='' ){
      //   debugPrint('ccccccc  ${getAllEventsResponse.message}');
      //   debugPrint('ccccccc  ${getAllEventsResponse.data!.length}');
      //   isEventLoading = false;
      // }

      // notifyListeners();
    }
  }



  Future<void> deleteLoginToken() async {
  mainToken = '';
    notifyListeners();
    // }
  }

//ALWAYS COMMENT TRY CATCH WHILE FETCHING NEW DATA , TO FIND ERORR
//AND ALSO MARK Initial String with String? so that null data can be handled

}
GlobalKey<ScaffoldState> globalKeyDiscounts = GlobalKey<ScaffoldState>();
final discountTabIndexStateProvider = StateProvider<int>((ref) => 0);
final discountTabNameStateProvider = StateProvider<String>((ref) => '');

final sortingSelect =  StateProvider<int>((ref) => 0);
final mainWebViewLinkStateProvider = StateProvider<String>((ref) => '');