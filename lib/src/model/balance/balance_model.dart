import 'dart:convert';

BalanceModel balanceModelFromJson(String str) => BalanceModel.fromJson(json.decode(str));

String balanceModelToJson(BalanceModel data) => json.encode(data.toJson());

class BalanceModel {
  bool status;
  num sklSm;
  num sklSmS;
  num kzSm;
  num kzSmS;
  num psSm;
  num psSmS;
  num oySm;
  num oySmS;
  num tlSm;
  num tlSmS;
  num savdo;
  num savdoS;
  num fr;
  num frS;
  num soni;

  BalanceModel({
    required this.status,
    required this.sklSm,
    required this.sklSmS,
    required this.kzSm,
    required this.kzSmS,
    required this.psSm,
    required this.psSmS,
    required this.oySm,
    required this.oySmS,
    required this.tlSm,
    required this.tlSmS,
    required this.savdo,
    required this.savdoS,
    required this.fr,
    required this.frS,
    required this.soni,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
    status: json["status"],
    sklSm: json["SKL_SM"]??0,
    sklSmS: json["SKL_SM_S"]??0,
    kzSm: json["KZ_SM"]??0,
    kzSmS: json["KZ_SM_S"]??0,
    psSm: json["PS_SM"],
    psSmS: json["PS_SM_S"]??0,
    oySm: json["OY_SM"]??0,
    oySmS: json["OY_SM_S"]??0,
    tlSm: json["TL_SM"]??0,
    tlSmS: json["TL_SM_S"]??0,
    savdo: json["SAVDO"]??0,
    savdoS: json["SAVDO_S"]??0,
    fr: json["FR"]??0,
    frS: json["FR_S"]??0,
    soni: json["SONI"]??0,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "SKL_SM": sklSm,
    "SKL_SM_S": sklSmS,
    "KZ_SM": kzSm,
    "KZ_SM_S": kzSmS,
    "PS_SM": psSm,
    "PS_SM_S": psSmS,
    "OY_SM": oySm,
    "OY_SM_S": oySmS,
    "TL_SM": tlSm,
    "TL_SM_S": tlSmS,
    "SAVDO": savdo,
    "SAVDO_S": savdoS,
    "FR": fr,
    "FR_S": frS,
    "SONI": soni,
  };
}
