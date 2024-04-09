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

  PlanModel({
    required this.taskDone,
    required this.taskOut,
    required this.taskGo,
    required this.percent,
    required this.f,
    required this.weekday,
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
