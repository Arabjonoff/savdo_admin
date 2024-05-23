
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/income_bloc.dart';
import 'package:savdo_admin/src/dialog/bottom_dialog.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_model.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/income/income_detail.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/utils.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

import 'update_income/update_income_screen.dart';


class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> with SingleTickerProviderStateMixin{
  final Repository _repository = Repository();
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  final _controller = ScrollController();
  bool scrollTop = false;
  int wareHouseId = 1;
  String wareHouseName = '';
  num docItem = 0,incomeUzs=0,incomeUsd=0,salesUzs=0,salesUsd=0,expenseUzs =0,expenseUsd=0;

  @override
  void initState() {
    wareHouseName = CacheService.getWareHouseName();
    wareHouseId = CacheService.getWareHouseId();
    incomeBloc.getAllIncome(dateTime.year,dateTime.month,wareHouseId);
    super.initState();
  }
  @override
  void dispose() {
    wareHouseName = CacheService.getWareHouseName();
    wareHouseId = CacheService.getWareHouseId();
    incomeBloc.getAllIncome(dateTime.year,dateTime.month,wareHouseId);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Column(
          children: [
            const Text("Киримлар"),
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
                                    incomeBloc.getAllIncome(dateTime.year,dateTime.month,wareHouseId);
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
                _repository.clearSkladBase();
                incomeBloc.getAllIncome(dateTime.year,dateTime.month,wareHouseId);
              }
            });
          }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,))
        ],
      ),
      body: StreamBuilder<IncomeModel>(
        stream: incomeBloc.getIncomeStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!.data;
            incomeUsd=0;
            docItem = 0;
            incomeUzs=0;
            salesUsd=0;
            salesUzs=0;
            expenseUsd=0;
            expenseUzs=0;
            for(int i=0;i<data.length;i++){
              docItem = data.length;
              incomeUzs += data[i].smT;
              incomeUsd += data[i].smTS;
              salesUsd += data[i].smS;
              salesUzs += data[i].sm;
              expenseUsd += data[i].harS;
              expenseUzs += data[i].har;
            }
            return SnappingSheet(
              grabbingHeight: 65.r,
              grabbing: GestureDetector(
                onTap: ()async{
                  if(CacheService.getPermissionWarehouseIncome2()==0){
                  }
                  else{
                    CenterDialog.showLoadingDialog(context, "Бироз кутинг");
                    HttpResult setDoc = await _repository.setDoc(1);
                    if(setDoc.result['status'] == true){
                      if(context.mounted){
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRouteName.addDocumentIncome,arguments: setDoc.result['ndoc']);
                      }
                    }else{
                      if(context.mounted){
                        Navigator.pop(context);
                        CenterDialog.showErrorDialog(context, setDoc.result['message']);
                      }
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color:AppColors.green,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  ),
                  child: Text("Янги ҳужжат очиш",style: AppStyle.mediumBold(Colors.white),),
                ),
              ),
              snappingPositions:  [
                const SnappingPosition.factor(
                  positionFactor: 0.0,
                  snappingCurve: Curves.easeOutExpo,
                  snappingDuration: Duration(seconds: 1),
                  grabbingContentOffset: GrabbingContentOffset.top,
                ),
                SnappingPosition.pixels(
                  positionPixels: 300.h,
                  snappingCurve: Curves.elasticOut,
                  snappingDuration: const Duration(milliseconds: 1750),
                ),
              ],
              sheetBelow: SnappingSheetContent(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ҳужжат сони",style: AppStyle.smallBold(Colors.grey),),
                            Text(docItem.toString()),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: DashedRect(gap: 2.3,color: Colors.grey,)),
                          ],
                        ),
                        SizedBox(height: 8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Кирим нархи сўм",style: AppStyle.smallBold(Colors.grey),),
                            Text(priceFormat.format(incomeUzs)),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: DashedRect(gap: 2.3,color: Colors.grey,)),
                          ],
                        ),
                        SizedBox(height: 8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Кирим нархи \$",style: AppStyle.smallBold(Colors.grey),),
                            Text(priceFormatUsd.format(incomeUsd)),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: DashedRect(gap: 2.3,color: Colors.grey,)),
                          ],
                        ),
                        SizedBox(height: 8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Сотиш нархи сўм",style: AppStyle.smallBold(Colors.grey),),
                            Text(priceFormat.format(salesUzs)),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: DashedRect(gap: 2.3,color: Colors.grey,)),
                          ],
                        ),
                        SizedBox(height: 8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Сотиш нархи \$",style: AppStyle.smallBold(Colors.grey),),
                            Text(priceFormatUsd.format(salesUsd)),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: DashedRect(gap: 2.3,color: Colors.grey,)),
                          ],
                        ),
                        SizedBox(height: 8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Харажат сўм",style: AppStyle.smallBold(Colors.grey),),
                            Text(priceFormat.format(expenseUzs)),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: DashedRect(gap: 2.3,color: Colors.grey,)),
                          ],
                        ),
                        SizedBox(height: 8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Харажат \$",style: AppStyle.smallBold(Colors.grey),),
                            Text(priceFormatUsd.format(expenseUsd)),
                          ],
                        ),
                      ],
                    ),
                  )),
              child: RefreshIndicator(
                  onRefresh: ()async{
                    await incomeBloc.getAllIncome(dateTime.year,dateTime.month,wareHouseId);
                  },
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: data.length,
                      itemBuilder: (ctx,index){
                        return GestureDetector(
                          onTap: (){},
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      SlidableAction(
                                          label: 'Қулфлаш',
                                          onPressed: (i) async {
                                            HttpResult res = await _repository.lockIncome(data[index].id,1);
                                            if(res.result['status'] == true){
                                              incomeBloc.getAllIncome(dateTime.year,dateTime.month,wareHouseId);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text(res.result['message']),backgroundColor: Colors.green,)
                                              );
                                            }
                                            else{
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text(res.result['message']),backgroundColor: Colors.red,)
                                              );
                                            }
                                          },
                                          icon: Icons.lock),
                                      SlidableAction(
                                        label: 'Очиш',
                                        onPressed: (i) async {
                                          HttpResult res = await _repository.lockIncome(data[index].id,0);
                                          if(res.result['status'] == true){
                                            incomeBloc.getAllIncome(dateTime.year,dateTime.month,wareHouseId);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(res.result['message']),backgroundColor: Colors.green,)
                                            );
                                          }
                                          else{
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(res.result['message']),backgroundColor: Colors.red,)
                                            );
                                          }
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
                                      CacheService.getPermissionWarehouseIncome3()==0?const SizedBox():SlidableAction(
                                          label: 'Таҳрирлаш',
                                          onPressed: (i) async {
                                            if(data[index].pr ==1){
                                              CenterDialog.showErrorDialog(context, "Ҳужжат қулфланган");
                                            }else{
                                              // ignore: avoid_function_literals_in_foreach_calls
                                              data[index].sklPrTov.forEach((element)async => await _repository.saveIncomeProductBase(element.toJson()));
                                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                                return UpdateIncomeScreen(data: data[index],);
                                              }));
                                            }
                                          },
                                          icon: Icons.edit),
                                      CacheService.getPermissionWarehouseIncome4()==0?const SizedBox():SlidableAction(
                                        label: "Ўчириш",
                                        onPressed: (i){
                                          CenterDialog.showDeleteDialog(context, ()async{
                                            HttpResult res = await _repository.deleteIncome(data[index].id);
                                            if(res.result['status'] == true){
                                              incomeBloc.getAllIncome(dateTime.year,dateTime.month,wareHouseId);
                                              Navigator.pop(context);
                                            }
                                            else{
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result['message']),backgroundColor: Colors.red,));
                                              Navigator.pop(context);
                                            }
                                          });
                                        }, icon: Icons.delete,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: (){
                                BottomDialog.showScreenDialog(context, IncomeDetailScreen(data: data[index].sklPrTov,));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.card,
                                    border:  Border(bottom: BorderSide(color: Colors.grey.shade400)
                                    )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: data[index].pr==1?AppColors.red:AppColors.green
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 1),
                                          child: Text("№${data[index].ndoc}",style: AppStyle.medium(Colors.white),),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Кирим нархи:",style: AppStyle.small(Colors.black),),
                                        Text("${priceFormat.format(data[index].smT)} сўм | ${priceFormatUsd.format(data[index].smTS)} \$",style: AppStyle.smallBold(Colors.black),)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Сотиш нархи:",style: AppStyle.small(Colors.black),),
                                        Text("${priceFormat.format(data[index].sm)} сўм | ${priceFormat.format(data[index].smS)} \$",style: AppStyle.smallBold(AppColors.green),)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Харажат:",style: AppStyle.small(Colors.black),),
                                        Text("${priceFormat.format(data[index].har)} сўм | ${priceFormat.format(data[index].harS)} \$",style: AppStyle.smallBold(Colors.red),),
                                      ],
                                    ),
                                    SizedBox(height: 4.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Вақти:",style: AppStyle.small(Colors.black),),
                                        Text(data[index].vaqt.toString().substring(0,19),style: AppStyle.small(Colors.black),),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 1,
                                    //   width: MediaQuery.of(context).size.width,
                                    //   child: DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                                    // ),
                                    ///
                                    // Text("Жами кирим сотув нархда:",style: AppStyle.medium(Colors.indigo),),
                                    // Row(
                                    //   children: [
                                    //     Text("320 323 сўм | ",style: AppStyle.medium(Colors.indigo),),
                                    //     Text("909 320 \$",style: AppStyle.medium(Colors.indigo),),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 1,
                                    //   width: MediaQuery.of(context).size.width,
                                    //   child: DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                                    // ),
                                    // Text("Кирим харажатлари:",style: AppStyle.medium(Colors.red),),
                                    // Row(
                                    //   children: [
                                    //     Text("909 323 сўм | ",style: AppStyle.medium(Colors.red),),
                                    //     Text("909 323 \$",style: AppStyle.medium(Colors.red),),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 1,
                                    //   width: MediaQuery.of(context).size.width,
                                    //   child: DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
  Widget priceCheckSm(data){
    if(data.sm != 0){
      return Text("${priceFormat.format(data.sm)} сўм",style: AppStyle.medium(Colors.black),);
  }
    else{
      return Text("${priceFormat.format(data.smS)} \$",style: AppStyle.medium(Colors.black),);
    }
  }
  Widget priceCheckSmT(data){
    if(data.smT != 0){
      return Text("${priceFormat.format(data.smT)} сўм",style: AppStyle.medium(Colors.black),);
  }
    else{
      return Text("${priceFormat.format(data.smTS)} \$",style: AppStyle.medium(Colors.black),);
    }
  }
}


