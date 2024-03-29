
import 'dart:convert';

ProductTypeAll quantityModelFromJson(String str) => ProductTypeAll.fromJson(json.decode(str));

String quantityModelToJson(ProductTypeAll data) => json.encode(data.toJson());

class ProductTypeAll {
  bool status;
  List<ProductTypeAllResult> data;

  ProductTypeAll({
    required this.status,
    required this.data,
  });

  factory ProductTypeAll.fromJson(Map<String, dynamic> json) => ProductTypeAll(
    status: json["status"],
    data: List<ProductTypeAllResult>.from(json["data"].map((x) => ProductTypeAllResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductTypeAllResult {
  int id;
  String name;
  int st;

  ProductTypeAllResult({
    required this.id,
    required this.name,
    required this.st,
  });

  factory ProductTypeAllResult.fromJson(Map<String, dynamic> json) => ProductTypeAllResult(
    id: json["ID"]??0,
    name: json["NAME"]??"",
    st: json["ST"]??0,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "NAME": name,
    "ST": st,
  };
}
