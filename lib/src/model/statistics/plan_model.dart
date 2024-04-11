import 'dart:convert';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
  int taskDone;
  int taskOut;
  int taskGo;
  double percent;
  double f;
  int weekday;
  String agentName;

  PlanModel({
    required this.taskDone,
    required this.taskOut,
    required this.taskGo,
    required this.percent,
    required this.f,
    required this.weekday,
     this.agentName = '',
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
    taskDone: json["taskDone"]??0,
    taskOut: json["taskOut"]??0,
    taskGo: json["taskGo"]??0,
    percent: json["percent"]??0,
    f: json["f"]??0,
    weekday: json["weekday"]??0,
  );

  Map<String, dynamic> toJson() => {
    "taskDone": taskDone,
    "taskOut": taskOut,
    "taskGo": taskGo,
    "percent": percent,
    "f": f,
    "weekday": weekday,
  };
}

AgentModel agentModelFromJson(String str) => AgentModel.fromJson(json.decode(str));

String agentModelToJson(AgentModel data) => json.encode(data.toJson());

class AgentModel {
  String name;
  Agents agents;

  AgentModel({
    required this.name,
    required this.agents,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
    name: json["name"],
    agents: Agents.fromJson(json["agents"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "agents": agents.toJson(),
  };
}

class Agents {
  String name;
  int goAgent;
  int doneAgent;
  num percent;

  Agents({
    required this.name,
    required this.goAgent,
    required this.doneAgent,
    required this.percent,
  });

  factory Agents.fromJson(Map<String, dynamic> json) => Agents(
    name: json["name"],
    goAgent: json["goAgent"],
    doneAgent: json["doneAgent"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "goAgent": goAgent,
    "doneAgent": doneAgent,
    "percent": percent,
  };
}

