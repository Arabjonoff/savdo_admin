import 'dart:convert';

ReturnedModel returnedModelFromJson(String str) => ReturnedModel.fromJson(json.decode(str));

String returnedModelToJson(ReturnedModel data) => json.encode(data.toJson());

class ReturnedModel {
  List<ReturnedResult> returnedResult;

  ReturnedModel({
    required this.returnedResult,
  });

  factory ReturnedModel.fromJson(Map<String, dynamic> json) => ReturnedModel(
    returnedResult: List<ReturnedResult>.from(json["data"].map((x) => ReturnedResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(returnedResult.map((x) => x.toJson())),
  };
}

class ReturnedResult {
  int id;
  String name;
  String clientPhone;
  String clientTarget;
  String clientAddress;
  String idAgentName;
  String sklName;
  String idT;
  DateTime sana;
  String ndoc;
  String izoh;
  num sm;
  num smS;
  int idHodim;
  int idAgent;
  int pr;
  String yil;
  String oy;
  int idSkl;
  DateTime vaqt;
  int idHaridor;
  int kurs;
  int tp;
  List<SklVzTov> sklVzTov;

  ReturnedResult({
    required this.id,
    required this.name,
    required this.idT,
    required this.sana,
    required this.ndoc,
    required this.izoh,
    required this.sm,
    required this.smS,
    required this.idHodim,
    required this.idAgent,
    required this.pr,
    required this.yil,
    required this.oy,
    required this.idSkl,
    required this.vaqt,
    required this.idHaridor,
    required this.kurs,
    required this.tp,
    required this.sklVzTov,
    this.clientAddress = '',
    this.clientPhone = '',
    this.clientTarget = '',
    this.idAgentName = '',
    this.sklName = '',
  });

  factory ReturnedResult.fromJson(Map<String, dynamic> json) => ReturnedResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idT: json["ID_T"]??"",
    sana: json["SANA"]==null?DateTime.now():DateTime.parse(json["SANA"]),
    ndoc: json["NDOC"]??"",
    izoh: json["IZOH"]??"",
    sm: json["SM"]??0,
    smS: json["SM_S"]??0,
    idHodim: json["ID_HODIM"]??0,
    idAgent: json["ID_AGENT"]??0,
    pr: json["PR"]??0,
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    idSkl: json["ID_SKL"]??0,
    vaqt: json["VAQT"]==null?DateTime.now():DateTime.parse(json["VAQT"]),
    idHaridor: json["ID_HARIDOR"]??0,
    kurs: json["KURS"]??0,
    tp: json["TP"]??0,
    sklVzTov: List<SklVzTov>.from(json["skl_vz_tov"].map((x) => SklVzTov.fromJson(x))),
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
    "ID_HODIM": idHodim,
    "ID_AGENT": idAgent,
    "PR": pr,
    "YIL": yil,
    "OY": oy,
    "ID_SKL": idSkl,
    "VAQT": vaqt.toIso8601String(),
    "ID_HARIDOR": idHaridor,
    "KURS": kurs,
    "TP": tp,
    "skl_vz_tov": List<dynamic>.from(sklVzTov.map((x) => x.toJson())),
  };
}

class SklVzTov {
  int id;
  String name;
  int idSkl2;
  num soni;
  num narhi;
  num narhiS;
  num sm;
  num smS;
  int idTip;
  int idFirma;
  int idEdiz;
  num snarhi;
  num snarhiS;
  num ssm;
  num ssmS;
  num fr;
  num frS;
  num vz;
  String shtr;

  SklVzTov({
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
    required this.fr,
    required this.frS,
    required this.shtr,
    this.vz = 0,
  });

  factory SklVzTov.fromJson(Map<String, dynamic> json) => SklVzTov(
    id: json["ID"],
    name: json["NAME"],
    idSkl2: json["ID_SKL2"],
    soni: json["SONI"],
    narhi: json["NARHI"],
    narhiS: json["NARHI_S"]?.toDouble(),
    sm: json["SM"],
    smS: json["SM_S"]?.toDouble(),
    idTip: json["ID_TIP"],
    idFirma: json["ID_FIRMA"],
    idEdiz: json["ID_EDIZ"],
    snarhi: json["SNARHI"],
    snarhiS: json["SNARHI_S"]?.toDouble(),
    ssm: json["SSM"],
    ssmS: json["SSM_S"]?.toDouble(),
    fr: json["FR"],
    frS: json["FR_S"],
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
    "FR": fr,
    "FR_S": frS,
    "SHTR": shtr,
    "VZ": vz,
  };
}
