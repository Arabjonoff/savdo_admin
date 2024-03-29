// To parse this JSON data, do
//
//     final incomeModel = incomeModelFromJson(jsonString);

import 'dart:convert';

IncomeModel incomeModelFromJson(String str) => IncomeModel.fromJson(json.decode(str));

String incomeModelToJson(IncomeModel data) => json.encode(data.toJson());

class IncomeModel {
  List<IncomeResult> data;

  IncomeModel({
    required this.data,
  });

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
    data: List<IncomeResult>.from(json["data"].map((x) => IncomeResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class IncomeResult {
  int id;
  String name;
  String idT;
  DateTime sana;
  String ndoc;
  String izoh;
  num sm;
  num smS;
  num smT;
  num smTS;
  num har;
  num harS;
  int idHodim;
  int pr;
  String yil;
  String oy;
  int idSkl;
  DateTime vaqt;
  List<SklPrTovResult> sklPrTov;

  IncomeResult({
    required this.id,
    required this.name,
    required this.idT,
    required this.sana,
    required this.ndoc,
    required this.izoh,
    required this.sm,
    required this.smS,
    required this.smT,
    required this.smTS,
    required this.har,
    required this.harS,
    required this.idHodim,
    required this.pr,
    required this.yil,
    required this.oy,
    required this.idSkl,
    required this.vaqt,
    required this.sklPrTov,
  });

  factory IncomeResult.fromJson(Map<String, dynamic> json) => IncomeResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idT: json["ID_T"]??"",
    sana: json["SANA"] == null ?DateTime.now():DateTime.parse(json["SANA"]),
    ndoc: json["NDOC"]??"",
    izoh: json["IZOH"]??"",
    sm: json["SM"]??0.0,
    smS: json["SM_S"]??0.0,
    smT: json["SM_T"]??0.0,
    smTS: json["SM_T_S"]??0.0,
    har: json["HAR"]??0.0,
    harS: json["HAR_S"]??0.0,
    idHodim: json["ID_HODIM"]??0,
    pr: json["PR"]??0,
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    idSkl: json["ID_SKL"]??0,
    vaqt: json["VAQT"] == null?DateTime.now():DateTime.parse(json["VAQT"]),
    sklPrTov:json["skl_pr_tov"]== null?<SklPrTovResult>[]: List<SklPrTovResult>.from(json["skl_pr_tov"].map((x) => SklPrTovResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "ID_T": idT,
    "SANA": "${sana.year.toString().padLeft(4, '0')}-${sana.month.toString().padLeft(2, '0')}-${sana.day.toString().padLeft(2, '0')}",
    "NDOC": ndoc,
    "IZOH": izoh,
    "SM": sm,
    "SM_S": smS,
    "SM_T": smT,
    "SM_T_S": smTS,
    "HAR": har,
    "HAR_S": harS,
    "ID_HODIM": idHodim,
    "PR": pr,
    "YIL": yil,
    "OY": oy,
    "ID_SKL": idSkl,
    "VAQT": vaqt.toIso8601String(),
    "skl_pr_tov": List<dynamic>.from(sklPrTov.map((x) => x.toJson())),
  };
}

class SklPrTovResult {
  int id;
  String name;
  int idSkl2;
  num soni;
  num narhi;
  num narhiS;
  dynamic sm;
  dynamic smS;
  int idTip;
  int idFirma;
  int idEdiz;
  num snarhi;
  num snarhiS;
  dynamic ssm;
  dynamic ssmS;
  num snarhi1;
  num snarhi1S;
  num snarhi2;
  num snarhi2S;
  dynamic tnarhi;
  dynamic tnarhiS;
  dynamic tsm;
  dynamic tsmS;
  String shtr;

  SklPrTovResult({
    required this.id,
    required this.name,
    required this.idSkl2,
    required this.soni,
    required this.narhi,
    required this.narhiS,
    required this.sm,
    required this.smS,
    required this.idTip,
    required this.idFirma,
    required this.idEdiz,
    required this.snarhi,
    required this.snarhiS,
    required this.ssm,
    required this.ssmS,
    required this.snarhi1,
    required this.snarhi1S,
    required this.snarhi2,
    required this.snarhi2S,
    required this.tnarhi,
    required this.tnarhiS,
    required this.tsm,
    required this.tsmS,
    required this.shtr,
  });

  factory SklPrTovResult.fromJson(Map<String, dynamic> json) => SklPrTovResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idSkl2: json["ID_SKL2"]??0,
    soni: json["SONI"]??0.0,
    narhi: json["NARHI"]??0.0,
    narhiS: json["NARHI_S"]??0.0,
    sm: json["SM"]??0.0,
    smS: json["SM_S"]??0.0,
    idTip: json["ID_TIP"]??0,
    idFirma: json["ID_FIRMA"]??0,
    idEdiz: json["ID_EDIZ"]??0,
    snarhi: json["SNARHI"]??0.0,
    snarhiS: json["SNARHI_S"]??0.0,
    ssm: json["SSM"]??0.0,
    ssmS: json["SSM_S"]??0.0,
    snarhi1: json["SNARHI1"]??0.0,
    snarhi1S: json["SNARHI1_S"]??0.0,
    snarhi2: json["SNARHI2"]??0.0,
    snarhi2S: json["SNARHI2_S"]??0.0,
    tnarhi: json["TNARHI"]??0.0,
    tnarhiS: json["TNARHI_S"]??0.0,
    tsm: json["TSM"]??0.0,
    tsmS: json["TSM_S"]??0.0,
    shtr: json["SHTR"]??"",
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "ID_SKL2": idSkl2,
    "SONI": soni,
    "NARHI": narhi,
    "NARHI_S": narhiS,
    "SM": sm,
    "SM_S": smS,
    "ID_TIP": idTip,
    "ID_FIRMA": idFirma,
    "ID_EDIZ": idEdiz,
    "SNARHI": snarhi,
    "SNARHI_S": snarhiS,
    "SSM": ssm,
    "SSM_S": ssmS,
    "SNARHI1": snarhi1,
    "SNARHI1_S": snarhi1S,
    "SNARHI2": snarhi2,
    "SNARHI2_S": snarhi2S,
    "TNARHI": tnarhi,
    "TNARHI_S": tnarhiS,
    "TSM": tsm,
    "TSM_S": tsmS,
    "SHTR": shtr,
  };
}
