import 'dart:convert';

GetExpenseModel getExpenseModelFromJson(String str) => GetExpenseModel.fromJson(json.decode(str));

String getExpenseModelToJson(GetExpenseModel data) => json.encode(data.toJson());

class GetExpenseModel {
  List<GetExpenseResult> data;

  GetExpenseModel({
    required this.data,
  });

  factory GetExpenseModel.fromJson(Map<String, dynamic> json) => GetExpenseModel(
    data: List<GetExpenseResult>.from(json["data"].map((x) => GetExpenseResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetExpenseResult {
  int id;
  DateTime sana;
  String yil;
  String oy;
  int pr;
  num klNaqd;
  num klVal;
  num klKarta;
  num klBank;
  num kNaqd;
  num kVal;
  num kKarta;
  num kBank;
  num cNaqd;
  num cVal;
  num cKarta;
  num cBank;
  num hNaqd;
  num hVal;
  num hKarta;
  num hBank;
  num oNaqd;
  num oVal;
  num oKarta;
  num oBank;
  num knvR;
  num knvRS;
  num knvP;
  num knvPS;
  num idChet;
  dynamic act;
  dynamic idHodim;
  List<Tl1> tl1;
  List<THar> tHar;
  List<dynamic> knv;

  GetExpenseResult({
    required this.id,
    required this.sana,
    required this.yil,
    required this.oy,
    required this.pr,
    required this.klNaqd,
    required this.klVal,
    required this.klKarta,
    required this.klBank,
    required this.kNaqd,
    required this.kVal,
    required this.kKarta,
    required this.kBank,
    required this.cNaqd,
    required this.cVal,
    required this.cKarta,
    required this.cBank,
    required this.hNaqd,
    required this.hVal,
    required this.hKarta,
    required this.hBank,
    required this.oNaqd,
    required this.oVal,
    required this.oKarta,
    required this.oBank,
    required this.knvR,
    required this.knvRS,
    required this.knvP,
    required this.knvPS,
    required this.idChet,
    required this.act,
    required this.idHodim,
    required this.tl1,
    required this.tHar,
    required this.knv,
  });

  factory GetExpenseResult.fromJson(Map<String, dynamic> json) => GetExpenseResult(
    id: json["ID"]??0,
    sana: json["SANA"] ==null?DateTime.now():DateTime.parse(json["SANA"]),
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    pr: json["PR"]??0,
    klNaqd: json["KL_NAQD"]??0,
    klVal: json["KL_VAL"]??0,
    klKarta: json["KL_KARTA"]??0,
    klBank: json["KL_BANK"]??0,
    kNaqd: json["K_NAQD"]??0,
    kVal: json["K_VAL"]??0,
    kKarta: json["K_KARTA"]??0,
    kBank: json["K_BANK"]??0,
    cNaqd: json["C_NAQD"]??0,
    cVal: json["C_VAL"]??0,
    cKarta: json["C_KARTA"]??0,
    cBank: json["C_BANK"]??0,
    hNaqd: json["H_NAQD"]??0,
    hVal: json["H_VAL"]??0,
    hKarta: json["H_KARTA"]??0,
    hBank: json["H_BANK"]??0,
    oNaqd: json["O_NAQD"]??0,
    oVal: json["O_VAL"]??0,
    oKarta: json["O_KARTA"]??0,
    oBank: json["O_BANK"]??0,
    knvR: json["KNV_R"]??0,
    knvRS: json["KNV_R_S"]??0,
    knvP: json["KNV_P"]??0,
    knvPS: json["KNV_P_S"]??0,
    idChet: json["ID_CHET"]??0,
    act: json["ACT"]??0,
    idHodim: json["ID_HODIM"]??0,
    tl1: json["TL1"] == null?<Tl1>[]:List<Tl1>.from(json["TL1"].map((x) => Tl1.fromJson(x))),
    tHar: json["T_HAR"] == null?<THar>[]:List<THar>.from(json["T_HAR"].map((x) => THar.fromJson(x))),
    knv: json["KNV"] == null?[]:List<dynamic>.from(json["KNV"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "SANA": "${sana.year.toString().padLeft(4, '0')}-${sana.month.toString().padLeft(2, '0')}-${sana.day.toString().padLeft(2, '0')}",
    "YIL": yil,
    "OY": oy,
    "PR": pr,
    "KL_NAQD": klNaqd,
    "KL_VAL": klVal,
    "KL_KARTA": klKarta,
    "KL_BANK": klBank,
    "K_NAQD": kNaqd,
    "K_VAL": kVal,
    "K_KARTA": kKarta,
    "K_BANK": kBank,
    "C_NAQD": cNaqd,
    "C_VAL": cVal,
    "C_KARTA": cKarta,
    "C_BANK": cBank,
    "H_NAQD": hNaqd,
    "H_VAL": hVal,
    "H_KARTA": hKarta,
    "H_BANK": hBank,
    "O_NAQD": oNaqd,
    "O_VAL": oVal,
    "O_KARTA": oKarta,
    "O_BANK": oBank,
    "KNV_R": knvR,
    "KNV_R_S": knvRS,
    "KNV_P": knvP,
    "KNV_P_S": knvPS,
    "ID_CHET": idChet,
    "ACT": act,
    "ID_HODIM": idHodim,
    "TL1": List<dynamic>.from(tl1.map((x) => x.toJson())),
    "T_HAR": List<dynamic>.from(tHar.map((x) => x.toJson())),
    "KNV": List<dynamic>.from(knv.map((x) => x)),
  };
}

class THar {
  int id;
  int idAgent;
  int idNima;
  String idNimaName;
  num sm;
  String yil;
  String oy;
  DateTime sana;
  String izoh;
  int idSana;
  int idSklPr;
  int idSklPer;
  int idChet;
  int idValuta;

  THar({
    required this.id,
    required this.idAgent,
    required this.idNima,
    required this.sm,
    required this.yil,
    required this.oy,
    required this.sana,
    required this.izoh,
    required this.idSana,
    required this.idSklPr,
    required this.idSklPer,
    required this.idChet,
    required this.idValuta,
    this.idNimaName = '',
  });

  factory THar.fromJson(Map<String, dynamic> json) => THar(
    id: json["ID"]??0,
    idAgent: json["ID_AGENT"]??0,
    idNima: json["ID_NIMA"]??0,
    sm: json["SM"]??0,
    yil: json["YIL"]??'',
    oy: json["OY"]??'',
    sana: DateTime.parse(json["SANA"]),
    izoh: json["IZOH"]??'',
    idSana: json["ID_SANA"]??0,
    idSklPr: json["ID_SKL_PR"]??0,
    idSklPer: json["ID_SKL_PER"]??0,
    idChet: json["ID_CHET"]??0,
    idValuta: json["ID_VALUTA"]??0,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "ID_AGENT": idAgent,
    "ID_NIMA": idNima,
    "SM": sm,
    "YIL": yil,
    "OY": oy,
    "SANA": "${sana.year.toString().padLeft(4, '0')}-${sana.month.toString().padLeft(2, '0')}-${sana.day.toString().padLeft(2, '0')}",
    "IZOH": izoh,
    "ID_SANA": idSana,
    "ID_SKL_PR": idSklPr,
    "ID_SKL_PER": idSklPer,
    "ID_CHET": idChet,
    "ID_VALUTA": idValuta,
  };
}

class Tl1 {
  int id;
  DateTime sana;
  String idToch;
  String name;
  int sm;
  int tp;
  num foiz;
  num sm0;
  int idHodimlar;
  int tip;
  int pr;
  int kurs;
  int idAgent;
  int idSklRs;
  int idSklPr;
  int idValuta;
  String izoh;
  int idSana;

  Tl1({
    required this.id,
    required this.sana,
    required this.idToch,
    required this.name,
    required this.sm,
    required this.tp,
    required this.foiz,
    required this.sm0,
    required this.idHodimlar,
    required this.tip,
    required this.pr,
    required this.kurs,
    required this.idAgent,
    required this.idSklRs,
    required this.idSklPr,
    required this.idValuta,
    required this.izoh,
    required this.idSana,
  });

  factory Tl1.fromJson(Map<String, dynamic> json) => Tl1(
    id: json["ID"]??0,
    sana: json["SANA"] == null?DateTime.now():DateTime.parse(json["SANA"]),
    idToch: json["ID_TOCH"]??"",
    name: json["NAME"]??"",
    sm: json["SM"]??0.0,
    tp: json["TP"]??0,
    foiz: json["FOIZ"]??0,
    sm0: json["SM0"]??0,
    idHodimlar: json["ID_HODIMLAR"]??0,
    tip: json["TIP"]??0,
    pr: json["PR"]??0,
    kurs: json["KURS"]??0,
    idAgent: json["ID_AGENT"]??0,
    idSklRs: json["ID_SKL_RS"]??0,
    idSklPr: json["ID_SKL_PR"]??0,
    idValuta: json["ID_VALUTA"]??0,
    izoh: json["IZOH"]??"",
    idSana: json["ID_SANA"]??0,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "SANA": "${sana.year.toString().padLeft(4, '0')}-${sana.month.toString().padLeft(2, '0')}-${sana.day.toString().padLeft(2, '0')}",
    "ID_TOCH": idToch,
    "NAME": name,
    "SM": sm,
    "TP": tp,
    "FOIZ": foiz,
    "SM0": sm0,
    "ID_HODIMLAR": idHodimlar,
    "TIP": tip,
    "PR": pr,
    "KURS": kurs,
    "ID_AGENT": idAgent,
    "ID_SKL_RS": idSklRs,
    "ID_SKL_PR": idSklPr,
    "ID_VALUTA": idValuta,
    "IZOH": izoh,
    "ID_SANA": idSana,
  };
}
