
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:savdo_admin/src/bloc/client/agents_bloc.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/client/tab_bar_screen.dart';
import 'package:savdo_admin/src/ui/drawer/payment/outcome_pay/outcome_tapbar.dart';
import 'package:savdo_admin/src/utils/cache.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int selected = 0;
  @override
  void initState() {
    agentsBloc.getAllAgents();
    clientBloc.getAllClient('');
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
              decoration:  BoxDecoration(
                  color: AppColors.green,
              ),
              child: Stack(
                children: [
                  Positioned(
                      right: -40.w,
                      top: -40,
                      child: Opacity(
                        opacity: 0.4,
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
                            Text("Admin",style: AppStyle.small(Colors.white),),
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
              ListTile(
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
              ListTile(
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
              ListTile(
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
              ListTile(
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
              ListTile(
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
              // ListTile(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)
              //   ),
              //   selectedTileColor: AppColors.green,
              //   selected: selected ==6?true:false,
              //   selectedColor: selected ==6?AppColors.white:AppColors.black,
              //     leading: const Icon(Icons.event_repeat_outlined),
              //     onTap: (){
              //       setState(() =>selected =6);
              //     },
              //     title: const Text("Қайтарилди"),
              //   ),
            ],),

            /// Buyers Bloc
            ExpansionTile(title:  Text("Харидорлар",style: AppStyle.mediumBold(Colors.black),),
              shape: Border.all(color: Colors.transparent),
              initiallyExpanded: true,
              children: [
                ListTile(
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
                      return TabBarScreen();
                    }));
                  },
                  title: const Text("Харидорлар"),
                ),
              ],),
            /// Income Outcome and Cost Bloc
            ExpansionTile(title:  Text("Тўловлар",style: AppStyle.mediumBold(Colors.black),),
              shape: Border.all(color: Colors.transparent),
              initiallyExpanded: true,
              children: [
                /// Income
                ListTile(
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
                ListTile(
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
                ListTile(
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
              ],),
          ],
        ),
      ),
    );
  }
}
