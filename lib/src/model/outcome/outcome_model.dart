import 'dart:convert';

OutcomeModel outcomeModelFromJson(String str) => OutcomeModel.fromJson(json.decode(str));

String outcomeModelToJson(OutcomeModel data) => json.encode(data.toJson());

class OutcomeModel {
  List<OutcomeResult> outcomeResult;

  OutcomeModel({
    required this.outcomeResult,
  });

  factory OutcomeModel.fromJson(Map<String, dynamic> json) => OutcomeModel(
    outcomeResult: List<OutcomeResult>.from(json["data"].map((x) => OutcomeResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(outcomeResult.map((x) => x.toJson())),
  };
}

class OutcomeResult {
  int id;
  String name;
  String clientPhone;
  String clientTarget;
  String clientAddress;
  String sklName;
  String idT;
  DateTime sana;
  String ndoc;
  String izoh;
  num sm;
  num smS;
  int idHodim;
  int idAgent;
  String idAgentName;
  int pr;
  String yil;
  String oy;
  int idSkl;
  DateTime vaqt;
  int idHaridor;
  num kurs;
  num tlNaqd;
  num tlVal;
  num tlKarta;
  num tlBank;
  int idFaol;
  int idKlass;
  List<SklRsTov> sklRsTov;

  OutcomeResult({
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
    required this.tlNaqd,
    required this.tlVal,
    required this.tlKarta,
    required this.tlBank,
    required this.idFaol,
    required this.idKlass,
    required this.sklRsTov,
    this.idAgentName = "",
    this.clientPhone = "",
    this.clientTarget = "",
    this.clientAddress = "",
    this.sklName = "",
  });

  factory OutcomeResult.fromJson(Map<String, dynamic> json) => OutcomeResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idT: json["ID_T"]??"",
    sana: json["SANA"]==null?DateTime.now():DateTime.parse(json["SANA"]),
    ndoc: json["NDOC"]??"999",
    izoh: json["IZOH"]??"",
    sm: json["SM"]??0,
    smS: json["SM_S"]??0,
    idHodim: json["ID_HODIM"]??0,
    idAgent: json["ID_AGENT"]??0,
    pr: json["PR"]??0,
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    idSkl: json["ID_SKL"]??0,
    vaqt: DateTime.parse(json["VAQT"]),
    idHaridor: json["ID_HARIDOR"]??0,
    kurs: json["KURS"]??0,
    tlNaqd: json["TL_NAQD"]??0,
    tlVal: json["TL_VAL"]??0,
    tlKarta: json["TL_KARTA"]??0,
    tlBank: json["TL_BANK"]??0,
    idFaol: json["ID_FAOL"]??0,
    idKlass: json["ID_KLASS"]??0,
    sklRsTov: json["SKL_RS_TOV"] == null?[]:List<SklRsTov>.from(json["SKL_RS_TOV"].map((x) => SklRsTov.fromJson(x))),
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
    "TL_NAQD": tlNaqd,
    "TL_VAL": tlVal,
    "TL_KARTA": tlKarta,
    "TL_BANK": tlBank,
    "ID_FAOL": idFaol,
    "ID_KLASS": idKlass,
    "SKL_RS_TOV": List<dynamic>.from(sklRsTov.map((x) => x.toJson())),
  };
}

class SklRsTov {
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
  dynamic vz;
  String shtr;

  SklRsTov({
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
    required this.vz,
    required this.shtr,
  });

  factory SklRsTov.fromJson(Map<String, dynamic> json) => SklRsTov(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idSkl2: json["ID_SKL2"]??0,
    soni: json["SONI"]??0,
    narhi: json["NARHI"]??0,
    narhiS: json["NARHI_S"]??0,
    sm: json["SM"]??0,
    smS: json["SM_S"]??0,
    idTip: json["ID_TIP"]??0,
    idFirma: json["ID_FIRMA"]??0,
    idEdiz: json["ID_EDIZ"]??0,
    snarhi: json["SNARHI"]??0,
    snarhiS: json["SNARHI_S"]??0,
    ssm: json["SSM"]??0,
    ssmS: json["SSM_S"]??0,
    fr: json["FR"]??0,
    frS: json["FR_S"]??0,
    vz: json["VZ"]??0,
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
    "FR": fr,
    "FR_S": frS,
    "VZ": vz,
    "SHTR": shtr,
  };
}
