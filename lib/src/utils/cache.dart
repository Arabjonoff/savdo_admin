import 'package:shared_preferences/shared_preferences.dart';
class CacheService {
  static SharedPreferences? preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }


  static void saveNdoc(String data) {
    preferences!.setString("saveNdoc", data);
  }
  static String getNdoc() {
    String data = preferences!.getString("saveNdoc") ??'';
    return data;
  }

  static void saveExpenseSummaUzs(double data) {
    preferences!.setDouble("expenseSummaUzs", data);
  }
  static void saveExpenseSummaUsd(double data) {
    preferences!.setDouble("expenseSummaUsd", data);
  }

  /// Save Permissions
  static void saveidSkl(int data) {
    preferences!.setInt("idSkl", data);
  }
  static void savePermissionSkl(int data) {
    preferences!.setInt("skl", data);
  }
  static int getPermissionSkl() {
    int data = preferences!.getInt("skl") ??0;
    return data;
  }

  /// Get Permission
  static int getidSkl() {
    int data = preferences!.getInt("idSkl") ??1;
    return data;
  }

  static Future<bool> clear() async {
    return await preferences!.clear();
  }

  /// Token
  static void saveToken(String data) {
    preferences!.setString("token", data);
  }

  /// Save Password
  static void savePassword(String data) {
    preferences!.setString("password", data);
  }

  /// tip
  static void tip(String data) {
    preferences!.setString("tip", data);
  }

  /// Save DataBase
  static void saveDb(String data) {
    preferences!.setString("saveDB", data);
  }

  static void saveIdAgent(int data) {
    preferences!.setInt("idAgent", data);
  }
  static void saveIdHodim(int data) {
    preferences!.setInt("IdHodim", data);
  }
  static void saveClientIdT(String data) {
    preferences!.setString("ClientIdT", data);
  }
  static void saveClientName(String data) {
    preferences!.setString("ClientName", data);
  }

  static void saveName(String data) {
    preferences!.setString("saveName", data);
  }
  static void saveWareHouseName(String data) {
    preferences!.setString("saveWareHouseName", data);
  }
  static void saveWareHouseId(int data) {
    preferences!.setInt("saveWareHouseId", data);
  }


  static  saveDateId(int data) {
    preferences!.setInt("saveDateId", data);
  }





  static int getDateId() {
    int data = preferences!.getInt("saveDateId") ?? 0;
    return data;
  }
  static int getWareHouseId() {
    int data = preferences!.getInt("saveWareHouseId") ?? 0;
    return data;
  }
  static String getWareHouseName() {
    String data = preferences!.getString("saveWareHouseName") ?? '';
    return data;
  }
  static String getClientIdT() {
    String data = preferences!.getString("ClientIdT") ?? '0';
    return data;
  }
  static int getClientHodim() {
    int data = preferences!.getInt("IdHodim") ?? 0;
    return data;
  }
  static String getClientName() {
    String data = preferences!.getString("ClientName") ?? '0';
    return data;
  }

  static double getExpenseSummaUzs() {
    double data = preferences!.getDouble("expenseSummaUzs") ?? 0;
    return data;
  }

  static double getExpenseSummaUsd() {
    double data = preferences!.getDouble("expenseSummaUsd") ?? 0;
    return data;
  }
  static String getToken() {
    String data = preferences!.getString("token") ?? "";
    return data;
  }

  static String getPassword() {
    String data = preferences!.getString("password") ?? "";
    return data;
  }


  static String getTip() {
    String data = preferences!.getString("tip") ?? "";
    return data;
  }
  static int getIdAgent() {
    int data = preferences!.getInt("idAgent") ??0;
    return data;
  }
  static String getDb() {
    String data = preferences!.getString("saveDB") ?? '002';
    return data;
  }

  static String getName() {
    String data = preferences!.getString("saveName") ?? '';
    return data;
  }
  /// login
  static void saveLogin(String data) {
    preferences!.setString("user_login", data);
  }

  static String getLogin() {
    String data = preferences!.getString("user_login") ?? "";
    return data;
  }
  static int getFilterId() {
    int data = preferences!.getInt("filterId") ?? 0;
    return data;
  }

  static void saveCurrency(int data) {
    preferences!.setInt("saveCurrency", data);
  }
  static int getCurrency() {
    int data = preferences!.getInt("saveCurrency") ?? 0;
    return data;
  }






  /// Save Admin Permission Cache

  static void permissionProduct1(int data) {
    preferences!.setInt("product1", data);
  }
  static void permissionProduct2(int data) {
    preferences!.setInt("product2", data);
  }
  static void permissionProduct3(int data) {
    preferences!.setInt("product3", data);
  }
  static void permissionProduct4(int data) {
    preferences!.setInt("product4", data);
  }

  static void permissionWarehouseIncome1(int data) {
    preferences!.setInt("warehouse1", data);
  }
  static void permissionWarehouseIncome2(int data) {
    preferences!.setInt("warehouse2", data);
  }
  static void permissionWarehouseIncome3(int data) {
    preferences!.setInt("warehouse3", data);
  }
  static void permissionWarehouseIncome4(int data) {
    preferences!.setInt("warehouse4", data);
  }
  static void permissionWarehouseIncome5(int data) {
    preferences!.setInt("warehouse5", data);
  }

  static void permissionWarehouseOutcome1(int data) {
    preferences!.setInt("warehouseOutcome1", data);
  }
  static void permissionWarehouseOutcome2(int data) {
    preferences!.setInt("warehouseOutcome2", data);
  }
  static void permissionWarehouseOutcome3(int data) {
    preferences!.setInt("warehouseOutcome3", data);
  }
  static void permissionWarehouseOutcome4(int data) {
    preferences!.setInt("warehouseOutcome4", data);
  }
  static void permissionWarehouseOutcome5(int data) {
    preferences!.setInt("warehouseOutcome5", data);
  }

  static void permissionWarehouseExpense1(int data) {
    preferences!.setInt("warehouseExpense1", data);
  }
  static void permissionWarehouseExpense2(int data) {
    preferences!.setInt("warehouseExpense2", data);
  }
  static void permissionWarehouseExpense3(int data) {
    preferences!.setInt("warehouseExpense3", data);
  }
  static void permissionWarehouseExpense4(int data) {
    preferences!.setInt("warehouseExpense4", data);
  }
  static void permissionWarehouseExpense5(int data) {
    preferences!.setInt("warehouseExpense5", data);
  }

  static void permissionMainWarehouse1(int data) {
    preferences!.setInt("mainWarehouse1", data);
  }
  static void permissionMainWarehouse2(int data) {
    preferences!.setInt("mainWarehouse2", data);
  }
  static void permissionMainWarehouse3(int data) {
    preferences!.setInt("mainWarehouse3", data);
  }
  static void permissionMainWarehouse4(int data) {
    preferences!.setInt("mainWarehouse4", data);
  }
  static void permissionMainWarehouse5(int data) {
    preferences!.setInt("mainWarehouse5", data);
  }

  static void permissionClientList1(int data) {
    preferences!.setInt("client1", data);
  }
  static void permissionClientList2(int data) {
    preferences!.setInt("client2", data);
  }
  static void permissionClientList3(int data) {
    preferences!.setInt("client3", data);
  }
  static void permissionClientList4(int data) {
    preferences!.setInt("client4", data);
  }

  static void permissionCourierList1(int data) {
    preferences!.setInt("courier1", data);
  }
  static void permissionCourierList2(int data) {
    preferences!.setInt("courier2", data);
  }
  static void permissionCourierList3(int data) {
    preferences!.setInt("courier3", data);
  }
  static void permissionCourierList4(int data) {
    preferences!.setInt("courier4", data);
  }

  static void permissionClientDebt1(int data) {
    preferences!.setInt("clientDebt1", data);
  }
  static void permissionClientDebt2(int data) {
    preferences!.setInt("clientDebt2", data);
  }
  static void permissionClientDebt3(int data) {
    preferences!.setInt("clientDebt3", data);
  }
  static void permissionClientDebt4(int data) {
    preferences!.setInt("clientDebt4", data);
  }

  static void permissionCourierDebt1(int data) {
    preferences!.setInt("courierDebt1", data);
  }
  static void permissionCourierDebt2(int data) {
    preferences!.setInt("courierDebt2", data);
  }
  static void permissionCourierDebt3(int data) {
    preferences!.setInt("courierDebt3", data);
  }
  static void permissionCourierDebt4(int data) {
    preferences!.setInt("courierDebt4", data);
  }

  static void permissionPaymentIncome1(int data) {
    preferences!.setInt("paymentIncome1", data);
  }
  static void permissionPaymentIncome2(int data) {
    preferences!.setInt("paymentIncome2", data);
  }
  static void permissionPaymentIncome3(int data) {
    preferences!.setInt("paymentIncome3", data);
  }
  static void permissionPaymentIncome4(int data) {
    preferences!.setInt("paymentIncome4", data);
  }

  static void permissionPaymentOutcome1(int data) {
    preferences!.setInt("paymentOutcome1", data);
  }
  static void permissionPaymentOutcome2(int data) {
    preferences!.setInt("paymentOutcome2", data);
  }
  static void permissionPaymentOutcome3(int data) {
    preferences!.setInt("paymentOutcome3", data);
  }
  static void permissionPaymentOutcome4(int data) {
    preferences!.setInt("paymentOutcome4", data);
  }

  static void permissionPaymentExpense1(int data) {
    preferences!.setInt("paymentExpense1", data);
  }
  static void permissionPaymentExpense2(int data) {
    preferences!.setInt("paymentExpense2", data);
  }
  static void permissionPaymentExpense3(int data) {
    preferences!.setInt("paymentExpense3", data);
  }
  static void permissionPaymentExpense4(int data) {
    preferences!.setInt("paymentExpense4", data);
  }

  static void permissionMonth1(int data) {
    preferences!.setInt("month1", data);
  }
  static void permissionMonth2(int data) {
    preferences!.setInt("month2", data);
  }
  static void permissionMonth3(int data) {
    preferences!.setInt("month3", data);
  }
  static void permissionMonth4(int data) {
    preferences!.setInt("month4", data);
  }

  static void permissionUserWindow1(int data) {
    preferences!.setInt("userWindow1", data);
  }
  static void permissionUserWindow2(int data) {
    preferences!.setInt("userWindow2", data);
  }
  static void permissionUserWindow3(int data) {
    preferences!.setInt("userWindow3", data);
  }
  static void permissionUserWindow4(int data) {
    preferences!.setInt("userWindow4", data);
  }

  static void permissionBalanceWindow1(int data) {
    preferences!.setInt("balanceWindow1", data);
  }
  static void permissionBalanceWindow2(int data) {
    preferences!.setInt("balanceWindow2", data);
  }
  static void permissionBalanceWindow3(int data) {
    preferences!.setInt("balanceWindow3", data);
  }
  static void permissionBalanceWindow4(int data) {
    preferences!.setInt("balanceWindow4", data);
  }
  static void permissionBalanceWindow5(int data) {
    preferences!.setInt("balanceWindow5", data);
  }

  static void permissionProductInfo1(int data) {
    preferences!.setInt("productInfo1", data);
  }
  static void permissionProductInfo2(int data) {
    preferences!.setInt("productInfo2", data);
  }
  static void permissionProductInfo3(int data) {
    preferences!.setInt("productInfo3", data);
  }
  static void permissionProductInfo4(int data) {
    preferences!.setInt("productInfo4", data);
  }

  static void permissionAmountNumber1(int data) {
    preferences!.setInt("amount1", data);
  }
  static void permissionAmountNumber2(int data) {
    preferences!.setInt("amount2", data);
  }
  static void permissionAmountNumber3(int data) {
    preferences!.setInt("amount3", data);
  }
  static void permissionAmountNumber4(int data) {
    preferences!.setInt("amount4", data);
  }

  static void permissionHistoryAction1(int data) {
    preferences!.setInt("historyAction1", data);
  }
  static void permissionHistoryAction2(int data) {
    preferences!.setInt("historyAction2", data);
  }
  static void permissionHistoryAction3(int data) {
    preferences!.setInt("historyAction3", data);
  }
  static void permissionHistoryAction4(int data) {
    preferences!.setInt("historyAction4", data);
  }

  static void permissionRemoteCashier1(int data) {
    preferences!.setInt("remoteCash1", data);
  }
  static void permissionRemoteCashier2(int data) {
    preferences!.setInt("remoteCash2", data);
  }
  static void permissionRemoteCashier3(int data) {
    preferences!.setInt("remoteCash3", data);
  }
  static void permissionRemoteCashier4(int data) {
    preferences!.setInt("remoteCash4", data);
  }

  static void permissionWarehouseReturn1(int data) {
    preferences!.setInt("warehouseReturn1", data);
  }
  static void permissionWarehouseReturn2(int data) {
    preferences!.setInt("warehouseReturn2", data);
  }
  static void permissionWarehouseReturn3(int data) {
    preferences!.setInt("warehouseReturn3", data);
  }
  static void permissionWarehouseReturn4(int data) {
    preferences!.setInt("warehouseReturn4", data);
  }
  static void permissionWarehouseReturn5(int data) {
    preferences!.setInt("warehouseReturn5", data);
  }

  static void permissionWarehouseAction1(int data) {
    preferences!.setInt("warehouseAction1", data);
  }
  static void permissionWarehouseAction2(int data) {
    preferences!.setInt("warehouseAction2", data);
  }
  static void permissionWarehouseAction3(int data) {
    preferences!.setInt("warehouseAction3", data);
  }
  static void permissionWarehouseAction4(int data) {
    preferences!.setInt("warehouseAction4", data);
  }

  static void permissionCurrency1(int data) {
    preferences!.setInt("currency1", data);
  }
  static void permissionCurrency2(int data) {
    preferences!.setInt("currency2", data);
  }
  static void permissionCurrency3(int data) {
    preferences!.setInt("currency3", data);
  }
  static void permissionCurrency4(int data) {
    preferences!.setInt("currency4", data);
  }

  static void permissionBooking1(int data) {
    preferences!.setInt("booking1", data);
  }
  static void permissionBooking2(int data) {
    preferences!.setInt("booking2", data);
  }
  static void permissionBooking3(int data) {
    preferences!.setInt("booking3", data);
  }
  static void permissionBooking4(int data) {
    preferences!.setInt("booking4", data);
  }



  /// Get Admin Permission Cache

  static int getPermissionProduct1() {
    return preferences!.getInt("product1") ?? 0;
  }
  static int getPermissionProduct2() {
    return preferences!.getInt("product2") ?? 0;
  }
  static int getPermissionProduct3() {
    return preferences!.getInt("product3") ?? 0;
  }
  static int getPermissionProduct4() {
    return preferences!.getInt("product4") ?? 0;
  }

  static int getPermissionWarehouseIncome1() {
    return preferences!.getInt("warehouse1") ?? 0;
  }
  static int getPermissionWarehouseIncome2() {
    return preferences!.getInt("warehouse2") ?? 0;
  }
  static int getPermissionWarehouseIncome3() {
    return preferences!.getInt("warehouse3") ?? 0;
  }
  static int getPermissionWarehouseIncome4() {
    return preferences!.getInt("warehouse4") ?? 0;
  }
  static int getPermissionWarehouseIncome5() {
    return preferences!.getInt("warehouse5") ?? 0;
  }

  static int getPermissionWarehouseOutcome1() {
    return preferences!.getInt("warehouseOutcome1") ?? 0;
  }
  static int getPermissionWarehouseOutcome2() {
    return preferences!.getInt("warehouseOutcome2") ?? 0;
  }
  static int getPermissionWarehouseOutcome3() {
    return preferences!.getInt("warehouseOutcome3") ?? 0;
  }
  static int getPermissionWarehouseOutcome4() {
    return preferences!.getInt("warehouseOutcome4") ?? 0;
  }
  static int getPermissionWarehouseOutcome5() {
    return preferences!.getInt("warehouseOutcome5") ?? 0;
  }

  static int getPermissionWarehouseExpense1() {
    return preferences!.getInt("warehouseExpense1") ?? 0;
  }
  static int getPermissionWarehouseExpense2() {
    return preferences!.getInt("warehouseExpense2") ?? 0;
  }
  static int getPermissionWarehouseExpense3() {
    return preferences!.getInt("warehouseExpense3") ?? 0;
  }
  static int getPermissionWarehouseExpense4() {
    return preferences!.getInt("warehouseExpense4") ?? 0;
  }
  static int getPermissionWarehouseExpense5() {
    return preferences!.getInt("warehouseExpense5") ?? 0;
  }

  static int getPermissionMainWarehouse1() {
    return preferences!.getInt("mainWarehouse1") ?? 0;
  }
  static int getPermissionMainWarehouse2() {
    return preferences!.getInt("mainWarehouse2") ?? 0;
  }
  static int getPermissionMainWarehouse3() {
    return preferences!.getInt("mainWarehouse3") ?? 0;
  }
  static int getPermissionMainWarehouse4() {
    return preferences!.getInt("mainWarehouse4") ?? 0;
  }
  static int getPermissionMainWarehouse5() {
    return preferences!.getInt("mainWarehouse5") ?? 0;
  }

  static int getPermissionClientList1() {
    return preferences!.getInt("client1") ?? 0;
  }
  static int getPermissionClientList2() {
    return preferences!.getInt("client2") ?? 0;
  }
  static int getPermissionClientList3() {
    return preferences!.getInt("client3") ?? 0;
  }
  static int getPermissionClientList4() {
    return preferences!.getInt("client4") ?? 0;
  }

  static int getPermissionCourierList1() {
    return preferences!.getInt("courier1") ?? 0;
  }
  static int getPermissionCourierList2() {
    return preferences!.getInt("courier2") ?? 0;
  }
  static int getPermissionCourierList3() {
    return preferences!.getInt("courier3") ?? 0;
  }
  static int getPermissionCourierList4() {
    return preferences!.getInt("courier4") ?? 0;
  }

  static int getPermissionClientDebt1() {
    return preferences!.getInt("clientDebt1") ?? 0;
  }
  static int getPermissionClientDebt2() {
    return preferences!.getInt("clientDebt2") ?? 0;
  }
  static int getPermissionClientDebt3() {
    return preferences!.getInt("clientDebt3") ?? 0;
  }
  static int getPermissionClientDebt4() {
    return preferences!.getInt("clientDebt4") ?? 0;
  }

  static int getPermissionCourierDebt1() {
    return preferences!.getInt("courierDebt1") ?? 0;
  }
  static int getPermissionCourierDebt2() {
    return preferences!.getInt("courierDebt2") ?? 0;
  }
  static int getPermissionCourierDebt3() {
    return preferences!.getInt("courierDebt3") ?? 0;
  }
  static int getPermissionCourierDebt4() {
    return preferences!.getInt("courierDebt4") ?? 0;
  }

  static int getPermissionPaymentIncome1() {
    return preferences!.getInt("paymentIncome1") ?? 0;
  }
  static int getPermissionPaymentIncome2() {
    return preferences!.getInt("paymentIncome2") ?? 0;
  }
  static int getPermissionPaymentIncome3() {
    return preferences!.getInt("paymentIncome3") ?? 0;
  }
  static int getPermissionPaymentIncome4() {
    return preferences!.getInt("paymentIncome4") ?? 0;
  }

  static int getPermissionPaymentOutcome1() {
    return preferences!.getInt("paymentOutcome1") ?? 0;
  }
  static int getPermissionPaymentOutcome2() {
    return preferences!.getInt("paymentOutcome2") ?? 0;
  }
  static int getPermissionPaymentOutcome3() {
    return preferences!.getInt("paymentOutcome3") ?? 0;
  }
  static int getPermissionPaymentOutcome4() {
    return preferences!.getInt("paymentOutcome4") ?? 0;
  }

  static int getPermissionPaymentExpense1() {
    return preferences!.getInt("paymentExpense1") ?? 0;
  }
  static int getPermissionPaymentExpense2() {
    return preferences!.getInt("paymentExpense2") ?? 0;
  }
  static int getPermissionPaymentExpense3() {
    return preferences!.getInt("paymentExpense3") ?? 0;
  }
  static int getPermissionPaymentExpense4() {
    return preferences!.getInt("paymentExpense4") ?? 0;
  }

  static int getPermissionMonth1() {
    return preferences!.getInt("month1") ?? 0;
  }
  static int getPermissionMonth2() {
    return preferences!.getInt("month2") ?? 0;
  }
  static int getPermissionMonth3() {
    return preferences!.getInt("month3") ?? 0;
  }
  static int getPermissionMonth4() {
    return preferences!.getInt("month4") ?? 0;
  }

  static int getPermissionUserWindow1() {
    return preferences!.getInt("userWindow1") ?? 0;
  }
  static int getPermissionUserWindow2() {
    return preferences!.getInt("userWindow2") ?? 0;
  }
  static int getPermissionUserWindow3() {
    return preferences!.getInt("userWindow3") ?? 0;
  }
  static int getPermissionUserWindow4() {
    return preferences!.getInt("userWindow4") ?? 0;
  }

  static int getPermissionBalanceWindow1() {
    return preferences!.getInt("balanceWindow1") ?? 0;
  }
  static int getPermissionBalanceWindow2() {
    return preferences!.getInt("balanceWindow2") ?? 0;
  }
  static int getPermissionBalanceWindow3() {
    return preferences!.getInt("balanceWindow3") ?? 0;
  }
  static int getPermissionBalanceWindow4() {
    return preferences!.getInt("balanceWindow4") ?? 0;
  }

  static int getPermissionProductInfo1() {
    return preferences!.getInt("productInfo1") ?? 0;
  }
  static int getPermissionProductInfo2() {
    return preferences!.getInt("productInfo2") ?? 0;
  }
  static int getPermissionProductInfo3() {
    return preferences!.getInt("productInfo3") ?? 0;
  }
  static int getPermissionProductInfo4() {
    return preferences!.getInt("productInfo4") ?? 0;
  }

  static int getPermissionAmountNumber1() {
    return preferences!.getInt("amount1") ?? 0;
  }
  static int getPermissionAmountNumber2() {
    return preferences!.getInt("amount2") ?? 0;
  }
  static int getPermissionAmountNumber3() {
    return preferences!.getInt("amount3") ?? 0;
  }
  static int getPermissionAmountNumber4() {
    return preferences!.getInt("amount4") ?? 0;
  }

  static int getPermissionHistoryAction1() {
    return preferences!.getInt("historyAction1") ?? 0;
  }
  static int getPermissionHistoryAction2() {
    return preferences!.getInt("historyAction2") ?? 0;
  }
  static int getPermissionHistoryAction3() {
    return preferences!.getInt("historyAction3") ?? 0;
  }
  static int getPermissionHistoryAction4() {
    return preferences!.getInt("historyAction4") ?? 0;
  }

  static int getPermissionRemoteCashier1() {
    return preferences!.getInt("remoteCash1") ?? 0;
  }
  static int getPermissionRemoteCashier2() {
    return preferences!.getInt("remoteCash2") ?? 0;
  }
  static int getPermissionRemoteCashier3() {
    return preferences!.getInt("remoteCash3") ?? 0;
  }
  static int getPermissionRemoteCashier4() {
    return preferences!.getInt("remoteCash4") ?? 0;
  }

  static int getPermissionWarehouseReturn1() {
    return preferences!.getInt("warehouseReturn1") ?? 0;
  }
  static int getPermissionWarehouseReturn2() {
    return preferences!.getInt("warehouseReturn2") ?? 0;
  }
  static int getPermissionWarehouseReturn3() {
    return preferences!.getInt("warehouseReturn3") ?? 0;
  }
  static int getPermissionWarehouseReturn4() {
    return preferences!.getInt("warehouseReturn4") ?? 0;
  }
  static int getPermissionWarehouseReturn5() {
    return preferences!.getInt("warehouseReturn5") ?? 0;
  }

  static int getPermissionWarehouseAction1() {
    return preferences!.getInt("warehouseAction1") ?? 0;
  }
  static int getPermissionWarehouseAction2() {
    return preferences!.getInt("warehouseAction2") ?? 0;
  }
  static int getPermissionWarehouseAction3() {
    return preferences!.getInt("warehouseAction3") ?? 0;
  }
  static int getPermissionWarehouseAction4() {
    return preferences!.getInt("warehouseAction4") ?? 0;
  }

  static int getPermissionCurrency1() {
    return preferences!.getInt("currency1") ?? 0;
  }
  static int getPermissionCurrency2() {
    return preferences!.getInt("currency2") ?? 0;
  }
  static int getPermissionCurrency3() {
    return preferences!.getInt("currency3") ?? 0;
  }
  static int getPermissionCurrency4() {
    return preferences!.getInt("currency4") ?? 0;
  }

  static int getPermissionBooking1() {
    return preferences!.getInt("booking1") ?? 0;
  }
  static int getPermissionBooking2() {
    return preferences!.getInt("booking2") ?? 0;
  }
  static int getPermissionBooking3() {
    return preferences!.getInt("booking3") ?? 0;
  }
  static int getPermissionBooking4() {
    return preferences!.getInt("booking4") ?? 0;
  }
}
