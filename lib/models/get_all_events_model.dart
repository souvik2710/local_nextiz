// To parse this JSON data, do
//
//     final getAllEvents = getAllEventsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAllEvents getAllEventsFromJson(String str) => GetAllEvents.fromJson(json.decode(str));

String getAllEventsToJson(GetAllEvents data) => json.encode(data.toJson());

class GetAllEvents {
  GetAllEvents({
    required this.status,
    required this.message,
    required this.errorMessage,
    required this.data,
  });

  int status;
  String? message;
  String? errorMessage;
  List<Datum>? data;

  factory GetAllEvents.fromJson(Map<String?, dynamic> json) => GetAllEvents(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    errorMessage: json["error_message"] == null ? null : json["error_message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "error_message": errorMessage == null ? null : errorMessage,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.eventType,
    required this.eventBanner,
    required this.eventTiming,
    required this.previewUrl,
  });

  int id;
  String? title;
  String? eventType;
  String? eventBanner;
  String? eventTiming;
  String? previewUrl;

  factory Datum.fromJson(Map<String?, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    eventType: json["event_type"] == null ? null : json["event_type"],
    eventBanner: json["event_banner"] == null ? null : json["event_banner"],
    eventTiming: json["event_timing"] == null ? null : json["event_timing"],
    previewUrl: json["preview_url"] == null ? null : json["preview_url"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "event_type": eventType == null ? null : eventType,
    "event_banner": eventBanner == null ? null : eventBanner,
    "event_timing": eventTiming == null ? null : eventTiming,
    "preview_url": previewUrl == null ? null : previewUrl,
  };
}
