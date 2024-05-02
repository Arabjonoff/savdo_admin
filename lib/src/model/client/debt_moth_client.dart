
import 'dart:convert';

List<DebtMonthClientModel> debtMonthClientModelFromJson(String str) => List<DebtMonthClientModel>.from(json.decode(str).map((x) => DebtMonthClientModel.fromJson(x)));

String debtMonthClientModelToJson(List<DebtMonthClientModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DebtMonthClientModel {
  String name;
  String idToch;
  int? osK;
  double? osKS;
  int tp;

  DebtMonthClientModel({
    required this.name,
    required this.idToch,
    required this.osK,
    required this.osKS,
    required this.tp,
  });

  factory DebtMonthClientModel.fromJson(Map<String, dynamic> json) => DebtMonthClientModel(
    name: json["name"],
    idToch: json["id_toch"],
    osK: json["os_k"],
    osKS: json["os_k_s"]?.toDouble(),
    tp: json["tp"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id_toch": idToch,
    "os_k": osK,
    "os_k_s": osKS,
    "tp": tp,
  };
}
