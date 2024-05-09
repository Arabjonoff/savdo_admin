import 'dart:convert';

StaffPermissionModel staffPermissionModelFromJson(String str) => StaffPermissionModel.fromJson(json.decode(str));

String staffPermissionModelToJson(StaffPermissionModel data) => json.encode(data.toJson());

class StaffPermissionModel {
  bool status;
  List<StaffPermissionResult> data;

  StaffPermissionModel({
    required this.status,
    required this.data,
  });

  factory StaffPermissionModel.fromJson(Map<String, dynamic> json) => StaffPermissionModel(
    status: json["status"],
    data: List<StaffPermissionResult>.from(json["data"].map((x) => StaffPermissionResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StaffPermissionResult {
  int tp;
  int id;
  int p1;
  int p2;
  int p3;
  int p4;
  int p5;

  StaffPermissionResult({
    this.tp = 0,
    this.id = 0,
    this.p1 = 0,
    this.p2 = 0,
    this.p3 = 0,
    this.p4 = 0,
    this.p5 = 0,
  });

  factory StaffPermissionResult.fromJson(Map<String, dynamic> json) => StaffPermissionResult(
    tp: json["TP"]??0,
    p1: json["P1"]??0,
    p2: json["P2"]??0,
    p3: json["P3"]??0,
    p4: json["P4"]??0,
    p5: json["P5"]??0,
  );

  Map<String, dynamic> toJson() => {
    "TP": tp,
    "P1": p1,
    "P2": p2,
    "P3": p3,
    "P4": p4,
    "P5": p5,
  };
}
///
///
///
///
/// Agent Permission Bloc
AgentPermissionModel agentPermissionModelFromJson(String str) => AgentPermissionModel.fromJson(json.decode(str));

String agentPermissionModelToJson(AgentPermissionModel data) => json.encode(data.toJson());

class AgentPermissionModel {
  bool status;
  int snarhi;
  int idNarh;
  int skl;
  int idSkl;
  int kurs;
  int sms;
  int hrdD1;
  int hrdD2;
  int hrdD3;
  int hrdD4;
  int hrdD5;
  int chkD1;
  int chkD2;
  int chkD3;
  int chkD4;
  int chkD5;
  int chkD6;
  int chkD7;
  int chkD8;
  int vozD1;
  int vozD2;
  int vozD3;
  int vozD4;
  int vozD5;
  int vozD6;
  int vozD7;
  int tlD1;
  int tlD2;
  int tlD3;
  int tlD4;
  int tlD5;
  int tlD6;
  int harid;

  AgentPermissionModel({
    required this.status,
    required this.snarhi,
    required this.idNarh,
    required this.skl,
    required this.idSkl,
    required this.kurs,
    required this.sms,
    required this.hrdD1,
    required this.hrdD2,
    required this.hrdD3,
    required this.hrdD4,
    required this.hrdD5,
    required this.chkD1,
    required this.chkD2,
    required this.chkD3,
    required this.chkD4,
    required this.chkD5,
    required this.chkD6,
    required this.chkD7,
    required this.chkD8,
    required this.vozD1,
    required this.vozD2,
    required this.vozD3,
    required this.vozD4,
    required this.vozD5,
    required this.vozD6,
    required this.vozD7,
    required this.tlD1,
    required this.tlD2,
    required this.tlD3,
    required this.tlD4,
    required this.tlD5,
    required this.tlD6,
    required this.harid,
  });

  factory AgentPermissionModel.fromJson(Map<String, dynamic> json) => AgentPermissionModel(
    status: json["status"],
    snarhi: json["SNARHI"],
    idNarh: json["ID_NARH"],
    skl: json["SKL"],
    idSkl: json["ID_SKL"],
    kurs: json["KURS"],
    sms: json["SMS"],
    hrdD1: json["HRD_D1"],
    hrdD2: json["HRD_D2"],
    hrdD3: json["HRD_D3"],
    hrdD4: json["HRD_D4"],
    hrdD5: json["HRD_D5"],
    chkD1: json["CHK_D1"],
    chkD2: json["CHK_D2"],
    chkD3: json["CHK_D3"],
    chkD4: json["CHK_D4"],
    chkD5: json["CHK_D5"],
    chkD6: json["CHK_D6"],
    chkD7: json["CHK_D7"],
    chkD8: json["CHK_D8"],
    vozD1: json["VOZ_D1"],
    vozD2: json["VOZ_D2"],
    vozD3: json["VOZ_D3"],
    vozD4: json["VOZ_D4"],
    vozD5: json["VOZ_D5"],
    vozD6: json["VOZ_D6"],
    vozD7: json["VOZ_D7"],
    tlD1: json["TL_D1"],
    tlD2: json["TL_D2"],
    tlD3: json["TL_D3"],
    tlD4: json["TL_D4"],
    tlD5: json["TL_D5"],
    tlD6: json["TL_D6"],
    harid: json["HARID"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "SNARHI": snarhi,
    "ID_NARH": idNarh,
    "SKL": skl,
    "ID_SKL": idSkl,
    "KURS": kurs,
    "SMS": sms,
    "HRD_D1": hrdD1,
    "HRD_D2": hrdD2,
    "HRD_D3": hrdD3,
    "HRD_D4": hrdD4,
    "HRD_D5": hrdD5,
    "CHK_D1": chkD1,
    "CHK_D2": chkD2,
    "CHK_D3": chkD3,
    "CHK_D4": chkD4,
    "CHK_D5": chkD5,
    "CHK_D6": chkD6,
    "CHK_D7": chkD7,
    "CHK_D8": chkD8,
    "VOZ_D1": vozD1,
    "VOZ_D2": vozD2,
    "VOZ_D3": vozD3,
    "VOZ_D4": vozD4,
    "VOZ_D5": vozD5,
    "VOZ_D6": vozD6,
    "VOZ_D7": vozD7,
    "TL_D1": tlD1,
    "TL_D2": tlD2,
    "TL_D3": tlD3,
    "TL_D4": tlD4,
    "TL_D5": tlD5,
    "TL_D6": tlD6,
    "HARID": harid,
  };
}

