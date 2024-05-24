import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/database/client/db_client.dart';
import 'package:savdo_admin/src/database/income_product/income_product.dart';
import 'package:savdo_admin/src/database/outcome/outcome_base.dart';
import 'package:savdo_admin/src/database/product/db_product.dart';
import 'package:savdo_admin/src/database/product/db_product_type.dart';
import 'package:savdo_admin/src/database/sklad/sklad_base.dart';
import 'package:savdo_admin/src/database/sklad/warehouse_base.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/model/expense/expense_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/model/product/barcode_model.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';

class Repository{
  /// Database requests
  final DbProductType _productType = DbProductType();
  final DbProduct _product = DbProduct();
  final DbClient _dbClient = DbClient();
  final IncomeProductBase _incomeProductBase = IncomeProductBase();
  final SkladBaseHelper _skladBaseHelper = SkladBaseHelper();
  final WareHouseBaseHelper _wareHouseBaseHelper = WareHouseBaseHelper();
  final OutcomeSkladBaseHelper _outcomeSkladBaseHelper = OutcomeSkladBaseHelper();


  /// Product save get delete base
  Future<int> saveProductBase(item) => _product.saveProduct(item);
  Future<List<Skl2Result>> getProductBase() => _product.getProduct();
  Future<List<Skl2Result>> searchProduct(obj) => _product.searchProduct(obj);
  Future<int> deleteProductBase(id) => _product.deleteProduct(id);
  Future<int> updateProductBase(item) => _product.updateProduct(item);
  Future<void> clearProduct() => _product.clearProduct();

  /// Product Type save get delete base
  Future<int> saveProductTypeBase(item) => _productType.saveProductType(item);
  Future<List<ProductTypeAllResult>> getProductTypeBase() => _productType.getProductType();
  Future<void> clearProductTypeBase() => _productType.clearProductType();

  /// Quantity save get delete base
  Future<int> saveQuantityTypeBase(item) => _productType.saveQuantityType(item);
  Future<List<ProductTypeAllResult>> getQuantityTypBase() => _productType.getQuantityType();
  Future<void> clearQuantityTypeBase() => _productType.clearQuantityType();

  /// Firm type save get delete base
  Future<int> saveFirmaTypeBase(item) => _productType.saveFirmaType(item);
  Future<List<ProductTypeAllResult>> getFirmaTypeBase() => _productType.getFirmaType();
  Future<void> clearFirmaTypeBase() => _productType.clearFirmaType();

  /// Barcode save get delete base
  Future<int>saveBarcodeBase(item) => _productType.saveBarcode(item);
  Future<int>updateBarcodeBase(item) => _productType.updateBarcode(item);
  Future<List<BarcodeResult>>getBarcodeBase() => _productType.getBarcode();
  Future<void>clearBarcodeBase() => _productType.clearBarcode();

  /// Client save get delete base
  Future<int> saveClientBase(item) => _dbClient.saveClient(item);
  Future<List<ClientResult>> getClientBase() => _dbClient.getClient();
  Future<int> updateClientBase(item) => _dbClient.updateClient(item);
  Future<int> deleteClientBase(id) => _dbClient.deleteClient(id);
  Future<void> clearClient() => _dbClient.clearClient();

  /// Client Class save get delete base
  Future<int> saveClientClassTypeBase(item) => _dbClient.saveClientClassType(item);
  Future<List<ProductTypeAllResult>> getClientClassTypeBase() => _dbClient.getClientClassType();
  Future<void>clearClientClassTypeBase() => _dbClient.clearClientClassType();
  Future<int>deleteClientClassBase(id) => _dbClient.deleteClientClass(id);


  /// Client Type save get delete base
  Future<int> saveClientTypeBase(item) => _dbClient.saveClientType(item);
  Future<List<ProductTypeAllResult>> getClientTypeBase() => _dbClient.getClientType();
  Future<void>clearClientTypeBase() => _dbClient.clearClientType();
  Future<int>deleteClientTypeBase(id) => _dbClient.deleteClientType(id);


  /// Client Debt
  Future<int> saveClientDebtBase(item) => _dbClient.saveClientDebt(item);
  Future<int> updateClientDebtBase(item) => _dbClient.updateClientDebt(item);
  Future<List<DebtClientModel>> getClientDebtBase() => _dbClient.getClientDebt();
  Future<List<DebtClientModel>> getClientDebtSearchBase(obj) => _dbClient.getClientSearchDebt(obj);
  Future<void> clearClientDebtBase() => _dbClient.clearClientDebt();


