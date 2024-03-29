// To parse this JSON data, do
//
//     final sendIncomeModel = sendIncomeModelFromJson(jsonString);

import 'dart:convert';

SendIncomeModel sendIncomeModelFromJson(String str) => SendIncomeModel.fromJson(json.decode(str));

String sendIncomeModelToJson(SendIncomeModel data) => json.encode(data.toJson());

class SendIncomeModel {
  List<Datum> data;

  SendIncomeModel({
    required this.data,
  });

  factory SendIncomeModel.fromJson(Map<String, dynamic> json) => SendIncomeModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String name;
  String idT;
  DateTime sana;
  String ndoc;
  String izoh;
  int? sm;
  int? smS;
  int? smT;
  int? smTS;
  int? har;
  int? harS;
  int idHodim;
  int pr;
  String yil;
  String oy;
  int idSkl;
  DateTime vaqt;
  List<SklPrTov> sklPrTov;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    name: json["NAME"],
    idT: json["ID_T"],
    sana: DateTime.parse(json["SANA"]),
    ndoc: json["NDOC"],
    izoh: json["IZOH"],
    sm: json["SM"],
    smS: json["SM_S"],
    smT: json["SM_T"],
    smTS: json["SM_T_S"],
    har: json["HAR"],
    harS: json["HAR_S"],
    idHodim: json["ID_HODIM"],
    pr: json["PR"],
    yil: json["YIL"],
    oy: json["OY"],
    idSkl: json["ID_SKL"],
    vaqt: DateTime.parse(json["VAQT"]),
    sklPrTov: List<SklPrTov>.from(json["skl_pr_tov"].map((x) => SklPrTov.fromJson(x))),
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

class SklPrTov {
  int id;
  String name;
  int idSkl2;
  int soni;
  int narhi;
  int narhiS;
  int sm;
  int smS;
  int idTip;
  int idFirma;
  int idEdiz;
  int snarhi;
  int snarhiS;
  int ssm;
  int ssmS;
  int snarhi1;
  int snarhi1S;
  int snarhi2;
  int snarhi2S;
  int tnarhi;
  int tnarhiS;
  int tsm;
  int tsmS;
  String shtr;

  SklPrTov({
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

  factory SklPrTov.fromJson(Map<String, dynamic> json) => SklPrTov(
    id: json["ID"],
    name: json["NAME"],
    idSkl2: json["ID_SKL2"],
    soni: json["SONI"],
    narhi: json["NARHI"],
    narhiS: json["NARHI_S"],
    sm: json["SM"],
    smS: json["SM_S"],
    idTip: json["ID_TIP"],
    idFirma: json["ID_FIRMA"],
    idEdiz: json["ID_EDIZ"],
    snarhi: json["SNARHI"],
    snarhiS: json["SNARHI_S"],
    ssm: json["SSM"],
    ssmS: json["SSM_S"],
    snarhi1: json["SNARHI1"],
    snarhi1S: json["SNARHI1_S"],
    snarhi2: json["SNARHI2"],
    snarhi2S: json["SNARHI2_S"],
    tnarhi: json["TNARHI"],
    tnarhiS: json["TNARHI_S"],
    tsm: json["TSM"],
    tsmS: json["TSM_S"],
    shtr: json["SHTR"],
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
