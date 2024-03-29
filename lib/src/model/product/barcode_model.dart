// To parse this JSON data, do
//
//     final barcodeModel = barcodeModelFromJson(jsonString);

import 'dart:convert';

BarcodeModel barcodeModelFromJson(String str) => BarcodeModel.fromJson(json.decode(str));

String barcodeModelToJson(BarcodeModel data) => json.encode(data.toJson());

class BarcodeModel {
  bool status;
  List<BarcodeResult> data;

  BarcodeModel({
    required this.status,
    required this.data,
  });

  factory BarcodeModel.fromJson(Map<String, dynamic> json) => BarcodeModel(
    status: json["status"],
    data: json["data"]==null?[]:List<BarcodeResult>.from(json["data"].map((x) => BarcodeResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BarcodeResult {
  int id;
  String name;
  String shtr;
  int idSkl2;
  dynamic vaqt;

  BarcodeResult({
    required this.id,
    required this.name,
    required this.shtr,
    required this.idSkl2,
    required this.vaqt,
  });

  factory BarcodeResult.fromJson(Map<String, dynamic> json) => BarcodeResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    shtr: json["SHTR"]??"",
    idSkl2: json["ID_SKL2"]??0,
    vaqt: json["VAQT"] == null?DateTime.now():DateTime.parse(json["VAQT"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "SHTR": shtr,
    "ID_SKL2": idSkl2,
    "VAQT": vaqt.toIso8601String(),
  };
}
