import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/statistics/plan_bloc/plan_bloc.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
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
        title: const Text("N-Savdo "),
        // actions: [
        //   IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_active))
        // ],
      ),
      drawer: const DrawerScreen(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            height: 150.h,
            width: width,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5
                )
              ],
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15.r)
            ),
            child: Row(
              children: [
                Expanded(child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 10,
                        showTitle: true,
                        gradient: LinearGradient(colors: [Colors.grey,Colors.red,Colors.black]),
                        radius: 20,
                        titlePositionPercentageOffset: -2.2.h
                      ),
                    ],
                    // read about it in the PieChartData section
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

