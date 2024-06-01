import 'package:savdo_admin/src/database/db_helper.dart';

class DbRevision{
  final dbProvider = DatabaseHelper.instance;
  Future<int> saveRevision(Map<String,Object> item) async {
    final dbClient = await dbProvider.db;
    var result = await dbClient.insert('revision',item,);
    return result;
  }
  Future<List<Map<String,Object>>> getRevision()async{
    final dbClient = await dbProvider.db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM revision ORDER BY id DESC');
    List<Map<String,Object>> data = [];
    for(int i =0; i<list.length;i++){
      Map<String,Object> s = {
        "ID":list[i]["ID"],
        "NAME":list[i]["NAME"],
        "ID_SKL2":list[i]["ID_SKL2"],
        "SONI":list[i]["SONI"],
        "N_SONI":list[i]["N_SONI"],
        "F_SONI":list[i]["F_SONI"],
        "NARHI":list[i]["NARHI"],
        "NARHI_S":list[i]["NARHI_S"],
        "SNARHI":list[i]["SNARHI"],
        "SNARHI_S":list[i]["SNARHI_S"],
        "SNARHI1":list[i]["SNARHI1"],
        "SNARHI1_S":list[i]["SNARHI1_S"],
        "SNARHI2":list[i]["SNARHI2"],
        "SNARHI2_S":list[i]["SNARHI2_S"],
      };
    data.add(s);
    }
    return data;
  }
  Future<void> clearRevision() async {
    final dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM revision");
  }
}