import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/warehousetransfer/warehouse_transfer_bloc.dart';
import 'package:savdo_admin/src/dialog/bottom_dialog.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/warehousetransfer/warehouse_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/warehouse/warehouse_transfer/warehouseDocument/warehouse_document_screen.dart';
import 'package:savdo_admin/src/ui/drawer/warehouse/warehouse_transfer/warehouse_detail_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

class WareHouseTransferScreen extends StatefulWidget {
  const WareHouseTransferScreen({super.key});
  @override
  State<WareHouseTransferScreen> createState() => _WareHouseTransferScreenState();
}

class _WareHouseTransferScreenState extends State<WareHouseTransferScreen> {
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  @override
  void initState() {
    wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Column(
          children: [
            const Text("Омбор ҳаракатлари"),
            Text(DateFormat('yyyy-MMM').format(dateTime),style: AppStyle.smallBold(Colors.grey),),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            showMonthPicker(
                roundedCornersRadius: 25,
                headerColor: AppColors.green,
                selectedMonthBackgroundColor: AppColors.green.withOpacity(0.7),
                context: context,
                initialDate: dateTime,
                lastDate: DateTime.now()
            ).then((date) {
              if (date != null) {
                setState(() {
                  dateTime = date;
                });
                wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month);
              }
            });
          }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,))
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
                  if(data.isNotEmpty){
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
                                      HttpResult res = await repository.lockWarehouse(data[index].id, 1);
                                      if(res.result['status'] == false){
                                        if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                                      }
                                      wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month);
                                    },
                                      icon: Icons.lock,
                                      label: "Қулфлаш",
                                    ),
                                    SlidableAction(onPressed: (i) async {
                                      HttpResult res = await repository.lockWarehouse(data[index].id, 0);
                                      if(res.result['status'] == false){
                                        if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                                      }
                                      wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month);
                                    },
                                      label: "Очиш",
                                      icon: Icons.lock_open,),
                                  ],
                                ))
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      SlidableAction(onPressed: (i)
                                      async {
                                        HttpResult res = await repository.deleteWarehouseTransfer(data[index].id);
                                        if(res.result['status'] == true){
                                          await wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month);
                                        }
                                        else{
                                          if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                                        }
                                      },
                                        icon: Icons.delete,
                                        label: "Ўчириш",
                                      ),
                                      // SlidableAction(onPressed: (i) async
                                      // {
                                      //
                                      // },
                                      //   icon: Icons.edit,
                                      //   label: "Таҳрирлаш",
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: (){
                                BottomDialog.showScreenDialog(context, WareHouseDetailScreen(data: data[index].sklPerTov));
                              },
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
                                    Container(
                                      decoration:  BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        color: AppColors.green
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical:4.h),
                                      margin: EdgeInsets.only(left: 16.w),
                                      child: Text("№${data[index].ndoc}",style: AppStyle.smallBold(Colors.white),),
                                    ),
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(child: Text(data[index].warehouseFrom,maxLines: 1,style: AppStyle.mediumBold(Colors.black),)),
                                          CircleAvatar(
                                            child: Icon(data[index].pr ==1?Icons.lock:Icons.repeat,color: AppColors.green,),
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
                                          Text("Жами сўм:",style: AppStyle.smallBold(Colors.black),),
                                          Text("${priceFormat.format(data[index].sm)} сўм",style: AppStyle.smallBold(Colors.black),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 4.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Жами валюта:",style: AppStyle.smallBold(Colors.black),),
                                          Text("${priceFormatUsd.format(data[index].smS)} \$",style: AppStyle.smallBold(Colors.black),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }else{
                    return const EmptyWidgetScreen();
                  }
                }
                return const Center(child: CircularProgressIndicator.adaptive());
              }
            ),
          ),
          ButtonWidget(onTap: () async {
            CenterDialog.showLoadingDialog(context, "Бироз кутинг");
            HttpResult setDoc = await repository.setDoc(5);
            if(setDoc.result['status'] == true){
              if(context.mounted) {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (ctx){
                return  WarehouseDocumentScreen(ndoc: setDoc.result['ndoc'],);
              }));
              }
            }
            else{
              if(context.mounted)Navigator.pop(context);
              if(context.mounted)CenterDialog.showErrorDialog(context, setDoc.result['message']);
            }
          }, color: AppColors.green, text: "Янги киритиш"),
          SizedBox(height: 24.h,)
        ],
      ),
    );
  }
}