  /// Agents Base
  Future<int> saveAgentsBase(item) => _dbClient.saveAgents(item);
  Future<int> updateAgentsBase(item) => _dbClient.updateAgents(item);
  Future<List<AgentsResult>> getAgentsBase() => _dbClient.getAgents();
  Future<void> clearAgents() => _dbClient.clearAgents();


  /// Expense Type base
  Future<int> saveExpenseBase(item) => _productType.saveExpense(item);
  Future<List<ProductTypeAllResult>> getExpenseTypeBase() => _productType.getExpenseType();

  /// Income Product base
  Future<int> saveIncomeProductBase(item) => _incomeProductBase.saveIncomeProduct(item);
  Future<List<IncomeAddModel>> getIncomeProductBase() => _incomeProductBase.getIncomeProduct();
  Future<int> updateIncomeProductBase(item) => _incomeProductBase.updateIncomeProduct(item);
  Future<int> deleteIncomeProduct(item) => _incomeProductBase.deleteIncomeProduct(item);
  Future<void>clearIncomeProductBase() => _incomeProductBase.clearIncomeProduct();


  /// Outcome cart base
  Future<int> saveOutcomeCart(item) => _outcomeSkladBaseHelper.saveOutcomeCart(item);
  Future<List<SklRsTov>> getOutcomeCart() => _outcomeSkladBaseHelper.getOutcomeCart();
  Future<int> updateOutcomeCart(item) => _outcomeSkladBaseHelper.updateOutcomeCart(item);
  Future<int> deleteOutcomeCart(item) => _outcomeSkladBaseHelper.deleteOutcomeCart(item);
  Future<void>clearOutcomeCart() => _outcomeSkladBaseHelper.clearOutcomeCart();


  /// Outcome cart base
  Future<int> saveReturnedCart(item) => _outcomeSkladBaseHelper.saveOutcomeCart(item);
  Future<List<SklRsTov>> getReturnedCart() => _outcomeSkladBaseHelper.getOutcomeCart();
  Future<int> updateReturnedCart(item) => _outcomeSkladBaseHelper.updateOutcomeCart(item);
  Future<int> deleteReturnedCart(item) => _outcomeSkladBaseHelper.deleteOutcomeCart(item);
  Future<void>clearReturnedCart() => _outcomeSkladBaseHelper.clearOutcomeCart();


  /// Sklad base
  Future<int> saveSkladBase(item) => _skladBaseHelper.saveSklad(item);
  Future<List<SkladResult>> getSkladBase() => _skladBaseHelper.getSklad();
  Future<List<SkladResult>> getSkladSearchBase(obj) => _skladBaseHelper.getSkladSearch(obj);
  Future<int> updateSkladBase(item) => _skladBaseHelper.updateSklad(item);
  Future<void>clearSkladBase() => _skladBaseHelper.clearSklad();


  /// WareHouse Base
  Future<int> saveWareHouseBase(item) => _wareHouseBaseHelper.saveWareHouse(item);
  Future<List<ProductTypeAllResult>> getWareHouseBase() => _wareHouseBaseHelper.getWareHouse();
  Future<void> clearWareHouseBase() => _wareHouseBaseHelper.clearWareHouse();

  /// API Requests
  final ApiProvider _apiProvider = ApiProvider();

  /// Api product
  Future<HttpResult>  getProduct() => _apiProvider.getProduct();
  Future<HttpResult> postProduct(name, idTip, idQuantity, idFirma, vz, minCount, st) => _apiProvider.postProduct(name, idTip, idQuantity, idFirma, vz, minCount, st);
  Future<HttpResult> updateProduct(id,name, idTip, idQuantity, idFirma, vz, minCount, st) => _apiProvider.updateProduct(id,name, idTip, idQuantity, idFirma, vz, minCount, st);
  Future<HttpResult> deleteProduct(name, id) => _apiProvider.deleteProduct(name, id);

  /// Api product type
  Future<HttpResult> getProductType() => _apiProvider.getProductType();
  Future<HttpResult> postProductType(name) => _apiProvider.postProductType(name);
  Future<HttpResult> deleteProductType(name,id) => _apiProvider.deleteProductType(name,id);

  /// Api product Quantity
  Future<HttpResult> getQuantityType() => _apiProvider.getQuantityType();
  Future<HttpResult> postQuantityType(name) => _apiProvider.postQuantityType(name);
  Future<HttpResult> deleteQuantityType(name,id) => _apiProvider.deleteQuantityType(name,id);

