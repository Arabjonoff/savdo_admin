import 'dart:convert';
List<DebtClientModel> debtClientModelFromJson(String str) => List<DebtClientModel>.from(json.decode(str).map((x) => DebtClientModel.fromJson(x)));
class DebtClientModel {
  int id;
  int tp;
  String idToch;
  num osK;
  num osKS;

  DebtClientModel({
    required this.id,
    required this.tp,
    required this.idToch,
    required this.osK,
    required this.osKS,
  });

  factory DebtClientModel.fromJson(Map<String, dynamic> json) => DebtClientModel(
    id: json["ID"]??0,
    tp: json["TP"]??0,
    idToch: json["ID_TOCH"]??"",
    osK: json["OS_K"]??0,
    osKS: json["OS_K_S"]??0,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "TP": tp,
    "ID_TOCH": idToch,
    "OS_K": osK,
    "OS_K_S": osKS,
  };

}
