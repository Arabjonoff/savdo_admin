import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/warehouse/warehouse_transfer/warehouseDocument/warehouse_document_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class WareHouseTransferScreen extends StatefulWidget {
  const WareHouseTransferScreen({super.key});

  @override
  State<WareHouseTransferScreen> createState() => _WareHouseTransferScreenState();
}

class _WareHouseTransferScreenState extends State<WareHouseTransferScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Омбор ҳаракатлари"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (ctx,index){
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    Expanded(child: Column(
                      children: [
                        SlidableAction(onPressed: (i){},
                          icon: Icons.lock,
                          label: "Қулфлаш",
                        ),
                        SlidableAction(onPressed: (i){},
                          label: "Очиш",
                          icon: Icons.lock_open,),
                      ],
                    ))
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(onPressed: (i){},
                      icon: Icons.delete,
                      label: "Ўчириш",
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.shade300
                          )
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(child: Text("Асосий Омбор",maxLines: 1,style: AppStyle.medium(Colors.black),)),
                            CircleAvatar(
                              child: Icon(Icons.repeat,color: AppColors.green,),
                            ),
                            SizedBox(width: 12.w,),
                            Expanded(child: Text("Қўшимча Омбор",maxLines: 1,style: AppStyle.medium(Colors.black),)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Товар миқдори:",style: AppStyle.small(Colors.black),),
                            Text("94934",style: AppStyle.medium(Colors.black),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Товар суммаси:",style: AppStyle.small(Colors.black),),
                            Text("893 384 432 som",style: AppStyle.medium(Colors.black),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          ButtonWidget(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx){
              return WarehouseDocumentScreen();
            }));
          }, color: AppColors.green, text: "Янги киритиш"),
          SizedBox(height: 24.h,)
        ],
      ),
    );
  }
}