  /// Api product firma
  Future<HttpResult> getFirmaType() => _apiProvider.getFirmaType();
  Future<HttpResult> postFirmaType(name) => _apiProvider.postFirmaType(name);
  Future<HttpResult> deleteFirmaType(name,id) => _apiProvider.deleteFirmaType(name,id);

  /// Api barcode
  Future<HttpResult> getBarcode() => _apiProvider.getBarcode();
  Future<HttpResult> getBarcodeDetail(id) => _apiProvider.getBarcodeDetail(id);
  Future<HttpResult> postBarcode(name, barcode, idSkl2) => _apiProvider.postBarcode(name, barcode, idSkl2);
  Future<HttpResult> deleteBarcode(name, id) => _apiProvider.deleteBarcode(name, id);

  Future<HttpResult> postImage(image, idSkl2) => _apiProvider.postImage(image, idSkl2);

  /// Api Income
  Future<HttpResult> getIncome(year,month,idSkl) => _apiProvider.getIncome(year,month,idSkl);
  Future<HttpResult> getIncomePrice(idSkl2) => _apiProvider.getIncomePrice(idSkl2);
  Future<HttpResult> addIncome(Map map)=>_apiProvider.addIncome(map);
  Future<HttpResult> updateIncome(Map map)=>_apiProvider.updateIncome(map);
  Future<HttpResult> deleteIncome(id)=>_apiProvider.deleteIncome(id);
  Future<HttpResult> lockIncome(id,prov)=>_apiProvider.lockIncome(id,prov);



  Future<HttpResult> getDebtClientDetail() => _apiProvider.getDebtClientDetail();
  Future<HttpResult> getClientWorker() => _apiProvider.getClientWorker();

  /// Api Outcome
  Future<HttpResult> getProductOutCome() => _apiProvider.getProductOutCome();
  Future<HttpResult> getOutCome(date,idSkl) => _apiProvider.getOutCome(date,idSkl);
  Future<HttpResult> lockOutcome(id,prov) => _apiProvider.lockOutcome(id, prov);
  Future<HttpResult> addOutcomeSklRs(Map data) => _apiProvider.addOutcomeSklRs(data);
  Future<HttpResult> updateOutcomeSklRs(Map data) => _apiProvider.updateOutcomeSklRs(data);
  Future<HttpResult> deleteOutcomeSklRs(id,idSklRs,idSkl2) => _apiProvider.deleteOutcomeSklRs(id,idSklRs,idSkl2);

  /// Api Payment income ,outcome, cost
  Future<HttpResult> addIncomePayment(Map payment) => _apiProvider.addIncomePayment(payment);
  Future<HttpResult> deleteIncomePayment(id,idSana) => _apiProvider.deleteIncomePayment(id,idSana);
  Future<HttpResult> updateIncomePayment(Map payment) => _apiProvider.updateIncomePayment(payment);




