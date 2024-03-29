// To parse this JSON data, do
//
//     final agentsModel = agentsModelFromJson(jsonString);

import 'dart:convert';

AgentsModel agentsModelFromJson(String str) => AgentsModel.fromJson(json.decode(str));

String agentsModelToJson(AgentsModel data) => json.encode(data.toJson());

class AgentsModel {
  bool status;
  List<AgentsResult> data;

  AgentsModel({
    required this.status,
    required this.data,
  });

  factory AgentsModel.fromJson(Map<String, dynamic> json) => AgentsModel(
    status: json["status"],
    data: List<AgentsResult>.from(json["data"].map((x) => AgentsResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AgentsResult {
  int id;
  String name;
  String fio;
  String tel;
  int tip;
  String pas;
  int oklad;
  int oylik;
  int skl;
  int idSkl;
  int st;
  String shtr;
  int? sms;
  dynamic vaqt;

  AgentsResult({
    required this.id,
    required this.name,
    required this.fio,
    required this.tel,
    required this.tip,
    required this.pas,
    required this.oklad,
    required this.oylik,
    required this.skl,
    required this.idSkl,
    required this.st,
    required this.shtr,
    required this.sms,
    required this.vaqt,
  });

  factory AgentsResult.fromJson(Map<String, dynamic> json) => AgentsResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    fio: json["FIO"]??"",
    tel: json["TEL"]??"",
    tip: json["TIP"]??0,
    pas: json["PAS"]??0,
    oklad: json["OKLAD"]??0,
    oylik: json["OYLIK"]??0,
    skl: json["SKL"]??0,
    idSkl: json["ID_SKL"]??0,
    st: json["ST"]??0,
    shtr: json["SHTR"]??"",
    sms: json["SMS"]??0,
    vaqt: json["VAQT"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "FIO": fio,
    "TEL": tel,
    "TIP": tip,
    "PAS": pas,
    "OKLAD": oklad,
    "OYLIK": oylik,
    "SKL": skl,
    "ID_SKL": idSkl,
    "ST": st,
    "SHTR": shtr,
    "SMS": sms,
    "VAQT": vaqt.toString(),
  };
}
