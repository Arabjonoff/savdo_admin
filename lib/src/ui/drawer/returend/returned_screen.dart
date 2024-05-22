// ignore_for_file: use_build_context_synchronously, avoid_function_literals_in_foreach_calls
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/returned/returned_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/returned/returned_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/returend/doc_retured_screen.dart';
import 'package:savdo_admin/src/ui/drawer/returend/update_returned/update_returned_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class ReturnedScreen extends StatefulWidget {
  const ReturnedScreen({super.key});

  @override
  State<ReturnedScreen> createState() => _ReturnedScreenState();
}

class _ReturnedScreenState extends State<ReturnedScreen> {
  int wareHouseId = 1;
  String wareHouseName = '';
  final Repository _repository = Repository();
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    wareHouseName = CacheService.getWareHouseName();
    wareHouseId = CacheService.getWareHouseId();
    returnBloc.getReturnedAll(dateTime.year, dateTime.month, wareHouseId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
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
                _repository.clearSkladBase();
                returnBloc.getReturnedAll(dateTime.year, dateTime.month, wareHouseId);
              }
            });
          }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,))
        ],
        title: Column(
          children: [
            Text("Қайтарилди"),
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
                                      returnBloc.getReturnedAll(dateTime.year, dateTime.month, wareHouseId);
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
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
        },
        child: StreamBuilder<List<ReturnedResult>>(
            stream: returnBloc.getReturnedStream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var data = snapshot.data!;
                return SnappingSheet(
                  grabbingHeight: 65.spMax,
                  // TODO: Add your grabbing widget here,
                  grabbing: GestureDetector(
                    onTap: ()async{
                      if(CacheService.getPermissionWarehouseOutcome2()==1){
                        CenterDialog.showLoadingDialog(context, "Бироз кутинг!");
                        HttpResult res = await _repository.setDoc(3);
                        if(res.isSuccess){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                            return DocReturnedScreen(isUpdate: false,ndoc: res.result['ndoc'],);
                          }));
                        }
                        else{
                          Navigator.pop(context);
                          CenterDialog.showErrorDialog(context, res.result['message']);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        color: AppColors.green,
                      ),
                      alignment: Alignment.center,
                      child: Text(CacheService.getPermissionWarehouseOutcome2()==1?"Янги ҳужжат очиш":"",style: AppStyle.mediumBold(Colors.white),),
                    ),
                  ),
                  snappingPositions: const [
                    SnappingPosition.factor(
                      positionFactor: 0.0,
                      snappingCurve: Curves.easeOutExpo,
                      snappingDuration: Duration(seconds: 1),
                      grabbingContentOffset: GrabbingContentOffset.top,
                    ),
                    SnappingPosition.pixels(
                      positionPixels: 400,
                      snappingCurve: Curves.elasticOut,
                      snappingDuration: Duration(milliseconds: 1750),
                    ),
                  ],
                  sheetBelow: SnappingSheetContent(
                    draggable: (details) => true,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [],
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
                              Expanded(
                                child: Column(
                                  children: [
                                    SlidableAction(
                                        label: 'Қулфлаш',
                                        onPressed: (i) async {
                                          HttpResult res = await _repository.lockReturned(data[index].id,1);
                                          if(res.result["status"] == true){
                                          }else{
                                            if(context.mounted)CenterDialog.showErrorDialog(context, res.result["message"]);
                                          }
                                          await returnBloc.getReturnedAll(dateTime.year, dateTime.month, wareHouseId);
                                        },
                                        icon: Icons.lock),
                                    SlidableAction(
                                      label: 'Очиш',
                                      onPressed: (i) async {
                                        HttpResult res = await _repository.lockReturned(data[index].id,0);
                                        if(res.result["status"] == true){
                                        }else{
                                          if(context.mounted)CenterDialog.showErrorDialog(context, res.result["message"]);
                                        }
                                        await returnBloc.getReturnedAll(dateTime.year, dateTime.month, wareHouseId);
                                      }, icon: Icons.lock_open,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    CacheService.getPermissionWarehouseOutcome3()==0?const SizedBox():SlidableAction(
                                        label: 'Таҳрирлаш',
                                        onPressed: (i){
                                          data[index].sklVzTov.forEach((element) async{ await _repository.saveOutcomeCart(SklRsTov.fromJson(element.toJson()));});
                                          if(data[index].pr==1){
                                            CenterDialog.showErrorDialog(context, "Ҳужжат қулфланган");
                                          }else{
                                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                              return UpdateReturnedScreen(ndocId: data[index].id,);
                                            }));
                                          }
                                        },
                                        icon: Icons.edit),
                                    CacheService.getPermissionWarehouseOutcome4()==0?const SizedBox():SlidableAction(
                                      label: "Ўчириш",
                                      onPressed: (i){
                                        CenterDialog.showDeleteDialog(context, ()async{
                                          HttpResult res = await _repository.deleteReturnedDoc(data[index].id);
                                          if(res.result['status'] == true){
                                            Navigator.pop(context);
                                            await returnBloc.getReturnedAll(dateTime.year, dateTime.month, wareHouseId);
                                          }
                                          else{
                                            Navigator.pop(context);
                                            CenterDialog.showErrorDialog(context, res.result['message']);
                                          }
                                        });
                                      }, icon: Icons.delete,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              // Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              //   return ShareScreen(data: data[index],);
                              // }));
                              // Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              //   return DocumentOutComeScreen();
                              // }));
                              // var body = {
                              //   "NAME": data[index].name,
                              //   "ID_T": data[index].idT,
                              //   "NDOC": data[index].ndoc,
                              //   "SANA": data[index].sana.toString(),
                              //   "IZOH": data[index].izoh,
                              //   "ID_HODIM": data[index].idHodim,
                              //   "ID_AGENT": data[index].idAgent,
                              //   "ID_HARIDOR": data[index].idHaridor,
                              //   "KURS": data[index].kurs,
                              //   "ID_FAOL": data[index].idFaol,
                              //   "ID_KLASS": data[index].idKlass,
                              //   "ID_SKL": 1,
                              //   "YIL": DateTime.now().year,
                              //   "OY":  DateTime.now().month
                              // };
                              // HttpResult res = await _repository.updateDocOutcome(body);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.card,
                                  border:  Border(bottom: BorderSide(color: Colors.grey.shade400)
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                                    decoration: BoxDecoration(
                                        color: AppColors.green,
                                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                                    ),
                                    child: Text(data[index].idAgentName,style: AppStyle.smallBold(Colors.white),),
                                  ),
                                  SizedBox(height: 4.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                                      Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: data[index].pr ==1?Colors.red:AppColors.green
                                          ),
                                          child: Text("№${data[index].ndoc}",style: AppStyle.medium(Colors.white),)),
                                    ],
                                  ),
                                  Text(data[index].izoh,style: AppStyle.small(Colors.grey),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Жами:",style: AppStyle.medium(Colors.black),),
                                      Text("${priceFormat.format(data[index].sm)} сўм | ${priceFormatUsd.format(data[index].smS)} \$",style: AppStyle.medium(Colors.black),),
                                    ],
                                  ),
                                  SizedBox(height: 4.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Вақти',style: AppStyle.small(Colors.black),),
                                      Text(data[index].vaqt.toString().substring(0,19),style: AppStyle.small(Colors.black),),
                                    ],
                                  ),
                                  SizedBox(height: 4.h,),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }
        ),
      ),
    );
  }
}
