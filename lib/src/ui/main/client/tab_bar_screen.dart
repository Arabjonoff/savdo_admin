import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/client/add_client_screen.dart';
import 'package:savdo_admin/src/ui/main/client/client_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>with SingleTickerProviderStateMixin {
  TabController? _controller;
  int clientType = 0;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Харидорлар"),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TabBar(
              labelColor: AppColors.green,
              indicatorColor: AppColors.green,
              controller: _controller,
              tabs: const [
                Tab(
                  text: "Харидорлар",
                ),
                Tab(
                  text: "Мол етказиб берувчи",
                ),
              ],
            )
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx){
              return const AddClientScreen();
            }));
          }, icon: const Icon(Icons.person_add_outlined,size: 32,))
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children:  const [
          ClientScreen(clientType: 0,),
          ClientScreen(clientType: 1,),
        ],
      ),
    );
  }
}
