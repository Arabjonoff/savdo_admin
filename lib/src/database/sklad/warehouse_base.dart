
import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class WareHouseBaseHelper{
  DatabaseHelper dbProvider = DatabaseHelper.instance;
  Future<int> saveWareHouse(ProductTypeAllResult item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.insert(
      'skladlist',
      item.toJson(),
    );
    return result;
  }
  Future<List<ProductTypeAllResult>> getWareHouse() async {
    final dbClient = await dbProvider.db;
    List<Map> list =
    await dbClient.rawQuery('SELECT * FROM skladlist ORDER BY id DESC');
    List<ProductTypeAllResult> productType = <ProductTypeAllResult>[];
    for (int i = 0; i < list.length; i++) {
      ProductTypeAllResult data = ProductTypeAllResult(
          id: list[i]["ID"], name: list[i]["NAME"], st: list[i]["ST"]);
      productType.add(data);
    }
    return productType;
  }
  Future<void> clearWareHouse()async{
    final dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM skladlist");
  }
}