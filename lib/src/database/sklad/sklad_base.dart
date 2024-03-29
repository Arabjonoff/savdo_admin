import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';

class SkladBaseHelper {
  SkladBaseHelper? skladBaseHelper;
  DatabaseHelper dbProvider = DatabaseHelper.instance;
  Future<int> saveSklad(SkladResult item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('sklad', item.toJson());
    print(await res);
    return res;
  }
  Future<List<SkladResult>> getSklad() async {
    var dbClient = await dbProvider.db;
    List<SkladResult> data = <SkladResult>[];
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM sklad ORDER BY id DESC");
    for (int i = 0; i < list.length; i++) {
      SkladResult skladResult = SkladResult(
          id: list[i]["ID"],
          name: list[i]["NAME"],
          idSkl2: list[i]["ID_SKL2"],
          idTip: list[i]["ID_TIP"],
          idFirma: list[i]["ID_FIRMA"],
          idEdiz: list[i]["ID_EDIZ"],
          narhi: list[i]["NARHI"],
          narhiS: list[i]["NARHI_S"],
          snarhi: list[i]["SNARHI"],
          snarhiS: list[i]["SNARHI_S"],
          snarhi1: list[i]["SNARHI1"],
          snarhi1S: list[i]["SNARHI1_S"],
          snarhi2: list[i]["SNARHI2"],
          snarhi2S: list[i]["SNARHI2_S"],
          ksoni: list[i]["KSONI"],
          ksm: list[i]["KSM"],
          ksmS: list[i]["KSM_S"],
          psoni: list[i]["PSONI"],
          psm: list[i]["PSM"],
          psmS: list[i]["PSM_S"],
          rsoni: list[i]["RSONI"],
          rsm: list[i]["RSM"],
          rsmS: list[i]["RSM_S"],
          hsoni: list[i]["HSONI"],
          hsm: list[i]["HSM"],
          hsmS: list[i]["HSM_S"],
          vsoni: list[i]["VSONI"],
          vsm: list[i]["VSM"],
          vsmS: list[i]["VSM_S"],
          vzsoni: list[i]["VZSONI"],
          vzsm: list[i]["VZSM"],
          vzsmS: list[i]["VZSM_S"],
          psksoni: list[i]["PSKSONI"],
          psksm: list[i]["PSKSM"],
          psksmS: list[i]["PSKSM_S"],
          rsksoni: list[i]["RSKSONI"],
          rsksm: list[i]["RSKSM"],
          rsksmS: list[i]["RSKSM_S"],
          osoni: list[i]["OSONI"],
          osm: list[i]["OSM"],
          osmS: list[i]["OSM_S"],
          osmT: list[i]["OSM_T"],
          osmTS: list[i]["OSM_T_S"],
          ksmT: list[i]["KSM_T"],
          ksmTS: list[i]["KSM_T_S"],
          yil: list[i]["YIL"],
          oy: list[i]["OY"],
          idSkl0: list[i]["ID_SKL0"],
          foyda: list[i]["FOYDA"],
          foydaS: list[i]["FOYDA_S"],
          soni: list[i]["SONI"],
          vz: list[i]["VZ"],
          photo: list[i]["PHOTO"]);
      data.add(skladResult);
    }
    return data;
  }
  Future<List<SkladResult>> getSkladSearch(obj) async {
    var dbClient = await dbProvider.db;
    List<SkladResult> data = <SkladResult>[];
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM sklad WHERE name LIKE '%$obj%' ORDER BY id DESC");
    for (int i = 0; i < list.length; i++) {
      SkladResult skladResult = SkladResult(
          id: list[i]["ID"],
          name: list[i]["NAME"],
          idSkl2: list[i]["ID_SKL2"],
          idTip: list[i]["ID_TIP"],
          idFirma: list[i]["ID_FIRMA"],
          idEdiz: list[i]["ID_EDIZ"],
          narhi: list[i]["NARHI"],
          narhiS: list[i]["NARHI_S"],
          snarhi: list[i]["SNARHI"],
          snarhiS: list[i]["SNARHI_S"],
          snarhi1: list[i]["SNARHI1"],
          snarhi1S: list[i]["SNARHI1_S"],
          snarhi2: list[i]["SNARHI2"],
          snarhi2S: list[i]["SNARHI2_S"],
          ksoni: list[i]["KSONI"],
          ksm: list[i]["KSM"],
          ksmS: list[i]["KSM_S"],
          psoni: list[i]["PSONI"],
          psm: list[i]["PSM"],
          psmS: list[i]["PSM_S"],
          rsoni: list[i]["RSONI"],
          rsm: list[i]["RSM"],
          rsmS: list[i]["RSM_S"],
          hsoni: list[i]["HSONI"],
          hsm: list[i]["HSM"],
          hsmS: list[i]["HSM_S"],
          vsoni: list[i]["VSONI"],
          vsm: list[i]["VSM"],
          vsmS: list[i]["VSM_S"],
          vzsoni: list[i]["VZSONI"],
          vzsm: list[i]["VZSM"],
          vzsmS: list[i]["VZSM_S"],
          psksoni: list[i]["PSKSONI"],
          psksm: list[i]["PSKSM"],
          psksmS: list[i]["PSKSM_S"],
          rsksoni: list[i]["RSKSONI"],
          rsksm: list[i]["RSKSM"],
          rsksmS: list[i]["RSKSM_S"],
          osoni: list[i]["OSONI"],
          osm: list[i]["OSM"],
          osmS: list[i]["OSM_S"],
          osmT: list[i]["OSM_T"],
          osmTS: list[i]["OSM_T_S"],
          ksmT: list[i]["KSM_T"],
          ksmTS: list[i]["KSM_T_S"],
          yil: list[i]["YIL"],
          oy: list[i]["OY"],
          idSkl0: list[i]["ID_SKL0"],
          foyda: list[i]["FOYDA"],
          foydaS: list[i]["FOYDA_S"],
          soni: list[i]["SONI"],
          vz: list[i]["VZ"],
          photo: list[i]["PHOTO"]);
      data.add(skladResult);
    }
    return data;
  }
  Future<int> updateSklad(SkladResult item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.update(
        'sklad', item.toJson(), where: 'id=?', whereArgs: [item.id]);
    return res;
  }
  Future<void> clearSklad()async{
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM sklad");
  }
}