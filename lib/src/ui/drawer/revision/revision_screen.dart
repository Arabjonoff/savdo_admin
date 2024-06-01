import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/revision/revision_bloc.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/revision/revision_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/revision/revision_list.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

import '../../../utils/cache.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  int wareHouseId = 1;
  String wareHouseName = '';
  final Repository _repository = Repository();
  DateTime dateTime = DateTime.now();
  @override
  void initState() {
    wareHouseName = CacheService.getWareHouseName();
    wareHouseId = CacheService.getWareHouseId();
    revisionBloc.getAllRevision(dateTime.year,dateTime.month,wareHouseId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text("Ревизия"),
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
                                      revisionBloc.getAllRevision(dateTime.year, dateTime.month, wareHouseId);
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
                revisionBloc.getAllRevision(dateTime.year, dateTime.month, wareHouseId);
              }
            });
          }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,))
        ],
      ),
      body: StreamBuilder<List<RevisionResult>>(
        stream: revisionBloc.getRevisionStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
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
              grabbingHeight: 65.spMax,
              grabbing: GestureDetector(
                onTap: ()async{
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return RevisionListScreen();
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                    color: AppColors.green,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  ),
                  child: Text("Янги киритиш",style: AppStyle.large(Colors.white),),
                ),
              ),
              sheetBelow: SnappingSheetContent(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,),),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx,index){
                return GestureDetector(
                  onTap: (){
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
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                        //   decoration: BoxDecoration(
                        //       color: AppColors.green,
                        //       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                        //   ),
                        //   child: Text(data[index].agentName,style: AppStyle.smallBold(Colors.white),),
                        // ),
                        SizedBox(height: 4.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data[index].agentName,style: AppStyle.mediumBold(Colors.black),),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: data[index].pr==1?Colors.red:AppColors.green
                                ),
                                child: Text("№: ${data[index].ndoc}",style: AppStyle.medium(Colors.white),)),
                          ],
                        ),
                        Text(data[index].izoh,style: AppStyle.small(Colors.grey),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Жами:",style: AppStyle.medium(Colors.black),),
                            Text(priceFormat.format(data[index].sm),style: AppStyle.medium(Colors.black),),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Вақти',style: AppStyle.small(Colors.black),),
                            Text(data[index].vaqt.toString().substring(10,19),style: AppStyle.small(Colors.black),),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                      ],
                    ),
                  ),
                );
              }
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
