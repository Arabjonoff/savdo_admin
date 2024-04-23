import 'package:shared_preferences/shared_preferences.dart';
class CacheService {
  static SharedPreferences? preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
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
  static void tip(int data) {
    preferences!.setInt("tip", data);
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
  static String getIdSkl() {
    String data = preferences!.getString("id_skl") ?? "";
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






  /// order save
  /// /// //// ///// ////////////////////
  static void saveClientComment(String data) {
    preferences!.setString("saveClientComment", data);
  }

  static void saveCurrency(int data) {
    preferences!.setInt("saveCurrency", data);
  }
  static int getCurrency() {
    int data = preferences!.getInt("saveCurrency") ?? 0;
    return data;
  }


}
