import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/bloc/statistics/balance/balance_bloc.dart';
import 'package:savdo_admin/src/bloc/statistics/plan_bloc/plan_bloc.dart';
import 'package:savdo_admin/src/dialog/bottom_dialog.dart';
import 'package:savdo_admin/src/model/balance/balance_model.dart';
import 'package:savdo_admin/src/model/statistics/plan_model.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/drawer_screen.dart';
import 'package:savdo_admin/src/ui/main/home/balance/balance_screen.dart';
import 'package:savdo_admin/src/ui/main/home/plan_screen/plan_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/internet/internet_check_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool balance = false;
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  void connectionChanged(dynamic hasConnection) {
  }
  @override
  void initState() {
    balanceBloc.getAllBalance(DateFormat('yyyy-MM-dd').format(DateTime.now()));
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
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      // appBar: AppBar(
      //   elevation: 0,
      //   foregroundColor: Colors.white,
      //   backgroundColor: AppColors.green,
      //   title:  Text("N-Savdo"),
      //   actions: [
      //     IconButton(onPressed: (){
      //       Navigator.pushNamed(context, AppRouteName.message);
      //     }, icon: const Icon(Icons.notifications_active))
      //   ],
      // ),
      drawer: const DrawerScreen(),
      body: RefreshIndicator(
        onRefresh: ()async{
          await balanceBloc.getAllBalance(DateFormat('yyyy-MM-dd').format(DateTime.now()));
          await planBloc.getPlanAll();
          await planBloc.getPlanAgentAll();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                StreamBuilder<BalanceModel>(
                    stream: balanceBloc.getBalanceStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        var data = snapshot.data!;
                        return Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          width: width,
                          height: 250.h,
                          decoration:  BoxDecoration(
                            color: AppColors.green,
                              image:  const DecorationImage(
                                image:  ExactAssetImage('assets/images/bg000.jpg'),
                                fit: BoxFit.cover,
                              ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:EdgeInsets.only(left: 12.0.spMax),
                                    child: GestureDetector(
                                      onTap: ()=>_scaffoldKey.currentState!.openDrawer(),
                                        child: CircleAvatar(
                                          child: Text(CacheService.getName()[0].toUpperCase()),
                                        )),
                                  ),
                                  IconButton(onPressed: ()async{
                                  Navigator.pushNamed(context, AppRouteName.message);
                                  }, icon: const Icon(Icons.notifications_active,color: Colors.white,))
                                ],
                              ),
                              SizedBox(height: 40.spMax,),
                              Padding(
                                padding: EdgeInsets.only(left: 12.0.w),
                                child: Text("Баланс",style: AppStyle.mediumBold(Colors.white),),
                              ),
                              ListTile(
                                title: balance?Text("${priceFormatUsd.format(data.balanceUsd)} \$",style: AppStyle.large(Colors.white),):Text("${priceFormat.format(data.balance)} Сўм",style: AppStyle.large(Colors.white),),
                                onTap: (){
                                  BottomDialog.showScreenDialog(context, BalanceScreen(data: data,));
                                },
                                trailing: IconButton(onPressed: (){
                                  setState(() {
                                    balance = !balance;
                                  });
                                },icon: const Icon(Icons.repeat,color: Colors.white,),),
                              )
                            ],
                          ),
                        );
                      } return Container(
                        color: AppColors.green,
                      );
                    }
                ),
                Padding(
                  padding: EdgeInsets.only(top: 210.spMax),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<PlanModel>(
                          stream: planBloc.getPlanStream,
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              var data = snapshot.data!;
                              var d = data.taskGo.toDouble()-data.taskDone.toDouble();
                              if(d<0){
                                d=0;
                              }
                              return GestureDetector(
                                onTap: (){
                                  BottomDialog.showScreenDialog(context, const PlanScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                                  width: width,
                                  height: 150.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.grey.shade400
                                        ),
                                      ]
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                              sectionsSpace: 1.2,
                                              sections: [
                                                PieChartSectionData(
                                                  value: data.taskDone.toDouble(),
                                                  title: priceFormat.format(data.taskDone),
                                                  color: AppColors.green,
                                                  radius:25.r,
                                                  titleStyle: AppStyle.smallBold(Colors.white),
                                                  badgeWidget: Text("${priceFormat.format(data.f)}%",style: AppStyle.mediumBold(AppColors.black),),
                                                  badgePositionPercentageOffset: -1.8.w,
                                                ),
                                                PieChartSectionData(
                                                    value: d,
                                                    title: priceFormat.format(data.taskGo.toDouble()-data.taskDone.toDouble()),
                                                    color: AppColors.red,
                                                    titleStyle: AppStyle.smallBold(Colors.white),
                                                    radius:25.r
                                                ),
                                                PieChartSectionData(
                                                    value: data.taskOut.toDouble(),
                                                    title: priceFormat.format(data.taskOut),
                                                    color: Colors.orange,
                                                    titleStyle: AppStyle.smallBold(Colors.white),
                                                    radius:25.r
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
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.square,color: Colors.red,),
                                                Text("Режа бўйича",style: AppStyle.smallBold(Colors.black),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.square,color: AppColors.green,),
                                                Text("Бажарилган",style: AppStyle.smallBold(Colors.black),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.square,color: Colors.orange,),
                                                Text("Режадан ташқари",style: AppStyle.smallBold(Colors.black),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }return const SizedBox();
                          }
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                        padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 16.w),
                        alignment: Alignment.center,
                        width: width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.grey.shade400
                              )
                            ],
                            color: AppColors.white,
                            borderRadius:  BorderRadius.circular(10)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Валюта курси",style: AppStyle.smallBold(Colors.black),),
                            Text("${priceFormat.format(CacheService.getCurrency())} сўм",style: AppStyle.smallBold(Colors.black),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

