// To parse this JSON data, do
//
//     final getCity = getCityFromJson(jsonString);

import 'dart:convert';

GetCity getCityFromJson(String str) => GetCity.fromJson(json.decode(str));

String getCityToJson(GetCity data) => json.encode(data.toJson());

class GetCity {
  bool error;
  List<Datum> data;

  GetCity({
    required this.error,
    required this.data,
  });

  factory GetCity.fromJson(Map<String, dynamic> json) => GetCity(
    error: json["error"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String name;
  String stateId;
  DateTime createdAt;

  Datum({
    required this.id,
    required this.name,
    required this.stateId,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "created_at": createdAt.toIso8601String(),
  };
}
