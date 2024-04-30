import 'dart:convert';

List<DebtClientDetail> debtClientDetailFromJson(String str) => List<DebtClientDetail>.from(json.decode(str).map((x) => DebtClientDetail.fromJson(x)));

class DebtClientDetail {
  int id;
  int idUser;
  int idOper;
  String name;
  DateTime sana;
  num oKarzi;
  num oKarziS;
  dynamic tovar;
  dynamic tovarS;
  dynamic tovarP;
  dynamic tovarPS;
  num tulov;
  num tulovS;
  dynamic tulovP;
  dynamic tulovPS;
  dynamic kaytdi;
  dynamic kaytdiS;
  num kKarzi;
  num kKarziS;
  dynamic skidka;
  dynamic skidkaS;
  String yil;
  String oy;
  String idToch;
  int idToch0;
  int pn;
  int idSklPr;

  DebtClientDetail({
    required this.id,
    required this.idUser,
    required this.idOper,
    required this.name,
    required this.sana,
    required this.oKarzi,
    required this.oKarziS,
    required this.tovar,
    required this.tovarS,
    required this.tovarP,
    required this.tovarPS,
    required this.tulov,
    required this.tulovS,
    required this.tulovP,
    required this.tulovPS,
    required this.kaytdi,
    required this.kaytdiS,
    required this.kKarzi,
    required this.kKarziS,
    required this.skidka,
    required this.skidkaS,
    required this.yil,
    required this.oy,
    required this.idToch,
    required this.idToch0,
    required this.pn,
    required this.idSklPr,
  });

  factory DebtClientDetail.fromJson(Map<String, dynamic> json) => DebtClientDetail(
    id: json["ID"]??0,
    idUser: json["ID_USER"]??0,
    idOper: json["ID_OPER"]??0,
    name: json["NAME"]??"",
    sana: json["SANA"] == null?DateTime.now():DateTime.parse(json["SANA"]),
    oKarzi: json["O_KARZI"]??0,
    oKarziS: json["O_KARZI_S"]??0.0,
    tovar: json["TOVAR"]??0,
    tovarS: json["TOVAR_S"]??0,
    tovarP: json["TOVAR_P"]??0,
    tovarPS: json["TOVAR_P_S"]??0,
    tulov: json["TULOV"]??0,
    tulovS: json["TULOV_S"]??0.0,
    tulovP: json["TULOV_P"]??0,
    tulovPS: json["TULOV_P_S"]??0,
    kaytdi: json["KAYTDI"]??0,
    kaytdiS: json["KAYTDI_S"]??0,
    kKarzi: json["K_KARZI"]??0,
    kKarziS: json["K_KARZI_S"]??0,
    skidka: json["SKIDKA"]??0,
    skidkaS: json["SKIDKA_S"]??0,
    yil: json["YIL"]??'',
    oy: json["OY"]??"",
    idToch: json["ID_TOCH"]??0,
    idToch0: json["ID_TOCH0"],
    pn: json["PN"],
    idSklPr: json["ID_SKL_PR"],
  );
}