import 'dart:convert';

RevisionModel revisionModelFromJson(String str) => RevisionModel.fromJson(json.decode(str));

String revisionModelToJson(RevisionModel data) => json.encode(data.toJson());

class RevisionModel {
  List<RevisionResult> data;

  RevisionModel({
    required this.data,
  });

  factory RevisionModel.fromJson(Map<String, dynamic> json) => RevisionModel(
    data: List<RevisionResult>.from(json["data"].map((x) => RevisionResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RevisionResult {
  int id;
  DateTime sana;
  String ndoc;
  String agentName;
  String izoh;
  num sm;
  num smS;
  int idHodim;
  int pr;
  String yil;
  String oy;
  int idSkl;
  DateTime vaqt;
  num f1;
  num f2;
  num nSm;
  num nSmS;
  int st;
  List<Map<String, double>> sklRevTov;

  RevisionResult({
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
    required this.vaqt,
    required this.f1,
    required this.f2,
    required this.nSm,
    required this.nSmS,
    required this.st,
    required this.sklRevTov,
    this.agentName ='',
  });

  factory RevisionResult.fromJson(Map<String, dynamic> json) => RevisionResult(
    id: json["ID"]??0,
    sana: DateTime.parse(json["SANA"]),
    ndoc: json["NDOC"]??"",
    izoh: json["IZOH"]??"",
    sm: json["SM"]??0,
    smS: json["SM_S"]??0,
    idHodim: json["ID_HODIM"]??0,
    pr: json["PR"]??0,
    yil: json["YIL"]??"",
    oy: json["OY"]??"",
    idSkl: json["ID_SKL"]??0,
    vaqt: DateTime.parse(json["VAQT"]),
    f1: json["F1"]??0,
    f2: json["F2"]??0,
    nSm: json["N_SM"]??0,
    nSmS: json["N_SM_S"]??0,
    st: json["ST"]??0,
    sklRevTov: json["skl_rev_tov"] == null?[]:List<Map<String, double>>.from(json["skl_rev_tov"].map((x) => Map.from(x).map((k, v) => MapEntry<String, double>(k, v?.toDouble())))),
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
    "VAQT": vaqt.toIso8601String(),
    "F1": f1,
    "F2": f2,
    "N_SM": nSm,
    "N_SM_S": nSmS,
    "ST": st,
    "skl_rev_tov": List<dynamic>.from(sklRevTov.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
