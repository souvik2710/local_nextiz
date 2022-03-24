// To parse this JSON data, do
//
//     final otpVerificationModel = otpVerificationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OtpVerificationModel otpVerificationModelFromJson(String str) => OtpVerificationModel.fromJson(json.decode(str));

String otpVerificationModelToJson(OtpVerificationModel data) => json.encode(data.toJson());

class OtpVerificationModel {
  OtpVerificationModel({
    required this.status,
    required this.message,
    required this.token,
    required this.errorMessage,
  });

  int status;
  String message;
  String token;
  String errorMessage;

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) => OtpVerificationModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    token: json["token"] == null ? null : json["token"],
    errorMessage: json["error_message"] == null ? null : json["error_message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "token": token == null ? null : token,
    "error_message": errorMessage == null ? null : errorMessage,
  };
}
