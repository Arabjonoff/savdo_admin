
import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';

class OutcomeSkladBaseHelper {
  OutcomeSkladBaseHelper? outcomeSkladBaseHelper;
  DatabaseHelper dbProvider = DatabaseHelper.instance;

  /// Outcome Cart DataBase
  Future<int> saveOutcomeCart(SklRsTov item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('outcomeProduct', item.toJson());
    print(await res);
    return res;
  }
  Future<List<SklRsTov>> getOutcomeCart() async {
    var dbClient = await dbProvider.db;
    List<SklRsTov> data = <SklRsTov>[];
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM outcomeProduct ORDER BY id DESC");
    for (int i = 0; i < list.length; i++) {
      SklRsTov sklRsTov = SklRsTov(
          id: list[i]["ID"],
          name: list[i]["NAME"],
          idSkl2: list[i]["ID_SKL2"],
          soni: list[i]["SONI"],
          narhi: list[i]["NARHI"],
          narhiS: list[i]["NARHI_S"],
          sm: list[i]["SM"],
          smS: list[i]["SM_S"],
          idTip: list[i]["ID_TIP"],
          idFirma: list[i]["ID_FIRMA"],
          idEdiz: list[i]["ID_EDIZ"],
          snarhi: list[i]["SNARHI"],
          snarhiS: list[i]["SNARHI_S"],
          ssm: list[i]["SSM"],
          ssmS: list[i]["SSM_S"],
          fr: list[i]["FR"],
          frS: list[i]["FR_S"],
          vz: list[i]["VZ"],
          shtr: list[i]["SHTR"]
      );
      data.add(sklRsTov);
    }
    return data;
  }
  Future<int> updateOutcomeCart(SklRsTov item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.update(
        'outcomeProduct', item.toJson(), where: 'id=?', whereArgs: [item.id]);
    return res;
  }
  Future<int> deleteOutcomeCart(id)async{
    var dbClient = await dbProvider.db;
    return dbClient.delete("outcomeProduct",where: 'id=?',whereArgs: [id]);
  }
  Future<void> clearOutcomeCart()async{
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM outcomeProduct");
  }

}