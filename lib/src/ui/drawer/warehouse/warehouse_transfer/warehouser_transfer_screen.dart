import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/warehousetransfer/warehouse_transfer_bloc.dart';
import 'package:savdo_admin/src/dialog/bottom_dialog.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/warehousetransfer/warehouse_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/warehouse/warehouse_transfer/warehouseDocument/warehouse_document_screen.dart';
import 'package:savdo_admin/src/ui/drawer/warehouse/warehouse_transfer/warehouse_detail_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/utils.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class WareHouseTransferScreen extends StatefulWidget {
  const WareHouseTransferScreen({super.key});
  @override
  State<WareHouseTransferScreen> createState() => _WareHouseTransferScreenState();
}

class _WareHouseTransferScreenState extends State<WareHouseTransferScreen> {
  final Repository _repository = Repository();
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  num docItem = 0,totalUzs = 0,totalUsd = 0;
  int wareHouseId = 1;
  String wareHouseName = '';
  @override
  void initState() {
    wareHouseName = CacheService.getWareHouseName();
    wareHouseId = CacheService.getWareHouseId();
    wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month,wareHouseId);
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
            GestureDetector(
                onTap: ()async{
                  List<ProductTypeAllResult> wareHouse = await _repository.getWareHouseBase();
                  showDialog(context: context, builder: (ctx){
                    return Dialog(
                      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.w,top: 16.w),
                              child: Text("Омборлар рўйхати",style: AppStyle.mediumBold(Colors.black),),
                            ),
                            Expanded(child: ListView.builder(
                                itemCount: wareHouse.length,
                                itemBuilder: (ctx,index){
                                  return ListTile(
                                    onTap: () async {
                                      wareHouseId = wareHouse[index].id;
                                      wareHouseName = wareHouse[index].name;
                                      CacheService.saveWareHouseId(wareHouse[index].id);
                                      CacheService.saveWareHouseName(wareHouse[index].name);
                                      await _repository.clearSkladBase();
                                      wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month,wareHouseId);
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    title: Text(wareHouse[index].name,style: AppStyle.medium(Colors.black),),
                                    trailing: Icon(Icons.radio_button_checked,color: wareHouseId == wareHouse[index].id?AppColors.green:Colors.grey,),
                                  );
                                }))
                          ],
                        ),
                      ),
                    );
                  });
                },
                child: Text(wareHouseName,style: AppStyle.small(Colors.grey),)),
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
                wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month,wareHouseId);
              }
            });
          }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,))
        ],
      ),
      body: StreamBuilder<List<WareHouseResult>>(
        stream: wareHouseTransferBloc.getWarehouseTransferStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            docItem = 0;
            totalUsd = 0;
            totalUzs = 0;
            var data = snapshot.data!;
            for(int i =0; i<data.length;i++){
              docItem = data.length;
              totalUsd += data[i].smS;
              totalUzs += data[i].sm;
            }
            if(data.isNotEmpty){
              return SnappingSheet(
                snappingPositions: const [
                  SnappingPosition.factor(
                    positionFactor: 0.0,
                    snappingCurve: Curves.easeOutExpo,
                    snappingDuration: Duration(seconds: 1),
                    grabbingContentOffset: GrabbingContentOffset.top,
                  ),
                  SnappingPosition.pixels(
                    positionPixels: 200,
                    snappingCurve: Curves.elasticOut,
                    snappingDuration: Duration(milliseconds: 1750),
                  ),
                ],
                grabbing: GestureDetector(
                  onTap: ()async{
                    if(CacheService.getPermissionWarehouseAction2()==0){

                    }else{
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
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                    ),
                    child: Text("Янги киритиш",style: AppStyle.large(AppColors.white),),
                  ),
                ),
                grabbingHeight: 65.spMax,
                sheetBelow: SnappingSheetContent(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: 12.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ҳужжат сони",style: AppStyle.smallBold(Colors.grey),),
                              Text(docItem.toString(),style: AppStyle.smallBold(Colors.black),)
                            ],
                          ),
                          const Row(
                            children: [
                              Expanded(child: DashedRect())
                            ],
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Жами сўм",style: AppStyle.smallBold(Colors.grey),),
                              Text(priceFormat.format(totalUzs),style: AppStyle.smallBold(Colors.black),)
                            ],
                          ),
                          const Row(
                            children: [
                              Expanded(child: DashedRect())
                            ],
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Жами валюта",style: AppStyle.smallBold(Colors.grey),),
                              Text(priceFormatUsd.format(totalUsd),style: AppStyle.smallBold(Colors.black),)
                            ],
                          ),
                          const Row(
                            children: [
                              Expanded(child: DashedRect())
                            ],
                          ),
                        ],
                      ),
                    ),
                ),
                child: ListView.builder(
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
                                  wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month,wareHouseId);
                                },
                                  icon: Icons.lock,
                                  label: "Қулфлаш",
                                ),
                                SlidableAction(onPressed: (i) async {
                                  HttpResult res = await repository.lockWarehouse(data[index].id, 0);
                                  if(res.result['status'] == false){
                                    if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                                  }
                                  wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month,wareHouseId);
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
                                  CacheService.getPermissionWarehouseAction4()==0?const SizedBox():SlidableAction(onPressed: (i) async {
                                    HttpResult res = await repository.deleteWarehouseTransfer(data[index].id);
                                    if(res.result['status'] == true){
                                      await wareHouseTransferBloc.getAllWareHouseTransfer(dateTime.year, dateTime.month,wareHouseId);
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
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 4.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Вақти:",style: AppStyle.smallBold(Colors.grey),),
                                      Text(data[index].vaqt.toString().substring(0,16),style: AppStyle.smallBold(Colors.grey),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }else{
              return const EmptyWidgetScreen();
            }
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      ),
    );
  }
}
