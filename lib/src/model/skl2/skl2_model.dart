// To parse this JSON data, do
//
//     final skl2BaseModel = skl2BaseModelFromJson(jsonString);

import 'dart:convert';

Skl2BaseModel skl2BaseModelFromJson(String str) => Skl2BaseModel.fromJson(json.decode(str));

String skl2BaseModelToJson(Skl2BaseModel data) => json.encode(data.toJson());

class Skl2BaseModel {
  bool status;
  List<Skl2Result> skl2Result;

  Skl2BaseModel({
    required this.status,
    required this.skl2Result,
  });

  factory Skl2BaseModel.fromJson(Map<String, dynamic> json) => Skl2BaseModel(
    status: json["status"],
    skl2Result: List<Skl2Result>.from(json["data"].map((x) => Skl2Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(skl2Result.map((x) => x.toJson())),
  };
}

class Skl2Result {
  int id;
  String name;
  String tipName;
  String firmName;
  String edizName;
  int idTip;
  int idFirma;
  int idEdiz;
  String photo;
  num vz;
  num msoni;
  int st;
  Skl2Result({
    required this.id,
    required this.name,
    required this.idTip,
    required this.idFirma,
    required this.idEdiz,
    required this.photo,
    required this.vz,
    required this.msoni,
    required this.st,
    required this.tipName,
    required this.firmName,
    required this.edizName,
  });

  factory Skl2Result.fromJson(Map<String, dynamic> json) => Skl2Result(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idTip: json["ID_TIP"]??0,
    idFirma: json["ID_FIRMA"]??0,
    idEdiz: json["ID_EDIZ"]??0,
    photo: json["PHOTO"]??"",
    vz: json["VZ"]??0.0,
    msoni: json["MSONI"]??0.0,
    st: json["ST"]??0,
    tipName: json["tipName"]??"",
    firmName:json["firmName"]??"",
    edizName: json["edizName"]??"",
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "ID_TIP": idTip,
    "ID_FIRMA": idFirma,
    "ID_EDIZ": idEdiz,
    "PHOTO": photo,
    "VZ": vz,
    "MSONI": msoni,
    "ST": st,
    "tipName": tipName,
    "firmName": firmName,
    "edizName": edizName,
  };
}
