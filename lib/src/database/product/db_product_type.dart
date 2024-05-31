

import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/product/barcode_model.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class DbProductType {
  DbProductType? dbProductType;
  final dbProvider = DatabaseHelper.instance;

  /// ProductType Base
  Future<int> saveProductType(ProductTypeAllResult item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.insert(
      'product_type',
      item.toJson(),
    );
    return result;
  }
  Future<List<ProductTypeAllResult>> getProductType() async {
    final dbClient = await dbProvider.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM product_type ORDER BY id DESC');
    List<ProductTypeAllResult> productType = <ProductTypeAllResult>[];
    for (int i = 0; i < list.length; i++) {
      ProductTypeAllResult data = ProductTypeAllResult(
          id: list[i]["ID"], name: list[i]["NAME"], st: list[i]["ST"]);
      productType.add(data);
    }
    return productType;
  }
  Future<void> clearProductType() async {
    final dbClient = await dbProvider.db;
   await dbClient.rawQuery("DELETE FROM product_type");
  }

  /// QuantityType Base
  Future<int> saveQuantityType(ProductTypeAllResult item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.insert(
      'quantity_type',
      item.toJson(),
    );
    return result;
  }
  Future<List<ProductTypeAllResult>> getQuantityType() async {
    final dbClient = await dbProvider.db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM quantity_type ORDER BY id DESC');
    List<ProductTypeAllResult> productType = <ProductTypeAllResult>[];
    for (int i = 0; i < list.length; i++) {
      ProductTypeAllResult data = ProductTypeAllResult(
          id: list[i]["ID"], name: list[i]["NAME"], st: list[i]["ST"]);
      productType.add(data);
    }
    return productType;
  }
  Future<void> clearQuantityType() async {
    final dbClient = await dbProvider.db;
   await dbClient.rawQuery("DELETE FROM quantity_type");
  }

  /// FirmaType Base
  Future<int> saveFirmaType(ProductTypeAllResult item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.insert(
      'product_firma',
      item.toJson(),
    );
    return result;
  }
  Future<List<ProductTypeAllResult>> getFirmaType() async {
    final dbClient = await dbProvider.db;
    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM product_firma ORDER BY id DESC');
    List<ProductTypeAllResult> productType = <ProductTypeAllResult>[];
    for (int i = 0; i < list.length; i++) {
      ProductTypeAllResult data = ProductTypeAllResult(
          id: list[i]["ID"], name: list[i]["NAME"], st: list[i]["ST"]);
      productType.add(data);
    }
    return productType;
  }
  Future<void> clearFirmaType() async {
    final dbClient = await dbProvider.db;
   await dbClient.rawQuery("DELETE FROM product_firma");
  }

  /// Barcode Base
  Future<int> saveBarcode(BarcodeResult item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.insert(
      'barcode',
      item.toJson(),
    );
    return result;
  }
  Future<List<BarcodeResult>> getBarcode() async {
    final dbClient = await dbProvider.db;
    List<BarcodeResult> data = <BarcodeResult>[];
    List<Map> list = await dbClient.rawQuery("SELECT * FROM barcode");
    for (int i = 0; i < list.length; i++) {
      BarcodeResult barcodeResult = BarcodeResult(
        id: list[i]["ID"],
        name: list[i]["NAME"],
        shtr: list[i]["SHTR"],
        idSkl2: list[i]["ID_SKL2"],
        vaqt: list[i]["VAQT"],
      );
      data.add(barcodeResult);
    }
    return data;
  }
  Future<int> updateBarcode(BarcodeResult item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.update(
      'barcode',
      item.toJson(),
      where: 'id=?',
      whereArgs: [item.id]
    );
    return result;
  }

  Future<void> clearBarcode()async{
    final dbClient = await dbProvider.db;
     await dbClient.rawQuery("DELETE FROM barcode");
  }



  Future<int> saveExpense(ProductTypeAllResult item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.insert(
      'expense',
      item.toJson(),
    );
    return result;
  }
  Future<List<ProductTypeAllResult>> getExpenseType() async {
    final dbClient = await dbProvider.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM expense ORDER BY id DESC');
    List<ProductTypeAllResult> productType = <ProductTypeAllResult>[];
    for (int i = 0; i < list.length; i++) {
      ProductTypeAllResult data = ProductTypeAllResult(
          id: list[i]["ID"],
          name: list[i]["NAME"],
          st: list[i]["ST"]);
      productType.add(data);
    }
    return productType;
  }
  Future<void> clearExpense()async{
    final dbClient = await dbProvider.db;
     await dbClient.rawQuery("DELETE FROM expense");
  }

}
