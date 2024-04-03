import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/warehousetransfer/warehouse_transfer_bloc.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/warehousetransfer/warehouse_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/ui/main/warehouse/warehouse_transfer/warehouseDocument/warehouse_document_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class WareHouseTransferScreen extends StatefulWidget {
  const WareHouseTransferScreen({super.key});

  @override
  State<WareHouseTransferScreen> createState() => _WareHouseTransferScreenState();
}

class _WareHouseTransferScreenState extends State<WareHouseTransferScreen> {
  @override
  void initState() {
    wareHouseTransferBloc.getAllWareHouseTransfer(2024, 4);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Омбор ҳаракатлари"),
        actions: [
          IconButton(onPressed: (){}, icon:Icon(Icons.calendar_month,color: AppColors.green,))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<WareHouseResult>>(
              stream: wareHouseTransferBloc.getWarehouseTransferStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  var data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                      itemBuilder: (ctx,index){
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          Expanded(child: Column(
                            children: [
                              SlidableAction(onPressed: (i)async{
                                HttpResult res = await repository.lockWarehouse(data[index].id, 0);
                              },
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
                      endActionPane: ActionPane(
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
                                  Expanded(child: Text(data[index].warehouseFrom,maxLines: 1,style: AppStyle.mediumBold(Colors.black),)),
                                  CircleAvatar(
                                    child: Icon(Icons.repeat,color: AppColors.green,),
                                  ),
                                  SizedBox(width: 12.w,),
                                  Expanded(child: Text(data[index].warehouseTo,maxLines: 1,style: AppStyle.mediumBold(Colors.black),)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 4.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Жами сўм:",style: AppStyle.small(Colors.black),),
                                  Text("${priceFormat.format(data[index].sm)} сўм",style: AppStyle.medium(Colors.black),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 4.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Жами валюта:",style: AppStyle.small(Colors.black),),
                                  Text("${priceFormat.format(data[index].sm)} \$",style: AppStyle.medium(Colors.black),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }
                return const Center(child: CircularProgressIndicator.adaptive());
              }
            ),
          ),
          ButtonWidget(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx){
              return const WarehouseDocumentScreen();
            }));
          }, color: AppColors.green, text: "Янги киритиш"),
          SizedBox(height: 24.h,)
        ],
      ),
    );
  }
}
