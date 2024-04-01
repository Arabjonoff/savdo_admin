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
                  text: "Харидор қўшиш",
                ),
              ],
            )
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children:  [
          ClientScreen(clientType: clientType,),
          const AddClientScreen()
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.background,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w),
                child: Text("Ходимлар тури бўйича",style: AppStyle.medium(Colors.black),),
              ),
              ListTile(
                onTap: (){
                  clientType = 0;
                  setState(() {});
                },
                leading: const Icon(Icons.person),
                title: Text("Харидор",style: AppStyle.small(Colors.black),),
                trailing: Icon(Icons.radio_button_checked,color: clientType ==0?AppColors.green:Colors.grey,),
              ),
              ListTile(
                onTap: (){
                  clientType = 1;
                  setState(() {});
                },
                leading: const Icon(Icons.person),
                title: Text("Мол етказиб берувчи",style: AppStyle.small(Colors.black),),
                trailing: Icon(Icons.radio_button_checked,color: clientType ==1?AppColors.green:Colors.grey,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
