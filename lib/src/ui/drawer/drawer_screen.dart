import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_admin/src/bloc/client/agents_bloc.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/client/debtbook/debtbook_screen.dart';
import 'package:savdo_admin/src/ui/drawer/client/tab_bar_screen.dart';
import 'package:savdo_admin/src/ui/drawer/payment/outcome_pay/outcome_tapbar.dart';
import 'package:savdo_admin/src/ui/drawer/returend/returned_screen.dart';
import 'package:savdo_admin/src/ui/drawer/staff/staff_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int selected = 0;
  bool isValue = false;
  @override
  void initState() {
    isValue = CacheService.getLogin();
    agentsBloc.getAllAgents();
    clientBloc.getAllClient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.w,bottom: 8),
              width: MediaQuery.of(context).size.width,
              height: 150.h,
              decoration: const BoxDecoration(
                image:  DecorationImage(
                  image:  ExactAssetImage('assets/images/bg000.jpg'),
                  fit: BoxFit.cover,
                ),
              ),

              child: Stack(
                children: [
                  Positioned(
                      right: -40.w,
                      top: -40,
                      child: Opacity(
                        opacity: 0.6,
                        child: SvgPicture.asset("assets/icons/logo.svg",width: 170.r,),
                      ),
                  ),
                  Positioned(
                    top: 65.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(child: Text(CacheService.getName().toUpperCase()[0],style: AppStyle.mediumBold(Colors.black)),),
                        SizedBox(width: 8.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(CacheService.getName(),style: AppStyle.large(Colors.white),),
                            checkTip(CacheService.getTip())
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /// Warehouse Bloc
            ExpansionTile(title:  Text("Омбор ҳаракати",style: AppStyle.mediumBold(Colors.black),),
              shape: Border.all(color: Colors.transparent),
              initiallyExpanded: true,
              children: [
              /// Warehouse
              CacheService.getPermissionMainWarehouse1() ==0?const SizedBox():ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                selectedTileColor: AppColors.green,
                selected: selected ==1?true:false,
                selectedColor: selected ==1?AppColors.white:AppColors.black,
                leading: const Icon(Icons.warehouse_outlined),
                onTap: (){
                  setState(() =>selected =1);
                  Navigator.pushNamed(context, AppRouteName.wearHouse);
                },
                title: const Text("Омборлар"),
              ),
              /// Warehouse movement
                CacheService.getPermissionWarehouseAction1()==0?const SizedBox(): ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                selectedTileColor: AppColors.green,
                selected: selected ==2?true:false,
                selectedColor: selected ==2?AppColors.white:AppColors.black,
                leading: const Icon(Icons.published_with_changes_sharp),
                onTap: (){
                  setState(() =>selected =2);
                  Navigator.pushNamed(context, AppRouteName.wearHouseTransfer);
                },
                title: const Text("Омбор ҳаракати"),
              ),
              /// Products
                CacheService.getPermissionProduct1() == 0?const SizedBox():ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                selectedTileColor: AppColors.green,
                selected: selected ==3?true:false,
                selectedColor: selected ==3?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.apps_outlined),
                  onTap: (){
                    setState(() =>selected =3);
                    Navigator.pushNamed(context, '/product');
                  },
                  title: const Text("Картотека"),
                ),
              /// Product Income
             CacheService.getPermissionWarehouseIncome1()==0?const SizedBox():ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                selectedTileColor: AppColors.green,
                selected: selected ==4?true:false,
                selectedColor: selected ==4?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.add_business_outlined),
                  onTap: (){
                    setState(() =>selected =4);
                    Navigator.pushNamed(context, '/income');
                  },
                  title: const Text("Киримлар"),
                ),
              /// Product Outcome
              CacheService.getPermissionWarehouseOutcome1()==0?const SizedBox():ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                selectedTileColor: AppColors.green,
                selected: selected ==5?true:false,
                selectedColor: selected ==5?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.request_page_outlined),
                  onTap: (){
                    setState(() =>selected =5);
                    Navigator.pushNamed(context, AppRouteName.outcome);
                  },
                  title: const Text("Савдо-сотиқ"),
                ),
              /// Product Returned
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                selectedTileColor: AppColors.green,
                selected: selected ==6?true:false,
                selectedColor: selected ==6?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.move_down_sharp),
                  onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return const ReturnedScreen();
                  }));
                    setState(() => selected =6);
                  },
                  title: const Text("Қайтарилди"),
                ),
              /// Revision product
              // ListTile(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)
              //   ),
              //   selectedTileColor: AppColors.green,
              //   selected: selected ==14?true:false,
              //   selectedColor: selected ==14?AppColors.white:AppColors.black,
              //     leading: const Icon(Icons.recycling_outlined),
              //     onTap: (){
              //       setState(() => selected =14);
              //       Navigator.pushNamed(context, '/revision');
              //     },
              //     title: const Text("Ревизия"),
              //   ),
            ],),
            /// Buyers Bloc
            ExpansionTile(
              title: Text("Ишчи-хизматчилар",style: AppStyle.mediumBold(Colors.black),),
              shape: Border.all(color: Colors.transparent),
              initiallyExpanded: true,
              children: [
                CacheService.getPermissionUserWindow1()==0?const SizedBox():ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  selectedTileColor: AppColors.green,
                  selected: selected ==12?true:false,
                  selectedColor: selected ==12?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.person),
                  onTap: (){
                    setState(() =>selected =12);
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return StaffScreen();
                    }));
                  },
                  title: const Text("Ходимлар"),
                ),
                CacheService.getPermissionClientList1()==0? const SizedBox():ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  selectedTileColor: AppColors.green,
                  selected: selected ==7?true:false,
                  selectedColor: selected ==7?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.people_alt),
                  onTap: (){
                    setState(() =>selected =7);
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return const TabBarScreen();
                    }));
                  },
                  title: const Text("Харидорлар"),
                ),
                CacheService.getPermissionClientDebt1()==0? const SizedBox():ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  selectedTileColor: AppColors.green,
                  selected: selected ==11?true:false,
                  selectedColor: selected ==11?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.book_outlined),
                  onTap: (){
                    setState(() =>selected =11);
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return const DebtBookScreen();
                    }));
                  },
                  title: const Text("Қарздорлик китоби"),
                ),
              ],),
            /// Income Outcome and Cost Bloc
            ExpansionTile(title:  Text("Тўловлар",style: AppStyle.mediumBold(Colors.black),),
              shape: Border.all(color: Colors.transparent),
              initiallyExpanded: true,
              children: [
                /// Income
                CacheService.getPermissionPaymentIncome1()==0?const SizedBox():ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  selectedTileColor: AppColors.green,
                  selected: selected ==8?true:false,
                  selectedColor: selected ==8?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.monetization_on),
                  onTap: (){
                    setState(() =>selected =8);
                    Navigator.pushNamed(context, AppRouteName.incomeTabBar);
                  },
                  title: const Text("Киримлар"),
                ),
                /// Outcome
                CacheService.getPermissionPaymentOutcome1()==0?const SizedBox():ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  selectedTileColor: AppColors.green,
                  selected: selected ==9?true:false,
                  selectedColor: selected ==9?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.outbound),
                  onTap: (){
                    setState(() =>selected =9);
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return const OutcomeTabBarScreen();
                    }));
                    },
                  title: const Text("Чиқимлар"),
                ),
                /// Cost
                CacheService.getPermissionPaymentExpense1()==0?const SizedBox(): ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  selectedTileColor: AppColors.green,
                  selected: selected ==10?true:false,
                  selectedColor: selected ==10?AppColors.white:AppColors.black,
                  leading: const Icon(Icons.money),
                  onTap: (){
                    setState(() =>selected =10);
                    Navigator.pushNamed(context, AppRouteName.costList);
                  },
                  title: const Text("Харажат"),
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  selectedTileColor: AppColors.green,
                  leading: const Icon(Icons.logout),
                  onTap: () async {
                    CenterDialog.showLogOutDialog(context, "Дастурдан чиқмоқчимиз?");
                  },
                  title: const Text("Log Out"),
                ),
                ListTile(
                    title: Text("Парол сақланмасин"),
                    trailing: Checkbox(value: isValue,onChanged: (bool? value){
                      isValue = value!;
                      CacheService.saveLogin(isValue);
                      setState(() {});
                    },)
                ),
                SizedBox(height: 12.h,)
              ],),
          ],
        ),
      ),
    );
  }
  Widget checkTip(String id){
    switch(id){
      case '0':
        return  Text("Админ",style: AppStyle.small(Colors.white),);
      case '1':
        return const Text("Кассир");
      case '2':
        return const Text("Омборчи");
    }
    return const Text("Админ");
  }
}
