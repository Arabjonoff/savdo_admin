
import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';

class IncomeProductBase {
  IncomeProductBase? incomeProductBase;
  DatabaseHelper dbProvider = DatabaseHelper.instance;


  Future<int> saveIncomeProduct(IncomeAddModel item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('incomeProduct', item.toJsonIns());
    return res;
  }
  Future<int> updateIncomeProduct(IncomeAddModel item) async {
    var dbClient = await dbProvider.db;
    var res = await dbClient.update(
      'incomeProduct',
      item.toJsonIns(),
      where: 'id = ?',
      whereArgs: [item.id]
    );
    return res;
  }
  Future<int> deleteIncomeProduct(IncomeAddModel item) async {
    var dbClient = await dbProvider.db;
    var res = await dbClient.delete(
        'incomeProduct',
        where: 'id = ?',
        whereArgs: [item.id]
    );
    return res;
  }
  Future<List<IncomeAddModel>> getIncomeProduct() async {
    var dbClient = await dbProvider.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM incomeProduct');
    List<IncomeAddModel> data = <IncomeAddModel>[];
    for (int i = 0; i < list.length; i++) {
      IncomeAddModel incomeAddModel = IncomeAddModel(
          id: list[i]['ID'],
          price: list[i]['price'],
          idSklPr: list[i]['ID_SKL_PR'],
          idSkl2: list[i]['ID_SKL2'],
          name: list[i]['NAME'],
          idTip: list[i]['ID_TIP'],
          idFirma: list[i]['ID_FIRMA'],
          idEdiz: list[i]['ID_EDIZ'],
          soni: list[i]['SONI'],
          narhi: list[i]['NARHI'],
          narhiS: list[i]['NARHI_S'],
          sm: list[i]['SM'],
          smS: list[i]['SM_S'],
          snarhi: list[i]['SNARHI'],
          snarhiS: list[i]['SNARHI_S'],
          snarhi1: list[i]['SNARHI1'],
          snarhi1S: list[i]['SNARHI1_S'],
          snarhi2: list[i]['SNARHI2'],
          snarhi2S: list[i]['SNARHI2_S'],
          tnarhi: list[i]['TNARHI'],
          tnarhiS: list[i]['TNARHI_S'],
          tsm: list[i]['TSM'],
          tsmS: list[i]['TSM_S'],
          shtr: list[i]['SHTR']);
      data.add(incomeAddModel);
    }
    return data;
  }
  Future<void>clearIncomeProduct()async{
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM incomeProduct");
  }
}
