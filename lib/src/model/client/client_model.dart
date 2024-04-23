// To parse this JSON data, do
//
//     final clientModel = clientModelFromJson(jsonString);

import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  bool status;
  List<ClientResult> data;

  ClientModel({
    required this.status,
    required this.data,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    status: json["status"],
    data: List<ClientResult>.from(json["data"].map((x) => ClientResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ClientResult {
  int id;
  String name;
  String agentName;
  int agentId;
  String idT;
  String izoh;
  String manzil;
  String tel;
  int tp;
  int idNarh;
  int idFaol;
  String idFaolName;
  int idKlass;
  String idKlassName;
  int idAgent;
  int sms;
  dynamic vaqt;
  int idHodimlar;
  int naqd;
  String pas;
  int d1;
  int d2;
  int d3;
  int d4;
  int h1;
  int h2;
  int h3;
  int h4;
  int h5;
  int h6;
  int h7;
  String muljal;
  int st;
  num osK;
  num osKS;

  ClientResult({
    required this.id,
    required this.name,
    required this.idT,
    required this.izoh,
    required this.manzil,
    required this.tel,
    required this.tp,
    required this.idNarh,
    required this.idFaol,
    required this.idKlass,
    required this.idAgent,
    required this.sms,
    required this.vaqt,
    required this.idHodimlar,
    required this.naqd,
    required this.pas,
    required this.d1,
    required this.d2,
    required this.d3,
    required this.d4,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.h7,
    required this.muljal,
    required this.st,
    this.idKlassName = '',
    this.idFaolName = '',
    this.agentName = '',
    this.osK = 0.0,
    this.osKS = 0.0,
    this.agentId = 0,
  });

  factory ClientResult.fromJson(Map<String, dynamic> json) => ClientResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idT: json["ID_T"]??"",
    izoh: json["IZOH"]??"",
    manzil: json["MANZIL"]??"",
    tel: json["TEL"]??"",
    tp: json["TP"]??0,
    idNarh: json["ID_NARH"]??0,
    idFaol: json["ID_FAOL"]??0,
    idKlass: json["ID_KLASS"]??0,
    idAgent: json["ID_AGENT"]??0,
    sms: json["SMS"]??0,
    vaqt: json["VAQT"] == null?DateTime.now():DateTime.parse(json["VAQT"]),
    idHodimlar: json["ID_HODIMLAR"]??0,
    naqd: json["NAQD"]??0,
    pas: json["PAS"]??0,
    d1: json["D1"]??0,
    d2: json["D2"]??0,
    d3: json["D3"]??0,
    d4: json["D4"]??0,
    h1: json["H1"]??0,
    h2: json["H2"]??0,
    h3: json["H3"]??0,
    h4: json["H4"]??0,
    h5: json["H5"]??0,
    h6: json["H6"]??0,
    h7: json["H7"]??0,
    muljal: json["MULJAL"]??"",
    st: json["ST"]??0,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "ID_T": idT,
    "IZOH": izoh,
    "MANZIL": manzil,
    "TEL": tel,
    "TP": tp,
    "ID_NARH": idNarh,
    "ID_FAOL": idFaol,
    "ID_FAOL_NAME": idFaolName,
    "ID_KLASS": idKlass,
    "ID_KLASS_NAME": idKlassName,
    "ID_AGENT": idAgent,
    "SMS": sms,
    "VAQT": vaqt.toIso8601String(),
    "ID_HODIMLAR": idHodimlar,
    "NAQD": naqd,
    "PAS": pas,
    "D1": d1,
    "D2": d2,
    "D3": d3,
    "D4": d4,
    "H1": h1,
    "H2": h2,
    "H3": h3,
    "H4": h4,
    "H5": h5,
    "H6": h6,
    "H7": h7,
    "MULJAL": muljal,
    "ST": st,
  };
}