  Future<HttpResult> getDoc(int st) => _apiProvider.getDoc(st);
  Future<HttpResult> setDoc(int st) => _apiProvider.setDoc(st);
  Future<HttpResult> addIncomeSklPr(IncomeAddModel body) => _apiProvider.addIncomeSklPr(body);
  Future<HttpResult> updateIncomeSklPr(IncomeAddModel body) => _apiProvider.updateIncomeSklPr(body);
  Future<HttpResult> updateIncome2SklPr(List<Map> body) => _apiProvider.updateIncome2SklPr(body);
  Future<HttpResult> deleteIncomeSklPr(id,idSklPr,idSkl2) => _apiProvider.deleteIncomeSklPr(id,idSklPr,idSkl2);
  Future<HttpResult> getTypeExpense() => _apiProvider.getTypeExpense();
  Future<HttpResult> addExpense(AddExpenseModel item) => _apiProvider.addExpense(item);
  Future<HttpResult> updateExpense(Map item) => _apiProvider.updateExpense(item);
  Future<HttpResult> deleteExpense(id,idDate) => _apiProvider.deleteExpense(id,idDate);
  Future<HttpResult> getDatePayment() => _apiProvider.getDatePayment();
  Future<HttpResult> login(name,password,base) => _apiProvider.login(name, password, base);
  Future<HttpResult> getPaymentsDaily(date) => _apiProvider.getPaymentsDaily(date);
  Future<HttpResult> getClientClass() => _apiProvider.getClientClass();
  Future<HttpResult> getClientType() => _apiProvider.getClientType();
  Future<HttpResult> addClientClass(name) => _apiProvider.addClientClass(name);
  Future<HttpResult> addClientType(name) => _apiProvider.addClientType(name);
  Future<HttpResult> addClient(Map<String, dynamic> item) => _apiProvider.addClient(item);
  Future<HttpResult> updateClient(Map<String, dynamic> item) => _apiProvider.updateClient(item);
  Future<HttpResult> deleteClient(id,idT,name) => _apiProvider.deleteClient(id,idT,name);
  Future<HttpResult> clientDebt(year,month) => _apiProvider.clientDebt(year,month);
  Future<HttpResult> clientDetail(year, month, idT,tp) => _apiProvider.clientDetail(year, month, idT,tp);
  Future<HttpResult> deleteClientClass(name,id) => _apiProvider.deleteClientClass(name,id);
  Future<HttpResult> deleteClientType(name,id) => _apiProvider.deleteClientType(name,id);
  Future<HttpResult> getSklad(year,month,idSkl) => _apiProvider.getSklad(year,month,idSkl);
  Future<HttpResult> getSkladPer(year,month,idSkl) => _apiProvider.getSkladPer(year,month,idSkl);
  Future<HttpResult> resetSkladPer(body,year,month,idSkl) => _apiProvider.resetSkladPer(body,year,month,idSkl);
  Future<HttpResult> getSkladSkl2(year,month,idSkl) => _apiProvider.getSkladSkl2(year, month, idSkl);
  Future<HttpResult> resetSkladSkl2(body,year,month,idSkl) => _apiProvider.resetSkladSkl2(body, year, month, idSkl);
  Future<HttpResult> getWareHouse() => _apiProvider.getWareHouse();
  Future<HttpResult> addDocOutcome(item) => _apiProvider.addDocOutcome(item);
  Future<HttpResult> updateDocOutcome(item) => _apiProvider.updateDocOutcome(item);
  Future<HttpResult> deleteOutcomeDoc(id) => _apiProvider.deleteOutcomeDoc(id);
  Future<HttpResult> warehouseTransfer(Map data) => _apiProvider.warehouseTransfer(data);
  Future<HttpResult> warehouseTransferItem(Map data) => _apiProvider.warehouseTransferItem(data);
  Future<HttpResult> warehouseTransferItemDelete(id,idSklPer,idSkl2) => _apiProvider.warehouseTransferItemDelete(id,idSklPer,idSkl2);
  Future<HttpResult> warehouseTransferItemUpdate(Map data) => _apiProvider.warehouseTransferItemUpdate(data);
  Future<HttpResult> getWarehouseTransfer(year,month) => _apiProvider.getWarehouseTransfer(year,month);
  Future<HttpResult> lockWarehouse(year,month) => _apiProvider.lockWarehouse(year,month);
  Future<HttpResult> deleteWarehouseTransfer(id) => _apiProvider.deleteWarehouseTransfer(id);
  Future<HttpResult> getCurrency() => _apiProvider.getCurrency();
  Future<HttpResult> getBalance(date) => _apiProvider.getBalance(date);
  Future<HttpResult> getOldDebtClient(year,month) => _apiProvider.getOldDebtClient(year, month);
  Future<HttpResult> postNewDebtClient(year, month,data) => _apiProvider.postNewDebtClient(year, month,data);
  Future<HttpResult> getStaffPermission(id) => _apiProvider.getStaffPermission(id);
  Future<HttpResult> postStaffPermission(map,id) => _apiProvider.postStaffPermission(map,id);
  Future<HttpResult> postAgentPermission(map,id) => _apiProvider.postAgentPermission(map,id);
  Future<HttpResult> getAgentPermission(id) => _apiProvider.getAgentPermission(id);
  Future<HttpResult> postReturnedDoc(Map data) => _apiProvider.postReturnedDoc(data);
  Future<HttpResult> patchReturnedDoc(Map data) => _apiProvider.patchReturnedDoc(data);
  Future<HttpResult> getReturned(year,month,idSkl) => _apiProvider.getReturned(year, month, idSkl);
  Future<HttpResult> postReturned(Map data) => _apiProvider.postReturned(data);
  Future<HttpResult> patchReturned(Map data) => _apiProvider.patchReturned(data);
  Future<HttpResult> deleteReturned(idSklVz,idSkl2,id) => _apiProvider.deleteReturned(idSklVz,idSkl2,id);
  Future<HttpResult> deleteReturnedDoc(id) => _apiProvider.deleteReturnedDoc(id);
  Future<HttpResult> lockReturned(id,prov) => _apiProvider.lockReturned(id, prov);

}