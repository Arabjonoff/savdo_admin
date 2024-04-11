import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/statistics/plan_bloc/plan_bloc.dart';
import 'package:savdo_admin/src/model/statistics/plan_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  void initState() {
    planBloc.getPlanAgentAll();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<AgentModel>(
        stream: planBloc.getAgentStream,
        builder: (context, snapshot) {
         if(snapshot.hasData){
           var data = snapshot.data!;
           return ListView.builder(
             itemCount: 12,
               itemBuilder: (ctx,index){
             return Container(
               margin: EdgeInsets.symmetric(vertical: 8.h),
               height: 50.r,
               width: width,
               child: Row(
                 children: [
                   SizedBox(width: 16.w,),
                   Expanded(child: Text(data.agents.doneAgent.toString(),style: AppStyle.mediumBold(Colors.black),)),
                   const Spacer(),
                   Expanded(
                     child: PieChart(
                       PieChartData(
                           sectionsSpace: 0.9,
                           sections: [
                             PieChartSectionData(
                                 title: '',
                                 value: 44,
                                 color: AppColors.red,
                                 titleStyle: AppStyle.smallBold(Colors.white),
                                 radius:10.r

                             ),
                             PieChartSectionData(
                                 value: 101,
                                 title: '',
                                 color: AppColors.green,
                                 titleStyle: AppStyle.smallBold(Colors.white),
                                 radius:10.r

                             ),
                           ]
                         // read about it in the PieChartData section
                       ),
                       swapAnimationDuration: const Duration(milliseconds: 250), // Optional
                       swapAnimationCurve: Curves.linear, // Optional
                     ),
                   ),
                 ],
               ),
             );
           });
         }
         return SizedBox();
        }
      )
    );
  }
}
