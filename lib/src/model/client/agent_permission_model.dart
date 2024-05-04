import 'dart:convert';

AgentPermissionModel agentPermissionModelFromJson(String str) => AgentPermissionModel.fromJson(json.decode(str));

String agentPermissionModelToJson(AgentPermissionModel data) => json.encode(data.toJson());

class AgentPermissionModel {
  bool status;
  List<AgentPermissionResult> data;

  AgentPermissionModel({
    required this.status,
    required this.data,
  });

  factory AgentPermissionModel.fromJson(Map<String, dynamic> json) => AgentPermissionModel(
    status: json["status"],
    data: List<AgentPermissionResult>.from(json["data"].map((x) => AgentPermissionResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AgentPermissionResult {
  int tp;
  int p1;
  int p2;
  int p3;
  int p4;
  int p5;

  AgentPermissionResult({
    required this.tp,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
    required this.p5,
  });

  factory AgentPermissionResult.fromJson(Map<String, dynamic> json) => AgentPermissionResult(
    tp: json["TP"],
    p1: json["P1"],
    p2: json["P2"],
    p3: json["P3"],
    p4: json["P4"],
    p5: json["P5"],
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
