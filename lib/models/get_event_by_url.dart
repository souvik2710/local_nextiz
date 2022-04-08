// To parse this JSON data, do
//
//     final getEventByUrl = getEventByUrlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'get_all_events_model.dart';

GetEventByUrl getEventByUrlFromJson(String str) => GetEventByUrl.fromJson(json.decode(str));

String getEventByUrlToJson(GetEventByUrl data) => json.encode(data.toJson());

class GetEventByUrl {
  GetEventByUrl({
    required this.status,
    required this.message,
    required this.errorMessage,
    required this.baseUrl,
    required this.data,
  });

  int status;
  String? message;
  String? errorMessage;
  String? baseUrl;
  List<Datum>? data;

  factory GetEventByUrl.fromJson(Map<String?, dynamic> json) => GetEventByUrl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    errorMessage: json["error_message"] == null ? null : json["error_message"],
    baseUrl: json["base_url"] == null ? null : json["base_url"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String?, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "error_message": errorMessage == null ? null : errorMessage,
    "base_url": baseUrl == null ? null : baseUrl,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

// class Datum {
//   Datum({
//     required this.id,
//     required this.title,
//     required this.eventType,
//     required this.eventBanner,
//     required this.eventTiming,
//     required this.previewUrl,
//     required this.registered,
//     required this.tabs,
//   });
//
//   int id;
//   String? title;
//   String? eventType;
//   dynamic eventBanner;
//   String? eventTiming;
//   String? previewUrl;
//   bool registered;
//   List<Tab>? tabs;
//
//   factory Datum.fromJson(Map<String?, dynamic> json) => Datum(
//     id: json["id"] == null ? null : json["id"],
//     title: json["title"] == null ? null : json["title"],
//     eventType: json["event_type"] == null ? null : json["event_type"],
//     eventBanner: json["event_banner"],
//     eventTiming: json["event_timing"] == null ? null : json["event_timing"],
//     previewUrl: json["preview_url"] == null ? null : json["preview_url"],
//     registered: json["registered"] == null ? null : json["registered"],
//     tabs: json["tabs"] == null ? null : List<Tab>.from(json["tabs"].map((x) => Tab.fromJson(x))),
//   );
//
//   Map<String?, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "title": title == null ? null : title,
//     "event_type": eventType == null ? null : eventType,
//     "event_banner": eventBanner,
//     "event_timing": eventTiming == null ? null : eventTiming,
//     "preview_url": previewUrl == null ? null : previewUrl,
//     "registered": registered == null ? null : registered,
//     "tabs": tabs == null ? null : List<dynamic>.from(tabs!.map((x) => x.toJson())),
//   };
// }
//
// class Tab {
//   Tab({
//     required this.link,
//     required this.icon,
//     required this.tabName,
//   });
//
//   String? link;
//   String? icon;
//   String? tabName;
//
//   factory Tab.fromJson(Map<String?, dynamic> json) => Tab(
//     link: json["link"] == null ? null : json["link"],
//     icon: json["icon"] == null ? null : json["icon"],
//     tabName: json["tabName"] == null ? null : json["tabName"],
//   );
//
//   Map<String?, dynamic> toJson() => {
//     "link": link == null ? null : link,
//     "icon": icon == null ? null : icon,
//     "tabName": tabName == null ? null : tabName,
//   };
// }
