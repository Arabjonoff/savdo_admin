import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/bloc/client/agent_permission.dart';
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
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/statistics/plan_model.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/drawer_screen.dart';
import 'package:savdo_admin/src/ui/main/home/balance/balance_screen.dart';
import 'package:savdo_admin/src/ui/main/home/plan_screen/plan_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
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
    balanceBloc.getAllBalance(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    planBloc.getPlanAll();
    // ConnectionUtil connectionStatus = ConnectionUtil.getInstance();
    // connectionStatus.initialize();
    // connectionStatus.connectionChange.listen(connectionChanged);
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
          await agentPermission.getAllPermission(CacheService.getIdAgent());
          await balanceBloc.getAllBalance(DateFormat('yyyy-MM-dd').format(DateTime.now()));
          await planBloc.getPlanAll();
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
                                  // Text("Асосий омбор",style: AppStyle.mediumBold(Colors.white),),
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

