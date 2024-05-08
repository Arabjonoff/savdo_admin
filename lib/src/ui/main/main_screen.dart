import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/bloc/client/agent_permission.dart';
import 'package:savdo_admin/src/ui/main/home/home_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
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
    agentPermission.getAllPermission(CacheService.getIdAgent());
    super.initState();
  }
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text("Мониторинг")),
    const Center(child: Text("Созламалар")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i){
          currentIndex = i;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: "Асосий"),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart),label: "Мониторинг"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Созламалар"),
        ],
      ),
    );
  }
}
