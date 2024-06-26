import 'package:savdo_admin/src/database/db_helper.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class DbClient {
  DbClient? dbClient;
  DatabaseHelper dbProvider = DatabaseHelper.instance;

  /// Client save get clear
  Future<int> saveClient(ClientResult item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('client', item.toJson());
    return res;
  }

  Future<List<ClientResult>> getClient() async {
    var dbClient = await dbProvider.db;
    List<ClientResult> data = <ClientResult>[];
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM client ORDER BY TP DESC",);
    for (int i = 0; i < list.length; i++) {
      ClientResult clientResult = ClientResult(
          id: list[i]["ID"],
          name: list[i]["NAME"],
          idT: list[i]["ID_T"],
          izoh: list[i]["IZOH"],
          manzil: list[i]["MANZIL"],
          tel: list[i]["TEL"],
          tp: list[i]["TP"],
          idNarh: list[i]["ID_NARH"],
          idFaol: list[i]["ID_FAOL"],
          idKlass: list[i]["ID_KLASS"],
          idAgent: list[i]["ID_AGENT"],
          sms: list[i]["SMS"],
          vaqt: list[i]["VAQT"],
          idHodimlar: list[i]["ID_HODIMLAR"],
          naqd: list[i]["NAQD"],
          pas: list[i]["PAS"],
          d1: list[i]["D1"],
          d2: list[i]["D2"],
          d3: list[i]["D3"],
          d4: list[i]["D4"],
          h1: list[i]["H1"],
          h2: list[i]["H2"],
          h3: list[i]["H3"],
          h4: list[i]["H4"],
          h5: list[i]["H5"],
          h6: list[i]["H6"],
          h7: list[i]["H7"],
          muljal: list[i]["MULJAL"],
          st: list[i]["ST"]);
      data.add(clientResult);
    }
    return data;
  }

  Future<List<ClientResult>> getClientSearch(obj) async {
    var dbClient = await dbProvider.db;
    List<ClientResult> data = <ClientResult>[];
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM client  WHERE name LIKE ? OR id_t LIKE ? OR tel LIKE ? ORDER BY TP DESC",
        ['%$obj%', '%$obj%', '%$obj%']);
    for (int i = 0; i < list.length; i++) {
      ClientResult clientResult = ClientResult(
          id: list[i]["ID"],
          name: list[i]["NAME"],
          idT: list[i]["ID_T"],
          izoh: list[i]["IZOH"],
          manzil: list[i]["MANZIL"],
          tel: list[i]["TEL"],
          tp: list[i]["TP"],
          idNarh: list[i]["ID_NARH"],
          idFaol: list[i]["ID_FAOL"],
          idKlass: list[i]["ID_KLASS"],
          idAgent: list[i]["ID_AGENT"],
          sms: list[i]["SMS"],
          vaqt: list[i]["VAQT"],
          idHodimlar: list[i]["ID_HODIMLAR"],
          naqd: list[i]["NAQD"],
          pas: list[i]["PAS"],
          d1: list[i]["D1"],
          d2: list[i]["D2"],
          d3: list[i]["D3"],
          d4: list[i]["D4"],
          h1: list[i]["H1"],
          h2: list[i]["H2"],
          h3: list[i]["H3"],
          h4: list[i]["H4"],
          h5: list[i]["H5"],
          h6: list[i]["H6"],
          h7: list[i]["H7"],
          muljal: list[i]["MULJAL"],
          st: list[i]["ST"]);
      data.add(clientResult);
    }
    return data;
  }

  Future<int> deleteClient(id) async {
    var dbClient = await dbProvider.db;
    return dbClient.delete("client", where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateClient(ClientResult item) async {
    var dbClient = await dbProvider.db;
    return dbClient
        .update("client", item.toJson(), where: 'id=?', whereArgs: [item.id]);
  }

  Future<void> clearClient() async {
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM client");
  }

  /// Client Active Type save get clear
  Future<int> saveClientType(ProductTypeAllResult item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('clientType', item.toJson());
    return res;
  }

  Future<List<ProductTypeAllResult>> getClientType() async {
    var dbClient = await dbProvider.db;
    List<ProductTypeAllResult> data = <ProductTypeAllResult>[];
    List<Map> list =
        await dbClient.rawQuery("SELECT * FROM clientType ORDER BY id DESC");
    for (int i = 0; i < list.length; i++) {
      ProductTypeAllResult productTypeAllResult = ProductTypeAllResult(
          id: list[i]["ID"], name: list[i]["NAME"], st: list[i]["ST"]);
      data.add(productTypeAllResult);
    }
    return data;
  }

  Future<void> clearClientType() async {
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM clientType");
  }

  Future<int> deleteClientType(id) async {
    var dbClient = await dbProvider.db;
    return dbClient.delete("clientType", where: 'id=?', whereArgs: [id]);
  }

  /// Client Class Type save get clear
  Future<int> saveClientClassType(ProductTypeAllResult item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('clientKlass', item.toJson());
    return res;
  }

  Future<List<ProductTypeAllResult>> getClientClassType() async {
    var dbClient = await dbProvider.db;
    List<ProductTypeAllResult> data = <ProductTypeAllResult>[];
    List<Map> list =
        await dbClient.rawQuery("SELECT * FROM clientKlass ORDER BY id DESC");
    for (int i = 0; i < list.length; i++) {
      ProductTypeAllResult productTypeAllResult = ProductTypeAllResult(
          id: list[i]["ID"], name: list[i]["NAME"], st: list[i]["ST"]);
      data.add(productTypeAllResult);
    }
    return data;
  }

  Future<void> clearClientClassType() async {
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM clientKlass");
  }

  Future<int> deleteClientClass(id) async {
    var dbClient = await dbProvider.db;
    return dbClient.delete("clientKlass", where: 'id=?', whereArgs: [id]);
  }

  /// Client debt base
  Future<int> saveClientDebt(DebtClientModel item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('client_debt', item.toJson());
    print("Debt Client Insert: >>> ${await res}");
    return await res;
  }

  Future<List<DebtClientModel>> getClientDebt() async {
    var dbClient = await dbProvider.db;
    List<DebtClientModel> data = <DebtClientModel>[];
    List<Map> list = await dbClient.rawQuery("SELECT * FROM client_debt ORDER BY ID_AGENT DESC");
    for (int i = 0; i < list.length; i++) {
      DebtClientModel debtClientModel = DebtClientModel(
        id: list[i]["ID"],
        tp: list[i]["TP"],
        name: list[i]["NAME"],
        idToch: list[i]["ID_TOCH"],
        yil: list[i]["YIL"],
        oy: list[i]["OY"],
        klK: list[i]["KL_K"],
        klKS: list[i]["KL_K_S"],
        pr: list[i]["PR"],
        prS: list[i]["PR_S"],
        st: list[i]["ST"],
        stS: list[i]["ST_S"],
        kt: list[i]["KT"],
        ktS: list[i]["KT_S"],
        tlK: list[i]["TL_K"],
        tlKS: list[i]["TL_K_S"],
        tlC: list[i]["TL_C"],
        tlCS: list[i]["TL_C_S"],
        sd: list[i]["SD"],
        sdS: list[i]["SD_S"],
        osK: list[i]["OS_K"],
        osKS: list[i]["OS_K_S"],
        sti: list[i]["STI"],
        idAgent: list[i]["ID_AGENT"],
        idFaol: list[i]["ID_FAOL"],
        dtM: list[i]["DT_M"],
        dtT: list[i]["DT_T"],
        manzil: list[i]["MANZIL"],
      );
      data.add(debtClientModel);
    }
    return data;
  }

  Future<List<DebtClientModel>> getClientSearchDebt(obj) async {
    var dbClient = await dbProvider.db;
    List<DebtClientModel> data = <DebtClientModel>[];
    List<Map> list = await dbClient.rawQuery("SELECT * FROM client_debt WHERE name LIKE ? OR MANZIL LIKE ? OR ID_TOCH LIKE ?",
        ['%$obj%', '%$obj%','%$obj%',]);
    for (int i = 0; i < list.length; i++) {
      DebtClientModel debtClientModel = DebtClientModel(
        id: list[i]["ID"],
        tp: list[i]["TP"],
        name: list[i]["NAME"],
        idToch: list[i]["ID_TOCH"],
        yil: list[i]["YIL"],
        oy: list[i]["OY"],
        klK: list[i]["KL_K"],
        klKS: list[i]["KL_K_S"],
        pr: list[i]["PR"],
        prS: list[i]["PR_S"],
        st: list[i]["ST"],
        stS: list[i]["ST_S"],
        kt: list[i]["KT"],
        ktS: list[i]["KT_S"],
        tlK: list[i]["TL_K"],
        tlKS: list[i]["TL_K_S"],
        tlC: list[i]["TL_C"],
        tlCS: list[i]["TL_C_S"],
        sd: list[i]["SD"],
        sdS: list[i]["SD_S"],
        osK: list[i]["OS_K"],
        osKS: list[i]["OS_K_S"],
        sti: list[i]["STI"],
        idAgent: list[i]["ID_AGENT"],
        idFaol: list[i]["ID_FAOL"],
        dtM: list[i]["DT_M"],
        dtT: list[i]["DT_T"],
        manzil: list[i]["MANZIL"],
      );
      data.add(debtClientModel);
    }
    return data;
  }

  Future<int> updateClientDebt(DebtClientModel item) async {
    var dbClient = await dbProvider.db;
    return dbClient.update("client_debt", item.toJson(),
        where: 'id = ?', whereArgs: [item.id]);
  }

  Future<void> clearClientDebt() async {
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM client_debt");
  }
  /// Agents base
  Future<int> saveAgents(AgentsResult item) async {
    var dbClient = await dbProvider.db;
    var res = dbClient.insert('agents', item.toJson());
    return res;
  }

  Future<List<AgentsResult>> getAgents() async {
    var dbClient = await dbProvider.db;
    List<AgentsResult> data = <AgentsResult>[];
    List<Map> list = await dbClient.rawQuery("SELECT * FROM agents");
    for (int i = 0; i < list.length; i++) {
      AgentsResult agentsResult = AgentsResult(
          id: list[i]['ID'],
          name: list[i]['NAME'],
          fio: list[i]['FIO'],
          tel: list[i]['TEL'],
          tip: list[i]['TIP'],
          pas: list[i]['PAS'],
          oklad: list[i]['OKLAD'],
          oylik: list[i]['OYLIK'],
          skl: list[i]['SKL'],
          idSkl: list[i]['ID_SKL'],
          st: list[i]['ST'],
          shtr: list[i]['SHTR'],
          sms: list[i]['SMS'],
          vaqt: list[i]['VAQT']);
      data.add(agentsResult);
    }
    return data;
  }

  Future<int> updateAgents(AgentsResult item) async {
    var dbClient = await dbProvider.db;
    return dbClient
        .update("agents", item.toJson(), where: 'id=?', whereArgs: [item.id]);
  }

  Future<void> clearAgents() async {
    var dbClient = await dbProvider.db;
    await dbClient.rawQuery("DELETE FROM agents");
  }
}
