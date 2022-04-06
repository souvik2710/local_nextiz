// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString?);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.status,
    required this.message,
    required this.errorMessage,
    required this.baseUrl,
    required this.data,
  });

  int? status;
  String? message;
  String? errorMessage;
  String? baseUrl;
  Data? data;

  factory ProfileModel.fromJson(Map<String?, dynamic> json) => ProfileModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    errorMessage: json["error_message"] == null ? null : json["error_message"],
    baseUrl: json["base_url"] == null ? null : json["base_url"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String?, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "error_message": errorMessage == null ? null : errorMessage,
    "base_url": baseUrl == null ? null : baseUrl,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.name,
    required this.email,
    required this.avatar,
  });

  String? name;
  String? email;
  String? avatar;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    avatar: json["avatar"] == null ? null : json["avatar"],
  );

  Map<String?, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "avatar": avatar == null ? null : avatar,
  };
}
