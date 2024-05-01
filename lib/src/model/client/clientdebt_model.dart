// To parse this JSON data, do
//
//     final debtClientModel = debtClientModelFromJson(jsonString);

import 'dart:convert';

List<DebtClientModel> debtClientModelFromJson(String str) => List<DebtClientModel>.from(json.decode(str).map((x) => DebtClientModel.fromJson(x)));

String debtClientModelToJson(List<DebtClientModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DebtClientModel {
  int id;
  num tp;
  String name;
  String agentName;
  int agentId;
  String idToch;
  String yil;
  String oy;
  num klK;
  num klKS;
  num pr;
  num prS;
  num st;
  num stS;
  num kt;
  num ktS;
  num tlK;
  num tlKS;
  num tlC;
  num tlCS;
  num sd;
  num sdS;
  num osK;
  num osKS;
  num sti;
  num idAgent;
  num idFaol;
  dynamic dtM;
  dynamic dtT;
  String manzil;

  DebtClientModel({
    required this.id,
    required this.tp,
    required this.name,
    required this.idToch,
    required this.yil,
    required this.oy,
    required this.klK,
    required this.klKS,
    required this.pr,
    required this.prS,
    required this.st,
    required this.stS,
    required this.kt,
    required this.ktS,
    required this.tlK,
    required this.tlKS,
    required this.tlC,
    required this.tlCS,
    required this.sd,
    required this.sdS,
    required this.osK,
    required this.osKS,
    required this.sti,
    required this.idAgent,
    required this.idFaol,
    required this.dtM,
    required this.dtT,
    required this.manzil,
     this.agentName = '',
     this.agentId = 0,
  });

  factory DebtClientModel.fromJson(Map<String, dynamic> json) => DebtClientModel(
    id: json["ID"]??0,
    tp: json["TP"]??"",
    name: json["NAME"]??"",
    idToch: json["ID_TOCH"]??"",
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    klK: json["KL_K"]??0,
    klKS: json["KL_K_S"]??0,
    pr: json["PR"]??0,
    prS: json["PR_S"]??0,
    st: json["ST"]??0,
    stS: json["ST_S"]??0,
    kt: json["KT"]??0,
    ktS: json["KT_S"]??0,
    tlK: json["TL_K"]??0,
    tlKS: json["TL_K_S"]??0,
    tlC: json["TL_C"]??0,
    tlCS: json["TL_C_S"]??0,
    sd: json["SD"]??0,
    sdS: json["SD_S"]??0,
    osK: json["OS_K"]??0,
    osKS: json["OS_K_S"]??0,
    sti: json["STI"]??0,
    idAgent: json["ID_AGENT"]??0,
    idFaol: json["ID_FAOL"]??0,
    dtM: json["DT_M"] == null ? DateTime.now() : DateTime.parse(json["DT_M"]),
    dtT: json["DT_T"] == null ? DateTime.now() : DateTime.parse(json["DT_T"]),
    manzil: json["MANZIL"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TP": tp,
    "NAME": name,
    "ID_TOCH": idToch,
    "YIL": yil,
    "OY": oy,
    "KL_K": klK,
    "KL_K_S": klKS,
    "PR": pr,
    "PR_S": prS,
    "ST": st,
    "ST_S": stS,
    "KT": kt,
    "KT_S": ktS,
    "TL_K": tlK,
    "TL_K_S": tlKS,
    "TL_C": tlC,
    "TL_C_S": tlCS,
    "SD": sd,
    "SD_S": sdS,
    "OS_K": osK,
    "OS_K_S": osKS,
    "STI": sti,
    "ID_AGENT": idAgent,
    "ID_FAOL": idFaol,
    "DT_M": "${dtM!.year.toString().padLeft(4, '0')}-${dtM!.month.toString().padLeft(2, '0')}-${dtM!.day.toString().padLeft(2, '0')}",
    "DT_T": "${dtT!.year.toString().padLeft(4, '0')}-${dtT!.month.toString().padLeft(2, '0')}-${dtT!.day.toString().padLeft(2, '0')}",
    "MANZIL": manzil,
  };
}
