// To parse this JSON data, do
//
//     final getSkladModel = getSkladModelFromJson(jsonString);

import 'dart:convert';

GetSkladPerModel getSkladModelFromJson(String str) => GetSkladPerModel.fromJson(json.decode(str));

String getSkladModelToJson(GetSkladPerModel data) => json.encode(data.toJson());

class GetSkladPerModel {
  bool status;
  List<GetSkladPerResult> data;

  GetSkladPerModel({
    required this.status,
    required this.data,
  });

  factory GetSkladPerModel.fromJson(Map<String, dynamic> json) => GetSkladPerModel(
    status: json["status"],
    data: List<GetSkladPerResult>.from(json["data"].map((x) => GetSkladPerResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetSkladPerResult {
  int idSkl2;

  GetSkladPerResult({
    required this.idSkl2,
  });

  factory GetSkladPerResult.fromJson(Map<String, dynamic> json) => GetSkladPerResult(
    idSkl2: json["ID_SKL2"]??0,
  );

  Map<String, dynamic> toJson() => {
    "ID_SKL2": idSkl2,
  };
}
