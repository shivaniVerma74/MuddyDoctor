// To parse this JSON data, do
//
//     final getData = getDataFromJson(jsonString);

import 'dart:convert';
GetData getDataFromJson(String str) => GetData.fromJson(json.decode(str));
String getDataToJson(GetData data) => json.encode(data.toJson());
class GetData {
  bool error;
  String message;
  List<Map<String, String?>> data;

  GetData({
    required this.error,
    required this.message,
    required this.data,
  });

  factory GetData.fromJson(Map<String, dynamic> json) => GetData(
    error: json["error"],
    message: json["message"],
    data: List<Map<String, String?>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
