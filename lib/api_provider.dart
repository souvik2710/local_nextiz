import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/get_all_events_model.dart';
import 'models/login_model.dart';
import 'package:http/http.dart' as http;

import 'models/otp_verification_model.dart';

final apiServiceProvider = Provider<ApiProvider>((ref) {
  return ApiProvider();
});

class ApiProvider {
  Ref? ref;
  // ApiProvider(this.ref){
  // }

  String STAGING_URL = "https://api-dev.nextiz.com/api/v1/";

  Future<LoginOtpModel> getOTPResponse(String email) async {
    final thisUrl = "${STAGING_URL}loginWithOtp";
    final response = await http.post(Uri.parse(thisUrl),
        body: jsonEncode({
          "email": "$email"
        }),
        headers: {
          "content-type": "application/json",
        }
    );
    debugPrint('%%%%%%%%%%%%%%$response%%%%%');
    debugPrint("${STAGING_URL}loginWithOtp");
    final responseString = jsonDecode(response.body);
    debugPrint('########$responseString########');
    debugPrint('${response.statusCode}');
    if (response.statusCode == 200) {
      debugPrint('%%%%%%%%%%${response.statusCode}%%%%%%%%%%');
      return LoginOtpModel.fromJson(responseString);
    } else {
      throw Exception('failed to load details of all tours');
    }
  }

  Future<OtpVerificationModel> verifyOTPResponse(String email,String otp) async {
    final thisUrl = "${STAGING_URL}verifyLoginOtp";
    final response = await http.post(Uri.parse(thisUrl),
        body: jsonEncode({
          "email": "$email",
          "otp" : "$otp"
        }),
        headers: {
          "content-type": "application/json",
        }
    );
    debugPrint('%%%%%%%%%%%%%%$response%%%%%');
    debugPrint("${STAGING_URL}verifyLoginOtp");
    final responseString = jsonDecode(response.body);
    debugPrint('########$responseString########');
    debugPrint('${response.statusCode}');
    if (response.statusCode == 200) {
      debugPrint('%%%%%%%%%%${response.statusCode}%%%%%%%%%%');
      return OtpVerificationModel.fromJson(responseString);
    } else {
      throw Exception('failed to load details of all tours');
    }
  }

  Future<GetAllEvents> getAllEvents() async {
    final thisUrl = "${STAGING_URL}getAllEvents";
    final response = await http.get(Uri.parse(thisUrl),
        headers: Globals.apiHeaders
    );
    debugPrint('%%%%%%%%%%%%%%$response%%%%%');
    debugPrint("${STAGING_URL}getAllEvents");
    final responseString = jsonDecode(response.body);
    debugPrint('########$responseString########');
    debugPrint('${response.statusCode}');
    if (response.statusCode == 200) {
      debugPrint('%%%%%%%%%%${response.statusCode}%%%%%%%%%%');
      return GetAllEvents.fromJson(responseString);
    } else {
      throw Exception('failed to load details of all events');
    }
  }

}


class Globals{
  static Map<String, String> apiHeaders ={
    'content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer 43|62wHZkUf5hJYm0BYI18JoTR3UMGjeXptrABUszvx',
  };
}
// 32|lgn5juQsA1fbNwRQp7KFdSeogt4LLlYix8lIAgsR