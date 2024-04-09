import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/statistics/plan_bloc/plan_bloc.dart';
import 'package:savdo_admin/src/model/statistics/plan_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/drawer_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
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
          StreamBuilder<PlanModel>(
            stream: planBloc.getPlanStream,
            builder: (context, snapshot) {
             if(snapshot.hasData){
               var data = snapshot.data!;
               return Container(
                 padding: EdgeInsets.symmetric(vertical: 4.h),
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
                 child: Row(
                   children: [
                     Expanded(
                       child: PieChart(
                         PieChartData(
                             sectionsSpace: 0.9,
                           sections: [
                             PieChartSectionData(
                               value: data.taskDone.toDouble(),
                               title: priceFormat.format(data.taskDone),
                               color: AppColors.green,
                               radius:30.r,
                               titleStyle: AppStyle.smallBold(Colors.white),
                               badgeWidget: Text("${priceFormat.format(data.f)}%",style: AppStyle.mediumBold(AppColors.black),),
                               badgePositionPercentageOffset: -1.3
                             ),
                             PieChartSectionData(
                               value: data.taskGo.toDouble(),
                               title: priceFormat.format(data.taskGo),
                               color: AppColors.red,
                               titleStyle: AppStyle.smallBold(Colors.white),
                               radius:30.r

                             ),
                             PieChartSectionData(
                               value: data.taskOut.toDouble(),
                               title: priceFormat.format(data.taskOut),
                               color: Colors.orange,
                               titleStyle: AppStyle.smallBold(Colors.white),
                               radius:30.r

                             ),
                           ]
                           // read about it in the PieChartData section
                         ),
                         swapAnimationDuration: const Duration(milliseconds: 250), // Optional
                         swapAnimationCurve: Curves.linear, // Optional
                       ),
                     ),
                     Expanded(
                       child: Column(
                         children: [
                       
                         ],
                       ),
                     )
                   ],
                 ),
               );
             }return SizedBox();
            }
          )
        ],
      ),
    );
  }
}

