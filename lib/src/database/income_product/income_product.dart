
import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';

class IncomeProductBase {
  IncomeProductBase? incomeProductBase;
  DatabaseHelper dbProvider = DatabaseHelper.instance;


  Future<int> saveIncomeProduct(Map<String,dynamic> item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('incomeProduct', item);
    return res;
  }
  Future<int> updateIncomeProduct(IncomeAddModel item) async {
    var dbClient = await dbProvider.db;
    var res = await dbClient.update(
      'incomeProduct',
      item.toJsonUpd(),
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
          id: list[i]['ID']??0,
          price: list[i]['price']??0,
          idSklPr: list[i]['ID_SKL_PR'],
          idSkl2: list[i]['ID_SKL2'],
          name: list[i]['NAME'],
          idTip: list[i]['ID_TIP']??0,
          idFirma: list[i]['ID_FIRMA']??0,
          idEdiz: list[i]['ID_EDIZ']??0,
          soni: list[i]['SONI']??0,
          narhi: list[i]['NARHI']??0,
          narhiS: list[i]['NARHI_S']??0,
          sm: list[i]['SM']??0,
          smS: list[i]['SM_S']??0,
          snarhi: list[i]['SNARHI']??0,
          snarhiS: list[i]['SNARHI_S']??0,
          snarhi1: list[i]['SNARHI1']??0,
          snarhi1S: list[i]['SNARHI1_S']??0,
          snarhi2: list[i]['SNARHI2']??0,
          snarhi2S: list[i]['SNARHI2_S']??0,
          tnarhi: list[i]['TNARHI']??0,
          tnarhiS: list[i]['TNARHI_S']??0,
          tsm: list[i]['TSM']??0,
          tsmS: list[i]['TSM_S']??0,
          ssmS: list[i]['SSM_S']??0,
          ssm: list[i]['SSM']??0,
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
