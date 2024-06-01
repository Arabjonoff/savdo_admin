import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper{
  static final DatabaseHelper instance =  DatabaseHelper.internal();
  factory DatabaseHelper() => instance;
  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();

    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'n_savdo');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {

    /// Product Type Base
    await db.execute('''
          CREATE TABLE product_type (
            ID INTEGER,
            NAME TEXT,
            ST INTEGER
          )
          ''');

    /// Product Firma Base
    await db.execute('''
          CREATE TABLE product_firma (
            ID INTEGER,
            NAME TEXT,
            ST INTEGER
          )
          ''');

    /// Product Ediz Base
    await db.execute('''
          CREATE TABLE quantity_type (
            ID INTEGER,
            NAME TEXT,
            ST INTEGER
          )
          ''');

    /// Barcode  Base
    await db.execute('''
          CREATE TABLE barcode (
            ID INTEGER,
            NAME TEXT,
            SHTR TEXT,
            ID_SKL2 INTEGER,
            VAQT TEXT
          )
          ''');

    /// Product Base
    await db.execute('''
          CREATE TABLE product (
            ID INTEGER,
            NAME TEXT,
            ID_TIP INTEGER,
            ID_FIRMA INTEGER,
            ID_EDIZ INTEGER,
            PHOTO TEXT,
            VZ REAL,
            MSONI REAL,
            ST INTEGER,
            tipName TEXT,
            firmName TEXT,
            edizName TEXT
          )
          ''');

    /// Client Base
    await db.execute('''
          CREATE TABLE client (
            ID INTEGER,
            NAME TEXT,
            ID_T TEXT,
            IZOH TEXT,
            MANZIL TEXT,
            TEL TEXT,
            TP INTEGER,
            ID_NARH INTEGER,
            ID_FAOL INTEGER,
            ID_FAOL_NAME TEXT,
            ID_KLASS INTEGER,
            ID_KLASS_NAME TEXT,
            ID_AGENT INTEGER,
            SMS INTEGER,
            VAQT TEXT,
            ID_HODIMLAR INTEGER,
            NAQD INTEGER,
            PAS TEXT,
            D1 INTEGER,
            D2 INTEGER,
            D3 INTEGER,
            D4 INTEGER,
            H1 INTEGER,
            H2 INTEGER,
            H3 INTEGER,
            H4 INTEGER,
            H5 INTEGER,
            H6 INTEGER,
            H7 INTEGER,
            MULJAL TEXT,
            ST INTEGER
          )
          ''');

    /// Agents Base
    await db.execute('''
      CREATE TABLE agents (
        ID INTEGER PRIMARY KEY,
        NAME TEXT,
        FIO TEXT,
        TEL TEXT,
        TIP INTEGER,
        PAS TEXT,
        OKLAD INTEGER,
        OYLIK INTEGER,
        SKL INTEGER,
        ID_SKL INTEGER,
        ST INTEGER,
        SHTR TEXT,
        SMS INTEGER,
        VAQT TEXT
      )
    ''');

    /// Client Debt Base
    await db.execute('''
      CREATE TABLE client_debt (
        ID INTEGER,
        TP REAL,
        NAME TEXT,
        ID_TOCH TEXT,
        YIL TEXT,
        OY TEXT,
        KL_K REAL,
        KL_K_S REAL,
        PR REAL,
        PR_S REAL,
        ST REAL,
        ST_S REAL,
        KT REAL,
        KT_S REAL,
        TL_K REAL,
        TL_K_S REAL,
        TL_C REAL,
        TL_C_S REAL,
        SD REAL,
        SD_S REAL,
        OS_K REAL,
        OS_K_S REAL,
        STI REAL,
        ID_AGENT REAL,
        ID_FAOL REAL,
        DT_M TEXT,
        DT_T TEXT,
        MANZIL TEXT
      )
    ''');
    /// Client Active Type
    await db.execute('''
          CREATE TABLE clientType (
            ID INTEGER,
            NAME TEXT,
            ST INTEGER
          )
          ''');

    /// Client Klass Type
    await db.execute('''
          CREATE TABLE clientKlass (
            ID INTEGER,
            NAME TEXT,
            ST INTEGER
          )
          ''');

    /// Expense Type
    await db.execute('''
          CREATE TABLE expense (
            ID INTEGER,
            NAME TEXT,
            ST INTEGER
          )
          ''');

    /// Income Product
    await db.execute('''
      CREATE TABLE incomeProduct (
        ID INTEGER,
        ID_SKL_PR INTEGER,
        ID_SKL_PER INTEGER,
        ID_SKL2 INTEGER,
        NAME TEXT,
        ID_TIP INTEGER,
        ID_FIRMA INTEGER,
        ID_EDIZ INTEGER,
        SONI REAL,
        NARHI REAL,
        NARHI_S REAL,
        SM REAL,
        SM_S REAL,
        SNARHI REAL,
        SNARHI_S REAL,
        SNARHI1 REAL,
        SNARHI1_S REAL,
        SNARHI2 REAL,
        SNARHI2_S REAL,
        TNARHI REAL,
        TNARHI_S REAL,
        TSM REAL,
        TSM_S REAL,
        price REAL,
        SSM REAL,
        SSM_S REAL,
        SHTR TEXT
      )
    ''');


    /// Sklad
    await db.execute('''
      CREATE TABLE sklad (
        ID INTEGER,
        NAME TEXT,
        ID_SKL2 INTEGER,
        ID_TIP INTEGER,
        ID_FIRMA INTEGER,
        ID_EDIZ INTEGER,
        NARHI REAL,
        NARHI_S REAL,
        SNARHI REAL,
        SNARHI_S REAL,
        SNARHI1 REAL,
        SNARHI1_S REAL,
        SNARHI2 REAL,
        SNARHI2_S REAL,
        KSONI REAL,
        KSM REAL,
        KSM_S REAL,
        PSONI REAL,
        PSM REAL,
        PSM_S REAL,
        RSONI REAL,
        RSM REAL,
        RSM_S REAL,
        HSONI REAL,
        HSM REAL,
        HSM_S REAL,
        VSONI REAL,
        VSM REAL,
        VSM_S REAL,
        VZSONI REAL,
        VZSM REAL,
        VZSM_S REAL,
        PSKSONI REAL,
        PSKSM REAL,
        PSKSM_S REAL,
        RSKSONI REAL,
        RSKSM REAL,
        RSKSM_S REAL,
        OSONI REAL,
        OSM REAL,
        OSM_S REAL,
        OSM_T REAL,
        OSM_T_S REAL,
        KSM_T REAL,
        KSM_T_S REAL,
        YIL TEXT,
        OY TEXT,
        ID_SKL0 INTEGER,
        FOYDA REAL,
        FOYDA_S REAL,
        SONI REAL,
        VZ REAL,
        PHOTO TEXT
      )
    ''');

    /// Warehouse Sklad List
    await db.execute('''
          CREATE TABLE skladlist (
            ID INTEGER,
            NAME TEXT,
            ST INTEGER
          )
          ''');
    /// Outcome Product
    await db.execute('''
      CREATE TABLE outcomeProduct(
        ID INTEGER,
        ID_SKL_RS INTEGER,
        ID_SKL2 INTEGER,
        NAME TEXT,
        ID_TIP INTEGER,
        ID_FIRMA INTEGER,
        ID_EDIZ INTEGER,
        SONI REAL,
        NARHI REAL,
        NARHI_S REAL,
        SM REAL,
        SM_S REAL,
        SNARHI REAL,
        SNARHI_S REAL,
        SSM REAL,
        SSM_S REAL,
        FR_S REAL,
        FR REAL,
        ST REAL,
        SHTR TEXT,
        VZ TEXT
      )
    ''');
    /// Revision Product
    await db.execute('''
      CREATE TABLE revision(
        "ID" INTEGER,
        "NAME" TEXT,
        "ID_SKL2" INTEGER,
        "SONI" REAL,
        "N_SONI" REAL,
        "F_SONI" REAL,
        "NARHI" REAL,
        "NARHI_S" REAL,
        "SNARHI" REAL,
        "SNARHI_S" REAL,
        "SNARHI1" REAL,
        "SNARHI1_S" REAL,
        "SNARHI2" REAL,
        "SNARHI2_S" REAL
      )
    ''');
  }

  Future<void> deleteDatabase()async{
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'n_savdo');
    return databaseFactory.deleteDatabase(path);
  }
}