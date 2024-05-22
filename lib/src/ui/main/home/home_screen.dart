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
  final List<SalesData> chartData = <SalesData>[
    SalesData(DateTime(2005, 0, 1), 'India', 1.5, 21, 28, 680, 760),
    SalesData(DateTime(2006, 0, 1), 'China', 2.2, 24, 44, 550, 880),
    SalesData(DateTime(2007, 0, 1), 'USA', 3.32, 36, 48, 440, 788),
    SalesData(DateTime(2008, 0, 1), 'Japan', 4.56, 38, 50, 350, 560),
    SalesData(DateTime(2009, 0, 1), 'Russia', 5.87, 54, 66, 444, 566),
    SalesData(DateTime(2010, 0, 1), 'France', 6.8, 57, 78, 780, 650),
    SalesData(DateTime(2011, 0, 1), 'Germany', 8.5, 70, 84, 450, 800)
  ];
  @override
  void initState() {
    staffPermission.getAllStaffPermission(CacheService.getIdAgent());
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
          await staffPermission.getAllStaffPermission(CacheService.getIdAgent());
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
                                  IconButton(onPressed: () =>_scaffoldKey.currentState!.openDrawer(), icon: const Icon(Icons.menu_outlined,color: Colors.white,)),
                                  Padding(
                                    padding:EdgeInsets.only(left: 12.0.spMax),
                                    child: GestureDetector(
                                      onTap: () {},
                                        child: CircleAvatar(
                                          child: Text(CacheService.getName()[0].toUpperCase()),
                                        )),
                                  ),
                                  // IconButton(onPressed: ()async{
                                  // Navigator.pushNamed(context, AppRouteName.message);
                                  // }, icon: const Icon(Icons.notifications_active,color: Colors.white,))
                                ],
                              ),
                              SizedBox(height: 40.spMax,),
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
                      } return Container(
                        width: width,
                        height: 250.h,
                        child: Image.asset("assets/images/bg000.jpg",fit: BoxFit.cover,),
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
                            }return const SizedBox();
                          }
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 400.w,left: 12.w,right: 12.w),
                  width: width,
                  height: 250.spMax,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey.shade400
                        ),
                      ],
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Кунлик Ҳисобот'),
                    legend: Legend(isVisible: true),
                    series: getDefaultData(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  static List<LineSeries<SalesData, num>> getDefaultData() {
    const bool isMarkerVisible = true, isTooltipVisible = true;
    double? lineWidth, markerWidth, markerHeight;
    final List<SalesData> chartData = <SalesData> [
      SalesData(DateTime(20205, 0, 1), 'India', 1.335, 21, 28, 680, 760),
      SalesData(DateTime(2006, 0, 1), 'China', 2.2, 234, 44, 550, 880),
      SalesData(DateTime(20037, 0, 1), 'USA', 3.32, 336, 48, 440, 788),
      SalesData(DateTime(2008, 0, 1), 'Japan', 4.56, 338, 350, 3350, 560),
      SalesData(DateTime(20309, 0, 1), 'Russia', 5.87, 524, 66, 444, 566),
      SalesData(DateTime(20130, 0, 1), 'France', 6.8, 573, 78, 780, 650),
      SalesData(DateTime(2011, 0, 1), 'Germany', 8.5, 730, 84, 450, 800)
    ];
    return <LineSeries<SalesData, num>>[
      LineSeries<SalesData, num>(
          enableTooltip: true,
          name: 'Киримлар',
          dataSource: chartData,
          xValueMapper: (SalesData sales, _) => sales.sales,
          yValueMapper: (SalesData sales, _) => sales.sales4,
          width: lineWidth ?? 2,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Colors.red),
      ),
      LineSeries<SalesData, num>(
          enableTooltip: isTooltipVisible,
          dataSource: chartData,
          name: 'Чиқимлар',
          width: lineWidth ?? 2,
          xValueMapper: (SalesData sales, _) => sales.sales,
          yValueMapper: (SalesData sales, _) => sales.sales3,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Colors.black),
      ),
      LineSeries<SalesData, num>(
          enableTooltip: isTooltipVisible,
          dataSource: chartData,
          name: 'Харажатлар',
          width: lineWidth ?? 2,
          xValueMapper: (SalesData sales, _) => sales.sales,
          yValueMapper: (SalesData sales, _) => sales.sales2,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Colors.black),
      ),
      LineSeries<SalesData, num>(
          enableTooltip: isTooltipVisible,
          dataSource: chartData,
          width: lineWidth ?? 2,
          name: "Тўловлар",
          xValueMapper: (SalesData sales, _) => sales.sales,
          yValueMapper: (SalesData sales, _) => sales.sales2,
          markerSettings: MarkerSettings(
              isVisible: isMarkerVisible,
              height: markerWidth ?? 4,
              width: markerHeight ?? 4,
              shape: DataMarkerType.circle,
              borderWidth: 3,
              borderColor: Colors.black),
      ),
    ];
  }
}
class SalesData {
  SalesData(this.year, this.name, this.sales, this.sales1, this.sales2, this.sales3, this.sales4);
  final DateTime year;
  final String name;
  final double sales;
  final double sales1;
  final double sales2;
  final double sales3;
  final double sales4;
}

