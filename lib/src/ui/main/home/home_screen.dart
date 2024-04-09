import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/statistics/plan_bloc/plan_bloc.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/drawer_screen.dart';
import 'package:savdo_admin/src/widget/internet/internet_check_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasInterNetConnection = false;
  void connectionChanged(dynamic hasConnection) {
  }
  @override
  void initState() {
    planBloc.getPlanAll();
    ConnectionUtil connectionStatus = ConnectionUtil.getInstance();
    connectionStatus.initialize();
    connectionStatus.connectionChange.listen(connectionChanged);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.green,
        title: const Text("N-Savdo "),
        // actions: [
        //   IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_active))
        // ],
      ),
      drawer: const DrawerScreen(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: width,
            height: 150.h,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)
              )
            ),
            child: Text("103 924 593 Сўм",style: AppStyle.extraLarge(Colors.white),),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
            width: width,
            height: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade400
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}

