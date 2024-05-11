import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/model/client/agent_permission_model.dart';
import 'package:savdo_admin/src/model/expense/expense_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';
import 'package:savdo_admin/src/utils/cache.dart';
String db = CacheService.getDb();
int userId = CacheService.getIdAgent();
int idSkl = CacheService.getidSkl();
String token = CacheService.getToken();

class ApiProvider {
  var date = DateTime.now();
  var year = DateTime.now().year;
  var month = DateTime.now().month;
  final String _baseUrl = "https://naqshsoft.site/";
  static const _duration = Duration(seconds: 60);
  static Future<HttpResult> _patchRequest(String url, body,) async {
    print(url);
    print(body);
    try {
      http.Response response = await http.patch(
        Uri.parse(url),
        headers: {"Accept": "application/json",},
        body: body,
      ).timeout(_duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    } on SocketException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    }
  }
  static Future<HttpResult> _deleteRequest(String url, body,) async {
    print(url);
    print(body);
    try {
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {"Accept": "application/json",},
        body: body,
      ).timeout(_duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    } on SocketException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    }
  }
  /// API Post Request
  static Future<HttpResult> _postRequest(String url, body,) async {
    print(url);
    print(body);
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Accept": "application/json",},
        body: body,
      ).timeout(_duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    } on SocketException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    }
  }
  static Future<HttpResult> _postRequestImage(String url, image,idSkl2,) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['skl2_image'] = image;
      request.fields['skl2_id'] = idSkl2;
      if (image != "") {
        request.files.add(
          await http.MultipartFile.fromPath("skl2_image", image),
        );
      }
      var response = await request.send();
      http.Response responseData = await http.Response.fromStream(response);
      return _result(responseData);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    } on SocketException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    }
  }
  /// API Get Request
  static Future<HttpResult> _getRequest(String url,) async {
    print(url);
    try {
      http.Response response = await http.get(Uri.parse(url),).timeout(_duration);
      return _result(response);
    } on TimeoutException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    } on SocketException catch (_) {
      return HttpResult(
        isSuccess: false,
        result: "",
        statusCode: -1,
      );
    }
  }
  static HttpResult _result(http.Response response) {
    print(response.statusCode);
    print(response.body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: true,
        result: json.decode(utf8.decode(response.bodyBytes)),
      );
    } else {
      try {
        var info = json.decode(
          response.body,
        );
        return HttpResult(
          isSuccess: false,
          statusCode: response.statusCode,
          result: info,
        );
      } catch (_) {
        return HttpResult(
          isSuccess: false,
          statusCode: response.statusCode,
          result: response.body,
        );
      }
    }
  }


  Future<HttpResult> login(name,password,base)async{
    String url = "${_baseUrl}login-api.php?DB=$base";
    var data = {
      "name":name,
      "password":password
    };
    return await _postRequest(url,json.encode(data));
  }
  /// Product Add Get,Post,Delete API
  Future<HttpResult> getProduct()async{
    String url = "${_baseUrl}skl2?DB=$db&JWT=";
    return await _getRequest(url);
  }
  Future<HttpResult> postProduct(name,idTip,idQuantity,idFirma,vz,minCount,st)async{
    var body = {
      "NAME":name,
      "ID_TIP":idTip,
      "ID_EDIZ":idQuantity,
      "ID_FIRMA":idFirma,
      "VZ":vz,
      "MSONI":minCount,
      "ST":st,
    };
    String url = "${_baseUrl}skl2_ins?DB=$db&JWT=";
    return await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> updateProduct(id,name,idTip,idQuantity,idFirma,vz,minCount,st)async{
    var body = {
      "ID":id,
      "NAME":name,
      "ID_TIP":idTip,
      "ID_EDIZ":idQuantity,
      "ID_FIRMA":idFirma,
      "VZ":vz,
      "MSONI":minCount,
      "ST":st,
    };
    String url = "${_baseUrl}skl2_upd?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> deleteProduct(name,id)async{
    var body = {
      "NAME":name,
      "ID":id
    };
    String url = "${_baseUrl}skl2_del?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(body));
  }

  /// Product Type Get Post Delete API
  Future<HttpResult> getProductType()async{
    String url = "${_baseUrl}tip?DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> postProductType(String name)async{
    var body = {
      "NAME":name,
      "ST":1
    };
    String url = "${_baseUrl}tip_ins?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> deleteProductType(String name,int id)async{
    var body = {
      "NAME":name,
      "ID":"$id"
    };
    String url = "${_baseUrl}tip_del?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(body));
  }

  /// Quantity Type Get Post Delete API
  Future<HttpResult> getQuantityType()async{
    String url = "${_baseUrl}ediz?DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> postQuantityType(String name)async{
    String url = "${_baseUrl}ediz_ins?DB=$db&JWT=$token";
    var body = {
      "NAME":name,
      "ST":1
    };
    return await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> deleteQuantityType(String name,int id)async{
    var body = {
      "NAME":name,
      "ID":"$id"
    };
    String url = "${_baseUrl}ediz_del?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(body));
  }

  /// Get Quantity Type API
  Future<HttpResult> getFirmaType()async{
    String url = "${_baseUrl}firma?DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> postFirmaType(String name)async{
    var body = {
      "NAME":name,
      "ST":1
    };
    String url = "${_baseUrl}firma_ins?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> deleteFirmaType(String name,int id)async{
    var body = {
      "NAME":name,
      "ID":"$id"
    };
    String url = "${_baseUrl}firma_del?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(body));
  }

  /// Barcode API
  Future<HttpResult> getBarcodeDetail(id)async{
    String url = "${_baseUrl}shtr?DB=$db&ID=$id&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> getBarcode()async{
    String url = "${_baseUrl}shtr?DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> postBarcode(name,barcode,idSkl2)async{
    String url = "${_baseUrl}shtr_ins?DB=$db&JWT=$token";
    var data = {
      "NAME":name,
      "SHTR":barcode,
      "ID_SKL2":idSkl2
    };
    return await _postRequest(url,json.encode(data));
  }
  Future<HttpResult> deleteBarcode(name,id,)async{
    String url = "${_baseUrl}shtr_del?DB=$db&JWT=$token";
    var data = {
      "NAME":name,
      "ID":id,
    };
    return await _postRequest(url,json.encode(data));
  }

  /// Sklad API
  Future<HttpResult> getSklad(year,month,idSkl)async{
    String url = "${_baseUrl}sklad01?DB=$db&YIL=$year&OY=$month&ID_SKL0=$idSkl&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> postImage(image,idSkl2)async{
    String url = "${_baseUrl}image?DB=$db&JWT=$token";
    return  await _postRequestImage(url,image,idSkl2);
  }
  Future<HttpResult> getIncome(year,month,idSkl)async{
    String url = "${_baseUrl}kirim?DB=$db&ID_SKL=$idSkl&YIL=$year&OY=$month&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> addIncome(name,idT,doc,date,comment,idHodim,idSkl,)async{
    var body = {
      "NAME": name,
      "ID_T": idT,
      "NDOC": doc,
      "SANA": date,
      "IZOH": comment,
      "ID_HODIM": idHodim,
      "ID_SKL": idSkl,
      "YIL": year,
      "OY": month
    };
    String url = "${_baseUrl}kirim0_ins?DB=$db&JWT=$token";
    return  await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> updateIncome(id,name,idT,doc,date,comment,idHodim,idSkl,)async{
    var body = {
      "ID":id,
      "NAME": name,
      "ID_T": idT,
      "NDOC": doc,
      "SANA": date,
      "IZOH": comment,
      "ID_HODIM": idHodim,
      "ID_SKL": idSkl,
      "YIL": year,
      "OY": month
    };
    String url = "${_baseUrl}kirim0_upd?DB=$db&JWT=$token";
    return await _patchRequest(url,json.encode(body));
  }
  Future<HttpResult> deleteIncome(id)async{
    String url = "${_baseUrl}kirim0_del?ID=$id&DB=$db&JWT=$token";
    var body = {
      "ID":id
    };
    return await _deleteRequest(url,json.encode(body));
  }
  Future<HttpResult> lockIncome(id,prov)async{
    String url = "${_baseUrl}kirim0_prov?DB=$db&JWT=$token";
    var data = {
      "ID":id,
      "PROV":prov
    };
    return await _patchRequest(url,json.encode(data));
  }


  /// Client Api
  Future<HttpResult> addClient(Map<String, dynamic> item)async{
    String url = "${_baseUrl}haridor_ins?DB=$db&JWT=$token";
    return _postRequest(url, json.encode(item));
  }
  Future<HttpResult> deleteClient(int id,String idT,name)async{
    String url = "${_baseUrl}haridor_del?DB=$db&JWT=$token";
    var body = {
      "ID":id,
      "NAME": "$idT,$name"
    };
    return await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> getDebtClientDetail()async{
    String url = "${_baseUrl}haridor?DB=$db&YIL=$year&OY=$month&ID_SKL=1&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> updateClient(item)async{
    String url = "${_baseUrl}haridor_upd?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(item));
  }
  Future<HttpResult> addClientType(name)async{
    String url = "${_baseUrl}faol_ins?DB=$db&JWT=$token";
    var body = {
      "NAME":name,
      "ST":1,
    };
    return await _postRequest(url, json.encode(body));
  }
  Future<HttpResult> getClientType()async{
    String url = "${_baseUrl}faol?DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> deleteClientType(name,id)async{
    String url = "${_baseUrl}faol_del?DB=$db&JWT=$token";
    var body = {
      "NAME":name,
      "ID":"$id"
    };
    return await _postRequest(url, json.encode(body));
  }
  Future<HttpResult> addClientClass(name)async{
    String url = "${_baseUrl}klass_ins?DB=$db&JWT=$token";
    var body = {
      "NAME":name,
      "ST":1,
    };
    return await _postRequest(url, json.encode(body));
  }
  Future<HttpResult> getClientClass()async{
    String url = "${_baseUrl}klass?DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> deleteClientClass(name,id)async{
    String url = "${_baseUrl}klass_del?DB=$db&JWT=$token";
    var body = {
      "NAME":name,
      "ID":"$id"
    };
    return await _postRequest(url, json.encode(body));
  }
  Future<HttpResult> getClientWorker()async{
    String url = "${_baseUrl}hodimlar?ST=1&DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> clientDebt(year,month)async{
    String url = "${_baseUrl}tochka?DB=$db&JWT=$token&YIL=$year&OY=$month";
    return await _getRequest(url);
  }
  Future<HttpResult> clientDetail(year,month,idT,tp)async{
    String url = "${_baseUrl}hisob?DB=$db&YIL=$year&OY=$month&ID_TOCH=$idT&TP=0&JWT=$token";
    return await _getRequest(url);
  }

  /// Document post and get api
  Future<HttpResult> setDoc(int st)async{
    /// 1 income
    /// 2 outcome
    /// 5 warehouse
    String url = "${_baseUrl}setndocs?DB=$db";
    var body = {
      "ST":st,
      "PR":0
    };
    return await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> getDoc(int st)async{
    String url = "${_baseUrl}getndocs?ST=$st&DB=$db&JWT=$token";
    return await _getRequest(url,);
  }

  /// Income add,get,delete api
  Future<HttpResult> addIncomeSklPr(IncomeAddModel body)async{
    String url = "${_baseUrl}kirim1_ins?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(body.toJsonIns()));
  }
  Future<HttpResult> updateIncomeSklPr(IncomeAddModel body)async{
    String url = "${_baseUrl}kirim1_upd?DB=$db&JWT=$token";
    return await _patchRequest(url,json.encode(body.toJsonUpd()));
  }
  Future<HttpResult> updateIncome2SklPr(List<Map> body)async{
    String url = "${_baseUrl}kirim1_upd2?DB=$db&JWT=$token";
    return await _patchRequest(url,json.encode(body));
  }
  Future<HttpResult> deleteIncomeSklPr(id,idSklPr,idSkl2)async{
    String url = "${_baseUrl}kirim1_del?ID=$id&ID_SKL_PR=$idSklPr&ID_SKL2=$idSkl2&DB=$db&SANA=2024-04-01&JWT=$token";
    return await _deleteRequest(url,{});
  }

  /// Outcome add,get,delete api
  Future<HttpResult> addDocOutcome(Map item)async{
    String url = "${_baseUrl}chikim0_ins?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(item));
  }
  Future<HttpResult> updateDocOutcome(Map item)async{
    String url = "${_baseUrl}chikim0_upd?DB=$db&JWT=$token";
    return await _patchRequest(url,json.encode(item));
  }
  Future<HttpResult> addOutcomeSklRs(data)async{
    String url = "${_baseUrl}chikim1_ins?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(data));
  }
  Future<HttpResult> updateOutcomeSklRs(data)async{
    String url = "${_baseUrl}chikim1_upd?DB=$db&JWT=$token";
    return await _patchRequest(url,json.encode(data));
  }
  Future<HttpResult> deleteOutcomeSklRs(id,idSklRs,idSkl2)async{
    String url = "${_baseUrl}chikim1_del?ID=$id&ID_SKL_RS=$idSklRs&ID_SKL2=$idSkl2&DB=$db&JWT=$token";
    return await _deleteRequest(url,{});
  }
  Future<HttpResult> deleteOutcomeDoc(id)async{
    String url = "${_baseUrl}chikim0_del?DB=$db&JWT=$token&ID=$id";
    var data = {"ID":id};
    return await _deleteRequest(url,json.encode(data));
  }

  Future<HttpResult> addIncomePayment(Map payment)async{
    String url = "${_baseUrl}tl1_reg?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(payment));
  }
  Future<HttpResult> updateIncomePayment(Map payment)async{
    String url = "${_baseUrl}tl1_upd?DB=$db&JWT=$token";
    return await _patchRequest(url,json.encode(payment));
  }
  Future<HttpResult> deleteIncomePayment(id,idSana)async{
    String url = "${_baseUrl}tl1_del?DB=$db&JWT=$token&ID=$id&ID_SANA=$idSana";
    return await _deleteRequest(url,{});
  }


  ///

  Future<HttpResult> getTypeExpense()async{
    String url = "${_baseUrl}s_har?DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> addExpense(AddExpenseModel item)async{
    String url = "${_baseUrl}t_har_ins?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(item.toJson()));
  }
  Future<HttpResult> updateExpense(Map item)async{
    String url = "${_baseUrl}t_har_upd?DB=$db&JWT=$token";
    return await _patchRequest(url,json.encode(item));
  }
  Future<HttpResult> deleteExpense(id,idSana)async{
    String url = "${_baseUrl}t_har_del?DB=$db&JWT=$token&ID=$id&ID_SANA=$idSana";
    return await _deleteRequest(url,{});
  }
  Future<HttpResult> getDatePayment()async{
    String url = "${_baseUrl}tl0_reg?DB=$db&JWT=$token";
    var data = {
      "SANA":DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "YIL":DateTime.now().year.toString(),
      "OY":DateTime.now().month.toString(),
      "ID_CHET":1
    };
    return await _postRequest(url,json.encode(data));
  }
  Future<HttpResult> getPaymentsDaily(date)async{
    String url = "${_baseUrl}tl0Sana?DB=$db&JWT=$token&YIL=$year&OY=$month&SANA=$date&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> getSkladPer(year,month,idSkl)async{
    String url = "${_baseUrl}skl01_per2?DB=$db&JWT=$token";
    var body = {
      "YIL":year,
      "OY":month,
      "ID_SKL":idSkl
    };
    return await _patchRequest(url, json.encode(body));
  }
  Future<HttpResult> resetSkladPer(body,year,month,idSkl)async{
    String url = "${_baseUrl}perechet2?DB=$db&YIL=$year&OY=$month&ID_SKL=$idSkl&JWT=$token";
    return await _postRequest(url, json.encode(body));
  }
  Future<HttpResult> getSkladSkl2(year,month,idSkl)async{
    String url = "${_baseUrl}sklad01_skl2_list?DB=$db&YIL=$year&OY=$month&ID_SKL0=$idSkl&JWT=$token";
    return await _getRequest(url,);
  }
  Future<HttpResult> resetSkladSkl2(body,year,month,idSkl)async{
    String url = "${_baseUrl}yangioy2?DB=$db&YIL=$year&OY=$month&ID_SKL0=$idSkl&JWT=$token";
    return await _patchRequest(url, json.encode(body));
  }
  Future<HttpResult> getWareHouse()async{
    String url = "${_baseUrl}s_skl?DB=$db&JWT=$token";
    return await _getRequest(url,);
  }

  Future<HttpResult> getProductOutCome()async{
    String url = "${_baseUrl}sklad01?DB=$db&JWT=$token&YIL=$year&OY=$month&ID_SKL0=$idSkl";
    return await _getRequest(url,);
  }
  Future<HttpResult> getOutCome(date)async{
    // String url = "${_baseUrl}chikim_agent?DB=$db&DT=$date&ID_AGENT=$userId&ID_SKL=$idSkl&JWT=$token";
    String url = "${_baseUrl}chikim2?DB=$db&DT1=$date&DT2=$date&ID_SKL=$idSkl&JWT=$token";
    return await _getRequest(url,);
  }
  Future<HttpResult> lockOutcome(id,prov)async{
    String url = "${_baseUrl}chikim0_prov?DB=$db&JWT=$token";
    var data = {
      "ID":id,
      "PROV":prov
    };
    return await _patchRequest(url,json.encode(data));
  }
  Future<HttpResult> warehouseTransfer(Map data)async{
    String url = "${_baseUrl}per0_ins?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(data));
  }
  Future<HttpResult> warehouseTransferItem(Map data)async{

    String url = "${_baseUrl}per1_ins?DB=$db&JWT=$token";
    return await _postRequest(url,json.encode(data));
  }
  Future<HttpResult> warehouseTransferItemUpdate(Map data)async{
    String url = "${_baseUrl}per1_upd?DB=$db&JWT=$token";
    return await _patchRequest(url,json.encode(data));
  }
  Future<HttpResult> warehouseTransferItemDelete(id,idSklPer,idSkl2)async{
    String url = "${_baseUrl}per1_del?DB=$db&ID=$id&ID_SKL_PER=$idSklPer&ID_SKL2=$idSkl2&JWT=$token";
    return await _deleteRequest(url,{});
  }
  Future<HttpResult> getWarehouseTransfer(year,month)async{
    String url = "${_baseUrl}per?DB=$db&ID_SKL=$idSkl&YIL=$year&OY=$month&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> lockWarehouse(id,prov)async{
    String url = "${_baseUrl}per0_prov?DB=$db&JWT=$token";
    var data = {
      "ID":id,
      "PROV":prov
    };
    return await _patchRequest(url,json.encode(data));
  }
  Future<HttpResult> deleteWarehouseTransfer(id)async{
    String url = "${_baseUrl}per0_del?DB=$db&JWT=$token&ID=$id";
    var data = {
      "ID":id,
    };
    return await _deleteRequest(url,json.encode(data));
  }
  Future<HttpResult> getCurrency()async{
    String url = "${_baseUrl}getkurs?DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> getBalance(date)async{
    String url = "${_baseUrl}get_blns?DB=$db&YIL=$year&OY=$month&SANA=$date";
    return await _getRequest(url);
  }

  Future<HttpResult> getIncomePrice(idSkl2)async{
    String url = "${_baseUrl}kirim_narh?ID_SKL2=$idSkl2&DB=$db&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> getOldDebtClient(year,month)async{
    String url = "${_baseUrl}tochka2?DB=$db&YIL=$year&OY=$month&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> postNewDebtClient(year,month,List<Map> data)async{
    String url = "${_baseUrl}tochka_yangi_oy?DB=$db&YIL=$year&OY=$month&TP=1&JWT=$token";
    return await _postRequest(url,json.encode(data));
  }
  Future<HttpResult> getStaffPermission(id)async{
    String url = "${_baseUrl}user-per.php/user_per?DB=$db&JWT=$token&ID=$id";
    return await _getRequest(url);
  }
  Future<HttpResult> getAgentPermission(id)async{
    String url = "${_baseUrl}user-per.php/user_per0?DB=$db&ID=$id&JWT=$token";
    return await _getRequest(url);
  }
  Future<HttpResult> postStaffPermission(List<StaffPermissionResult> map,id)async{
    String url = "${_baseUrl}user-per.php/user_dost_upd?DB=$db&JWT=$token&ID=$id";
    return await _postRequest(url,json.encode(map));
  }
  Future<HttpResult> postAgentPermission(Map map,id)async{
    String url = "${_baseUrl}user-per.php/user_dost0_upd?DB=$db&JWT=$token&ID=$id";
    return await _postRequest(url,json.encode(map));
  }
}