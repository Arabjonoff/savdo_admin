import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/bloc/getDate/get_date_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_barcode.dart';
import 'package:savdo_admin/src/bloc/product/product_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_firma_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_quantity_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_type_bloc.dart';
import 'package:savdo_admin/src/bloc/sklad/warehouse_bloc.dart';
import 'package:savdo_admin/src/ui/main/home/home_screen.dart';
final priceFormat = NumberFormat('#,##0',"ru");
final priceFormatUsd = NumberFormat('#,##0.${"#" * 3}',"en");
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    productBloc.getAllProduct();
    getDateBloc.getDateId();
    barcodeProductBloc.getBarcodeAll();
    clientBloc.getAllClient('');
    wareHouseBloc.getAllWareHouse();
    clientBloc.getAllClientSearch('');
    productTypeBloc.getProductTypeAll();
    productFirmaTypeBloc.getFirmaBaseTypeAll();
    productQuantityTypeBloc.getQuantityBaseTypeAll();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: "Asosiy"),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart),label: "Monitoring"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Sozlamalr"),
        ],
      ),
    );
  }
}
