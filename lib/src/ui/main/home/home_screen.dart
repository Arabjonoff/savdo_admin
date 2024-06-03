import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/bloc/client/permission.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/bloc/getDate/get_date_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_barcode.dart';
import 'package:savdo_admin/src/bloc/product/product_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_quantity_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_type_bloc.dart';
import 'package:savdo_admin/src/bloc/sklad/warehouse_bloc.dart';
import 'package:savdo_admin/src/bloc/statistics/balance/balance_bloc.dart';
import 'package:savdo_admin/src/bloc/statistics/plan_bloc/plan_bloc.dart';
import 'package:savdo_admin/src/dialog/bottom_dialog.dart';
import 'package:savdo_admin/src/model/balance/balance_model.dart';
import 'package:savdo_admin/src/model/statistics/plan_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/drawer_screen.dart';
import 'package:savdo_admin/src/ui/main/home/balance/balance_screen.dart';
import 'package:savdo_admin/src/ui/main/home/plan_screen/plan_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../bloc/product/product_firma_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool balance = false;
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  // void connectionChanged(dynamic hasConnection) {
  // }
  final bool isDataLabelVisible = true, isMarkerVisible = true, isTooltipVisible = true;
  double? lineWidth, markerWidth, markerHeight;
  double dayCashUzs = 0,dayCommerceUzs = 0,dayCashUsd = 0,dayCommerceUsd = 0;
  @override
  void initState() {
    staffPermission.getAllStaffPermission(CacheService.getIdAgent());
    productBloc.getAllProduct();
    getDateBloc.getDateId();
    barcodeProductBloc.getBarcodeAll();
    clientBloc.getAllClient();
    wareHouseBloc.getAllWareHouse();
    clientBloc.getAllClientSearch('');
    productTypeBloc.getProductTypeAll();
    productFirmaTypeBloc.getFirmaBaseTypeAll();
    productQuantityTypeBloc.getQuantityBaseTypeAll();
    balanceBloc.getAllBalance(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    planBloc.getPlanAll();
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
          await staffPermission.getAllStaffPermission(CacheService.getIdAgent());
          await balanceBloc.getAllBalance(DateFormat('yyyy-MM-dd').format(DateTime.now()));
          await planBloc.getPlanAll();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            StreamBuilder<BalanceModel>(
                stream: balanceBloc.getBalanceStream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    var data = snapshot.data!;
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      width: width,
                      height: 220.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
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
                          SizedBox(height: 24.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: () =>_scaffoldKey.currentState!.openDrawer(), icon: const Icon(Icons.menu_outlined,color: Colors.white,)),
                              // Padding(
                              //   padding:EdgeInsets.only(left: 12.0.spMax),
                              //   child: GestureDetector(
                              //       onTap: () {},
                              //       child: CircleAvatar(
                              //         child: Text(CacheService.getName()[0].toUpperCase()),
                              //       )),
                              // ),
                              // IconButton(onPressed: ()async{
                              // Navigator.pushNamed(context, AppRouteName.message);
                              // }, icon: const Icon(Icons.notifications_active,color: Colors.white,))
                            ],
                          ),
                          SizedBox(height: 24.h,),
                          CacheService.getPermissionBalanceWindow1() ==0?const SizedBox():Padding(
                            padding: EdgeInsets.only(left: 12.0.w),
                            child: Text("Баланс",style: AppStyle.mediumBold(Colors.white),),
                          ),
                          CacheService.getPermissionBalanceWindow1() ==0?const SizedBox(): ListTile(
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
                  }
                  return Container(
                    padding: const EdgeInsets.only(top: 74,left: 16),
                    alignment: Alignment.topLeft,
                    width: width,
                    height: 220.h,
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                      color: AppColors.green,
                      image:  const DecorationImage(
                        image:  ExactAssetImage('assets/images/bg000.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: IconButton(onPressed: () =>_scaffoldKey.currentState!.openDrawer(), icon: const Icon(Icons.menu_outlined,color: Colors.white,)),
                  );
                }
            ),
            Column(
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
                                borderRadius: BorderRadius.circular(16),
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
                                  child: CircularPercentIndicator(
                                    radius: 60.0.r,
                                    lineWidth: 13.0,
                                    percent: snapshot.data!.percent,
                                    animation: true,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: snapshot.data!.f.isNaN?Text('0%',style: AppStyle.medium(AppColors.black)):Text("${snapshot.data!.f.toInt()}%",
                                      style: AppStyle.medium(Colors.black),
                                    ),
                                    progressColor: Colors.green,
                                  ),
                                ),
                                Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text("Режа бўйича: ${snapshot.data!.taskGo}",style: AppStyle.smallBold(Colors.black),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Бажарилган: ${snapshot.data!.taskDone}",style: AppStyle.smallBold(Colors.black),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Режадан ташқари: ${snapshot.data!.taskOut}",style: AppStyle.smallBold(Colors.black),),
                                    ],
                                  ),
                                ],
                              ),
                                SizedBox(width: 16.w,)
                              ],
                            ),
                          ),
                        );
                      }return Container(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                        width: width,
                        height: 150.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
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
                              child: CircularPercentIndicator(
                                radius: 60.0.r,
                                lineWidth: 13.0,
                                percent: 0,
                                animation: true,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: Text('0%',style: AppStyle.medium(Colors.black),),
                                progressColor: Colors.green,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text("Режа бўйича: 0",style: AppStyle.smallBold(Colors.black),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Бажарилган: 0",style: AppStyle.smallBold(Colors.black),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Режадан ташқари: 0",style: AppStyle.smallBold(Colors.black),),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 16.w,)
                          ],
                        ),
                      );
                    }
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 4.w,
                      top: 8.h,
                      bottom: 24.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                    height: 120.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey.shade400
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Савдодаги сумма",style: AppStyle.small(Colors.black),),
                        Text(priceFormat.format(dayCashUzs),style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      right: 4.w,
                      top: 8.h,
                      bottom: 24.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                    width: width,
                    height: 120.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey.shade400
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Кассадаги сумма",style: AppStyle.small(Colors.black),),
                        Text("109 382 990 сум",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


