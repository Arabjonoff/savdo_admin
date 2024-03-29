// To parse this JSON data, do
//
//     final workerModel = workerModelFromJson(jsonString);

import 'dart:convert';

WorkerModel workerModelFromJson(String str) => WorkerModel.fromJson(json.decode(str));

String workerModelToJson(WorkerModel data) => json.encode(data.toJson());

class WorkerModel {
  bool status;
  List<WorkerResult> data;

  WorkerModel({
    required this.status,
    required this.data,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
    status: json["status"],
    data: List<WorkerResult>.from(json["data"].map((x) => WorkerResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WorkerResult {
  int id;
  String name;
  String fio;
  String tel;
  int tip;
  String pas;
  num oklad;
  num oylik;
  int skl;
  int idSkl;
  int st;
  String shtr;
  int sms;
  dynamic vaqt;

  WorkerResult({
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

  factory WorkerResult.fromJson(Map<String, dynamic> json) => WorkerResult(
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
    vaqt: json["VAQT"] == null?DateTime.now():DateTime.parse(json["VAQT"]),
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
    "VAQT": vaqt.toIso8601String(),
  };
}
