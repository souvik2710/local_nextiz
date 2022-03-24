import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'api_provider.dart';
import 'models/get_all_events_model.dart';
import 'models/login_model.dart';
import 'models/otp_verification_model.dart';


final mainBasicChangeProvider = ChangeNotifierProvider<MainBasicResponse>((ref){
  return MainBasicResponse(ref:ref);
});


class MainBasicResponse extends ChangeNotifier{
  Ref? ref;
  ApiProvider? repo;
  bool isLoading = false;
  bool isEventLoading = false;
  dynamic error;
  // dynamic myAddDefaultCouponResponse;
  late LoginOtpModel loginOtpModelResponse;
  late GetAllEvents getAllEventsResponse;
  late OtpVerificationModel otpVerificationResponse;
  // EditFormDefaultCouponModel myEFDefaultCouponResponse=EditFormDefaultCouponModel(msg: "", status: '', response: null);


  MainBasicResponse({this.ref}) {
    repo = ref!.read(apiServiceProvider);
  }

  Future<void> vmGetOTPResponse({
    required String emailPass
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      loginOtpModelResponse = await repo!.getOTPResponse(emailPass);
      debugPrint('3OOOOOO3OOOO');
      debugPrint('@@@@@${loginOtpModelResponse.message}');
      error = null;
    }
    catch (e) {
      error = e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
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


//ALWAYS COMMENT TRY CATCH WHILE FETCHING NEW DATA , TO FIND ERORR
//AND ALSO MARK Initial String with String? so that null data can be handled

}
GlobalKey<ScaffoldState> globalKeyDiscounts = GlobalKey<ScaffoldState>();
final discountTabIndexStateProvider = StateProvider<int>((ref) => 0);
final discountTabNameStateProvider = StateProvider<String>((ref) => '');