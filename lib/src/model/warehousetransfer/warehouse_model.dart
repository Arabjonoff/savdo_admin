// To parse this JSON data, do
//
//     final wareHouseModel = wareHouseModelFromJson(jsonString);

import 'dart:convert';

WareHouseTransferModel wareHouseModelFromJson(String str) => WareHouseTransferModel.fromJson(json.decode(str));

String wareHouseModelToJson(WareHouseTransferModel data) => json.encode(data.toJson());

class WareHouseTransferModel {
  List<WareHouseResult> data;

  WareHouseTransferModel({
    required this.data,
  });

  factory WareHouseTransferModel.fromJson(Map<String, dynamic> json) => WareHouseTransferModel(
    data: List<WareHouseResult>.from(json["data"].map((x) => WareHouseResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WareHouseResult {
  int id;
  DateTime sana;
  String ndoc;
  String izoh;
  num sm;
  num smS;
  int idHodim;
  int pr;
  String yil;
  String oy;
  int idSkl;
  int idSklTo;
  DateTime vaqt;
  dynamic har;
  dynamic harS;
  String warehouseFrom;
  String warehouseTo;
  List<SklPerTov> sklPerTov;

  WareHouseResult({
    required this.id,
    required this.sana,
    required this.ndoc,
    required this.izoh,
    required this.sm,
    required this.smS,
    required this.idHodim,
    required this.pr,
    required this.yil,
    required this.oy,
    required this.idSkl,
    required this.idSklTo,
    required this.vaqt,
    required this.har,
    required this.harS,
    this.warehouseFrom = '',
    this.warehouseTo = '',
    required this.sklPerTov,
  });

  factory WareHouseResult.fromJson(Map<String, dynamic> json) => WareHouseResult(
    id: json["ID"]??0,
    sana: DateTime.parse(json["SANA"]),
    ndoc: json["NDOC"]??0,
    izoh: json["IZOH"]??0,
    sm: json["SM"]??0,
    smS: json["SM_S"]??0,
    idHodim: json["ID_HODIM"]??0,
    pr: json["PR"]??0,
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    idSkl: json["ID_SKL"]??0,
    idSklTo: json["ID_SKL_TO"]??0,
    vaqt: DateTime.parse(json["VAQT"]),
    har: json["HAR"]??0,
    harS: json["HAR_S"]??0,
    sklPerTov: json["skl_per_tov"] ==null?[]:List<SklPerTov>.from(json["skl_per_tov"].map((x) => SklPerTov.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "SANA": "${sana.year.toString().padLeft(4, '0')}-${sana.month.toString().padLeft(2, '0')}-${sana.day.toString().padLeft(2, '0')}",
    "NDOC": ndoc,
    "IZOH": izoh,
    "SM": sm,
    "SM_S": smS,
    "ID_HODIM": idHodim,
    "PR": pr,
    "YIL": yil,
    "OY": oy,
    "ID_SKL": idSkl,
    "ID_SKL_TO": idSklTo,
    "VAQT": vaqt.toIso8601String(),
    "HAR": har,
    "HAR_S": harS,
    "skl_per_tov": List<dynamic>.from(sklPerTov.map((x) => x.toJson())),
  };
}

class SklPerTov {
  int id;
  String name;
  int idSkl2;
  num soni;
  num narhi;
  num narhiS;
  num sm;
  num smS;
  int idTip;
  int idEdiz;
  num snarhi;
  num snarhiS;
  num ssm;
  num ssmS;
  num tnarhi;
  num tnarhiS;
  dynamic tsm;
  dynamic tsmS;
  String shtr;

  SklPerTov({
    required this.id,
    required this.name,
    required this.idSkl2,
    required this.soni,
    required this.narhi,
    required this.narhiS,
    required this.sm,
    required this.smS,
    required this.idTip,
    required this.idEdiz,
    required this.snarhi,
    required this.snarhiS,
    required this.ssm,
    required this.ssmS,
    required this.tnarhi,
    required this.tnarhiS,
    required this.tsm,
    required this.tsmS,
    required this.shtr,
  });

  factory SklPerTov.fromJson(Map<String, dynamic> json) => SklPerTov(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    idSkl2: json["ID_SKL2"]??0,
    soni: json["SONI"]??0,
    narhi: json["NARHI"]??0,
    narhiS: json["NARHI_S"]??0,
    sm: json["SM"]??0,
    smS: json["SM_S"]??0,
    idTip: json["ID_TIP"]??0,
    idEdiz: json["ID_EDIZ"]??0,
    snarhi: json["SNARHI"]??0,
    snarhiS: json["SNARHI_S"]??0,
    ssm: json["SSM"]??0,
    ssmS: json["SSM_S"]??0,
    tnarhi: json["TNARHI"]??0,
    tnarhiS: json["TNARHI_S"]??0,
    tsm: json["TSM"]??0,
    tsmS: json["TSM_S"]??0,
    shtr: json["SHTR"]??0,
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
    "ID_EDIZ": idEdiz,
    "SNARHI": snarhi,
    "SNARHI_S": snarhiS,
    "SSM": ssm,
    "SSM_S": ssmS,
    "TNARHI": tnarhi,
    "TNARHI_S": tnarhiS,
    "TSM": tsm,
    "TSM_S": tsmS,
    "SHTR": shtr,
  };
}
