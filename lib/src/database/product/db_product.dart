import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';

class DbProduct {
  DbProduct? dbProduct;
  final dbProvider = DatabaseHelper.instance;

  Future<int> saveProduct(Skl2Result item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.insert('product',item.toJson(),);
    print(result);
    return result;
  }

  Future<List<Skl2Result>> getProduct() async {
    var dbClient = await dbProvider.db;
    List<Skl2Result> data = <Skl2Result>[];
    List<Map> list = await dbClient.rawQuery("SELECT * FROM product ORDER BY id DESC");
    for (int i = 0; i < list.length; i++) {
      Skl2Result skl2result = Skl2Result(
        id: list[i]["ID"],
        name: list[i]["NAME"],
        idTip: list[i]["ID_TIP"],
        idFirma: list[i]["ID_FIRMA"],
        idEdiz: list[i]["ID_EDIZ"],
        photo: list[i]["PHOTO"],
        vz: list[i]["VZ"],
        msoni: list[i]["MSONI"],
        st: list[i]["ST"],
        tipName: list[i]["tipName"],
        firmName: list[i]["firmName"],
        edizName: list[i]["edizName"],
      );
      data.add(skl2result);
    }
    return data;
  }

  Future<List<Skl2Result>> searchProduct(obj) async {
    var dbClient = await dbProvider.db;
    List<Skl2Result> data = <Skl2Result>[];
    List<Map> list = await dbClient.rawQuery("SELECT * FROM product WHERE name LIKE '%$obj%' or ID LIKE '%$obj%' ORDER BY id DESC");
    for (int i = 0; i < list.length; i++) {
      Skl2Result skl2result = Skl2Result(
        id: list[i]["ID"],
        name: list[i]["NAME"],
        idTip: list[i]["ID_TIP"],
        idFirma: list[i]["ID_FIRMA"],
        idEdiz: list[i]["ID_EDIZ"],
        photo: list[i]["PHOTO"],
        vz: list[i]["VZ"],
        msoni: list[i]["MSONI"],
        st: list[i]["ST"],
        tipName: list[i]["tipName"],
        firmName: list[i]["firmName"],
        edizName: list[i]["edizName"],
      );
      data.add(skl2result);
    }
    return data;
  }



  Future<int> updateProduct(Skl2Result item)async{
    final dbClient = await dbProvider.db;
    return await dbClient.update("product",item.toJson(),where: 'id=?',whereArgs: [item.id]);
  }
  Future<int> deleteProduct(id)async{
    final dbClient = await dbProvider.db;
    return await dbClient.delete("product",where: 'id=?',whereArgs: [id]);
  }
  Future<void> clearProduct()async{
    final dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM product");
  }
}
