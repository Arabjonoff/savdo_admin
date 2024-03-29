import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/income/income_model.dart';

class SklPrTovBase{
  SklPrTovBase? sklPrTovBase;
  DatabaseHelper dbProvider = DatabaseHelper.instance;
  Future<int> saveSklPrTov(SklPrTovResult item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('skl_pr_tov', item.toJson());
    return res;
  }
  Future<int> updateSklPrTov(SklPrTovResult item) async {
    var dbClient = await dbProvider.db;
    var res = await dbClient.update(
        'skl_pr_tov',
        item.toJson(),
        where: 'id = ?',
        whereArgs: [item.id]
    );
    return res;
  }
  Future<int> deleteSklPrTov(id) async {
    var dbClient = await dbProvider.db;
    var res = await dbClient.delete(
        'skl_pr_tov',
        where: 'id = ?',
        whereArgs: [id]
    );
    return res;
  }
  Future<List<SklPrTovResult>> getSklPrTov() async {
    var dbClient = await dbProvider.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM skl_pr_tov');
    List<SklPrTovResult> data = <SklPrTovResult>[];
    for (int i = 0; i < list.length; i++) {
      SklPrTovResult incomeAddModel = SklPrTovResult(
          id: list[i]['ID'],
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
          shtr: list[i]['SHTR'],
          ssm: list[i]['SSM'],
          ssmS: list[i]['SSM_S']);
      data.add(incomeAddModel);
    }
    return data;
  }
  Future<void>clearSklPrTov()async{
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM skl_pr_tov");
  }
}