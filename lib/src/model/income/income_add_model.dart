import 'dart:convert';

IncomeAddModel incomeAddModelFromJson(String str) => IncomeAddModel.fromJson(json.decode(str));


class IncomeAddModel {
  int id;
  dynamic idSklPr;
  int idSkl2;
  String name;
  int idTip;
  int idFirma;
  int idEdiz;
  num soni;
  num narhi;
  num price;
  num narhiS;
  num sm;
  num smS;
  num snarhi;
  num snarhiS;
  num snarhi1;
  num snarhi1S;
  num snarhi2;
  num snarhi2S;
  num tnarhi;
  num tnarhiS;
  num tsm;
  num tsmS;
  String shtr;

  IncomeAddModel({
    required this.idSklPr,
    required this.idSkl2,
    required this.name,
    required this.idTip,
    required this.idFirma,
    required this.idEdiz,
    required this.soni,
    required this.narhi,
    required this.narhiS,
    required this.sm,
    required this.smS,
    required this.snarhi,
    required this.snarhiS,
    required this.snarhi1,
    required this.snarhi1S,
    required this.snarhi2,
    required this.snarhi2S,
    required this.tnarhi,
    required this.tnarhiS,
    required this.tsm,
    required this.tsmS,
    required this.shtr,
    this.price = 0,
    this.id = 0,
  });

  factory IncomeAddModel.fromJson(Map<String, dynamic> json) => IncomeAddModel(
    idSklPr: json["ID_SKL_PR"]??0,
    idSkl2: json["ID_SKL2"]??0,
    name: json["NAME"]??"",
    idTip: json["ID_TIP"]??0,
    idFirma: json["ID_FIRMA"]??0,
    idEdiz: json["ID_EDIZ "]??0,
    soni: json["SONI"]??0.0,
    narhi: json["NARHI"]??0,
    narhiS: json["NARHI_S"]??0,
    sm: json["SM"]??0,
    smS: json["SM_S"]??0,
    snarhi: json["SNARHI"]??0,
    snarhiS: json["SNARHI_S"]??0,
    snarhi1: json["SNARHI1"]??0,
    snarhi1S: json["SNARHI1_S"]??0,
    snarhi2: json["SNARHI2"]??0,
    snarhi2S: json["SNARHI2_S"]??0,
    tnarhi: json["TNARHI"]??0,
    tnarhiS: json["TNARHI_S"]??0,
    tsm: json["TSM"]??0,
    tsmS: json["TSM_S"]??0,
    shtr: json["SHTR"]??'0',
  );

  Map<String, dynamic> toJsonIns() => {
    "ID": id,
    "ID_SKL_PR": idSklPr,
    "ID_SKL2": idSkl2,
    "NAME": name,
    "ID_TIP": idTip,
    "ID_FIRMA": idFirma,
    "ID_EDIZ": idEdiz,
    "SONI": soni,
    "NARHI": narhi,
    "NARHI_S": narhiS,
    "SM": sm,
    "SM_S": smS,
    "SNARHI": snarhi,
    "SNARHI_S": snarhiS,
    "SNARHI1": snarhi1,
    "SNARHI1_S": snarhi1S,
    "SNARHI2": snarhi2,
    "SNARHI2_S": snarhi2S,
    "TNARHI": tnarhi,
    "TNARHI_S": tnarhiS,
    "TSM": tsm,
    "TSM_S": tsmS,
    "SHTR": shtr,
    "price": price,
  };
  Map<String, dynamic> toJsonUpd() =>
      {
    "ID_SKL_PR": idSklPr,
    "ID_SKL2": idSkl2,
    "NAME": name,
    "ID_TIP": idTip,
    "ID_FIRMA": idFirma,
    "ID_EDIZ": idEdiz,
    "SONI": soni,
    "NARHI": narhi,
    "NARHI_S": narhiS,
    "SM": sm,
    "SM_S": smS,
    "SNARHI": snarhi,
    "SNARHI_S": snarhiS,
    "SNARHI1": snarhi1,
    "SNARHI1_S": snarhi1S,
    "SNARHI2": snarhi2,
    "SNARHI2_S": snarhi2S,
    "TNARHI": tnarhi,
    "TNARHI_S": tnarhiS,
    "TSM": tsm,
    "TSM_S": tsmS,
    "SHTR": shtr,
    "price": price,
  };
}
