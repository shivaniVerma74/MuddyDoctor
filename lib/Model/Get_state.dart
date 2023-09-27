// To parse this JSON data, do
//
//     final getState = getStateFromJson(jsonString);

import 'dart:convert';

GetState getStateFromJson(String str) => GetState.fromJson(json.decode(str));

String getStateToJson(GetState data) => json.encode(data.toJson());

class GetState {
  bool error;
  List<Datum> data;

  GetState({
    required this.error,
    required this.data,
  });

  factory GetState.fromJson(Map<String, dynamic> json) => GetState(
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
  String countryId;

  Datum({
    required this.id,
    required this.name,
    required this.countryId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
  };
}
