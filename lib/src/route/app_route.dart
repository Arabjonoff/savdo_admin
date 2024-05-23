import 'package:flutter/material.dart';
import 'package:savdo_admin/src/ui/drawer/client/add_client_screen.dart';
import 'package:savdo_admin/src/ui/drawer/client/debtbook/debtbook_screen.dart';
import 'package:savdo_admin/src/ui/drawer/income/documnet_income_screen.dart';
import 'package:savdo_admin/src/ui/drawer/income/expense/income_expense_screen.dart';
import 'package:savdo_admin/src/ui/drawer/income/income_list_screen.dart';
import 'package:savdo_admin/src/ui/drawer/income/income_screen.dart';
import 'package:savdo_admin/src/ui/drawer/outcome/cart/cart_outcome.dart';
import 'package:savdo_admin/src/ui/drawer/outcome/document_outcome_screen.dart';
import 'package:savdo_admin/src/ui/drawer/outcome/outcome_screen.dart';
import 'package:savdo_admin/src/ui/drawer/payment/cost_pay/add_cost_screen.dart';
import 'package:savdo_admin/src/ui/drawer/payment/cost_pay/cost_list_screen.dart';
import 'package:savdo_admin/src/ui/drawer/payment/income_pay/add_inocme_apy.dart';
import 'package:savdo_admin/src/ui/drawer/payment/income_pay/income_pay_screen.dart';
import 'package:savdo_admin/src/ui/drawer/payment/income_pay/income_tabbar.dart';
import 'package:savdo_admin/src/ui/drawer/payment/outcome_pay/add_outcome_pay.dart';
import 'package:savdo_admin/src/ui/drawer/payment/outcome_pay/outcome_pay_screen.dart';
import 'package:savdo_admin/src/ui/drawer/product/add_product.dart';
import 'package:savdo_admin/src/ui/drawer/product/product_screen.dart';
import 'package:savdo_admin/src/ui/drawer/warehouse/warehouse_screen.dart';
import 'package:savdo_admin/src/ui/drawer/warehouse/warehouse_transfer/warehouser_transfer_screen.dart';
import 'package:savdo_admin/src/ui/login/login_screen.dart';
import 'package:savdo_admin/src/ui/main/home/home_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/ui/notification/message.dart';
import 'package:savdo_admin/src/ui/spalsh/spalsh_screen.dart';

abstract class AppRouteName {
  static const main = 'main';
  static const splash = '/splash';
  static const login = '/login';
  static const home = 'home';
  static const product = '/product';
  static const addProduct = '/addProduct';
  static const income = '/income';
  static const outcome = '/outcome';
  static const addOutcome = '/addOutcome';
  static const addIncome = '/addIncome';
  static const addDocumentIncome = '/addDocumentIncome';
  static const addDocumentOutcome = '/addDocumentOutcome';
  static const incomeExpenseScreen = '/incomeExpenseScreen';
  static const addClient = '/addClient';
  static const client = '/client';
  static const updateClient = '/updateClient';
  static const debtBook = '/debtBook';
  static const wearHouse = '/wearHouse';
  static const wearHouseTransfer = '/wearHouseTransfer';
  static const costList = '/costList';
  static const addCost = '/addCost';
  static const incomePay = '/incomePay';
  static const updateIncomePay = '/updateIncomePay';
  static const addIncomePay = '/addIncomePay';
  static const addOutComePay = '/addOutComePay';
  static const outComePay = '/outComePay';
  static const incomeTabBar = '/incomeTabBar';
  static const message = '/message';
}
class AppRoute{
  static Route routes(RouteSettings settings){
    var args = settings.arguments;
    switch (settings.name){
    /// Splash Screen
      case AppRouteName.splash: return MaterialPageRoute(builder: (BuildContext context) =>  const SplashScreen());
    /// Login Screen
      case AppRouteName.login: return MaterialPageRoute(builder: (BuildContext context) =>  const LoginScreen());
    /// Splash Screen
      case AppRouteName.main: return MaterialPageRoute(builder: (BuildContext context) =>  const MainScreen());
    /// Splash Screen
      case AppRouteName.home: return MaterialPageRoute(builder: (BuildContext context) =>  const HomeScreen());
    /// Product Screen
      case AppRouteName.product: return MaterialPageRoute(builder: (BuildContext context) =>  const ProductScreen());
    /// Add Product Screen
      case AppRouteName.addProduct: return MaterialPageRoute(builder: (BuildContext context) =>  const AddProductScreen());
    /// Income Screen
      case AppRouteName.income: return MaterialPageRoute(builder: (BuildContext context) =>  const IncomeScreen());
    /// Income Screen
      case AppRouteName.addIncome: return MaterialPageRoute(builder: (BuildContext context) =>   IncomeListScreen(id: args,));
    /// Income Screen
      case AppRouteName.addDocumentIncome: return MaterialPageRoute(builder: (BuildContext context) =>   DocumentIncomeScreen(ndoc: args, map: const {},));
    /// Income Screen
      case AppRouteName.incomeExpenseScreen: return MaterialPageRoute(builder: (BuildContext context) =>   IncomeExpenseScreen(idSklPr: args as int,));
    /// Add Client Screen
      case AppRouteName.addClient: return MaterialPageRoute(builder: (BuildContext context) => const AddClientScreen());
    /// Add Client Screen
      case AppRouteName.debtBook: return MaterialPageRoute(builder: (BuildContext context) => const DebtBookScreen());
    /// WearHouse Screen
      case AppRouteName.wearHouse: return MaterialPageRoute(builder: (BuildContext context) => const WareHouseScreen());
    /// WearHouse Screen
      case AppRouteName.wearHouseTransfer: return MaterialPageRoute(builder: (BuildContext context) => const WareHouseTransferScreen());
    /// Outcome Screen
      case AppRouteName.outcome: return MaterialPageRoute(builder: (BuildContext context) => const OutcomeScreen());
    /// Add Outcome Screen
      case AppRouteName.addOutcome: return MaterialPageRoute(builder: (BuildContext context) => const CartOutcomeScreen());
    /// Add Document Outcome Screen
      case AppRouteName.addDocumentOutcome: return MaterialPageRoute(builder: (BuildContext context) =>  DocumentOutComeScreen(ndoc: args, map: const {},));
    /// Cost List Screen
      case AppRouteName.costList: return MaterialPageRoute(builder: (BuildContext context) => const CostListScreen());
    /// Add Cost Screen
      case AppRouteName.addCost: return MaterialPageRoute(builder: (BuildContext context) => const AddCostScreen());
    /// Income Pay Screen
      case AppRouteName.incomePay: return MaterialPageRoute(builder: (BuildContext context) => const IncomePayScreen());
    /// Outcome Pay Screen
      case AppRouteName.outComePay: return MaterialPageRoute(builder: (BuildContext context) =>  const OutcomePayScreen(idAgent: 0,));
    /// Add Outcome Pay Screen
      case AppRouteName.addOutComePay: return MaterialPageRoute(builder: (BuildContext context) => const AddOutcomePayScreen());
    /// Add Income Pay Screen
      case AppRouteName.addIncomePay: return MaterialPageRoute(builder: (BuildContext context) => const AddIncomePayScreen());
    /// Income TabBar Screen
      case AppRouteName.incomeTabBar: return MaterialPageRoute(builder: (BuildContext context) => const IncomeTabBarScreen());
    /// Message Screen
      case AppRouteName.message: return MaterialPageRoute(builder: (BuildContext context) => const MessageScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}