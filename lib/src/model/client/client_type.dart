// To parse this JSON data, do
//
//     final clientTypeModel = clientTypeModelFromJson(jsonString);

import 'dart:convert';

ClientTypeModel clientTypeModelFromJson(String str) => ClientTypeModel.fromJson(json.decode(str));

String clientTypeModelToJson(ClientTypeModel data) => json.encode(data.toJson());

class ClientTypeModel {
  bool status;
  List<ClientTypeResult> data;

  ClientTypeModel({
    required this.status,
    required this.data,
  });

  factory ClientTypeModel.fromJson(Map<String, dynamic> json) => ClientTypeModel(
    status: json["status"],
    data: List<ClientTypeResult>.from(json["data"].map((x) => ClientTypeResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ClientTypeResult {
  int id;
  String name;
  int st;

  ClientTypeResult({
    required this.id,
    required this.name,
    required this.st,
  });

  factory ClientTypeResult.fromJson(Map<String, dynamic> json) => ClientTypeResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    st: json["ST"]??0,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "ST": st,
  };
}
