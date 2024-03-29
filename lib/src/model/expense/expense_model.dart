// To parse this JSON data, do
//
//     final addExpenseModel = addExpenseModelFromJson(jsonString);

import 'dart:convert';


String addExpenseModelToJson(AddExpenseModel data) => json.encode(data.toJson());

class AddExpenseModel {
  String sana;
  String idAgent;
  int idNima;
  num sm;
  int idValuta;
  num idSana;
  String yil;
  String oy;
  String idHodimlar;
  String izoh;
  int idChet;
  dynamic idSklPr;
  int idSklPer;

  AddExpenseModel({
    required this.sana,
    required this.idAgent,
    required this.idNima,
    required this.sm,
    required this.idValuta,
    required this.idSana,
    required this.yil,
    required this.oy,
    required this.idHodimlar,
    required this.izoh,
    required this.idChet,
    required this.idSklPr,
    required this.idSklPer,
  });


  Map<String, dynamic> toJson() => {
    "SANA": sana,
    "ID_AGENT": idAgent,
    "ID_NIMA": idNima,
    "SM": sm,
    "ID_VALUTA": idValuta,
    "ID_SANA": idSana,
    "YIL": yil,
    "OY": oy,
    "ID_HODIMLAR": idHodimlar,
    "IZOH": izoh,
    "ID_CHET": idChet,
    "ID_SKL_PR": idSklPr,
    "ID_SKL_PER": idSklPer,
  };
}
