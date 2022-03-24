// To parse this JSON data, do
//
//     final loginOtpModel = loginOtpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginOtpModel loginOtpModelFromJson(String str) => LoginOtpModel.fromJson(json.decode(str));

String loginOtpModelToJson(LoginOtpModel data) => json.encode(data.toJson());

class LoginOtpModel {
  LoginOtpModel({
    required this.status,
    required this.message,
    required this.user,
    required this.token,
    required this.otp,
    required this.errorMessage,
  });

  int status;
  String message;
  User? user;
  String token;
  int otp;
  String errorMessage;

  factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"] == null ? null : json["token"],
    otp: json["otp"] == null ? null : json["otp"],
    errorMessage: json["error_message"] == null ? null : json["error_message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "user": user == null ? null : user!.toJson(),
    "token": token == null ? null : token,
    "otp": otp == null ? null : otp,
    "error_message": errorMessage == null ? null : errorMessage,
  };
}

class User {
  User({
    required this.id,
    required this.parentId,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.avatar,
    required this.featuredImage,
    required this.status,
    required this.isAdmin,
    required this.isVoice,
    required this.otp,
    required this.otpStatus,
    required this.otpCreateDatetime,
    required this.providerId,
    required this.provider,
    required this.accessToken,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.loginStatus,
    required this.deviceDetails,
  });

  int id;
  int parentId;
  String name;
  dynamic username;
  String email;
  dynamic role;
  String avatar;
  dynamic featuredImage;
  String status;
  int isAdmin;
  int isVoice;
  int otp;
  int otpStatus;
  DateTime? otpCreateDatetime;
  dynamic providerId;
  dynamic provider;
  dynamic accessToken;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int loginStatus;
  String deviceDetails;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    name: json["name"] == null ? null : json["name"],
    username: json["username"],
    email: json["email"] == null ? null : json["email"],
    role: json["role"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    featuredImage: json["featured_image"],
    status: json["status"] == null ? null : json["status"],
    isAdmin: json["is_admin"] == null ? null : json["is_admin"],
    isVoice: json["is_voice"] == null ? null : json["is_voice"],
    otp: json["otp"] == null ? null : json["otp"],
    otpStatus: json["otp_status"] == null ? null : json["otp_status"],
    otpCreateDatetime: json["otp_create_datetime"] == null ? null : DateTime.parse(json["otp_create_datetime"]),
    providerId: json["provider_id"],
    provider: json["provider"],
    accessToken: json["access_token"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    loginStatus: json["login_status"] == null ? null : json["login_status"],
    deviceDetails: json["device_details"] == null ? null : json["device_details"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "parent_id": parentId == null ? null : parentId,
    "name": name == null ? null : name,
    "username": username,
    "email": email == null ? null : email,
    "role": role,
    "avatar": avatar == null ? null : avatar,
    "featured_image": featuredImage,
    "status": status == null ? null : status,
    "is_admin": isAdmin == null ? null : isAdmin,
    "is_voice": isVoice == null ? null : isVoice,
    "otp": otp == null ? null : otp,
    "otp_status": otpStatus == null ? null : otpStatus,
    "otp_create_datetime": otpCreateDatetime == null ? null : otpCreateDatetime!.toIso8601String(),
    "provider_id": providerId,
    "provider": provider,
    "access_token": accessToken,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "login_status": loginStatus == null ? null : loginStatus,
    "device_details": deviceDetails == null ? null : deviceDetails,
  };
}
