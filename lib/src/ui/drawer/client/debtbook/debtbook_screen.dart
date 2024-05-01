import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/debt_client_bloc.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/client/debtbook/debt_client_serach.dart';
import 'package:savdo_admin/src/ui/drawer/client/debtbook/debtbook_detail.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class DebtBookScreen extends StatefulWidget {
  const DebtBookScreen({super.key});

  @override
  State<DebtBookScreen> createState() => _DebtBookScreenState();
}

class _DebtBookScreenState extends State<DebtBookScreen> {
  num allDebtUsd = 0,allDebtUzs =0;
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  @override
  void initState() {
    clientDebtBloc.getAllClientDebt(dateTime.year,dateTime.month);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return  Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
        elevation: 0,
        title: CupertinoSearchTextField(
          autofocus: false,
          onTap: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const SearchDebtClient(),
                transitionDuration: const Duration(milliseconds: 500),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              ),
            );
          },
          placeholder: "Излаш",
        ),
        actions: [
          // IconButton(onPressed: ()async{
          //   showMonthPicker(
          //       roundedCornersRadius: 25,
          //       headerColor: AppColors.green,
          //       selectedMonthBackgroundColor: AppColors.green.withOpacity(0.7),
          //       context: context,
          //       initialDate: dateTime,
          //       lastDate: DateTime.now()
          //   ).then((date) {
          //     if (date != null) {
          //       setState(() {
          //         dateTime = date;
          //       });
          //        repository.clearClientDebtBase();
          //       clientDebtBloc.getAllClientDebt(dateTime.year,dateTime.month);
          //     }
          //   });
          // }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,)),
          IconButton(onPressed: ()async {}, icon: const Icon(Icons.filter_list_alt,)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await repository.clearClientDebtBase();
        },
        child: StreamBuilder<List<DebtClientModel>>(
          stream: clientDebtBloc.getClientDebtStream,
          builder: (context, snapshot) {
            allDebtUzs =0;
            allDebtUsd =0;
            if(snapshot.hasData){
              var data = snapshot.data!;
              for(int i =0; i<data.length;i++){
                allDebtUsd += data[i].osKS;
                allDebtUzs += data[i].osK;
              }
              return SnappingSheet(
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
                  grabbingHeight: 75,
                  // TODO: Add your grabbing widget here,
                  grabbing: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: AppColors.green,
                    ),
                    child: Text("${priceFormat.format(allDebtUzs)} сўм | ${priceFormatUsd.format(allDebtUsd)} \$",style: AppStyle.smallBold(Colors.white),),
                  ),
                  sheetBelow: SnappingSheetContent(
                    draggable: (details) => true,
                    // TODO: Add your sheet content here
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("data"),
                              Text("data"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx,index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx){
                              return DebtBookDetail(data: data[index], idT: data[index].idToch, name: data[index].name,);
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade300
                                    )
                                ),
                                color: Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)
                                    )
                                  ),
                                  child: Text(data[index].agentName,style: AppStyle.small(Colors.white),),
                                ),
                                SizedBox(height: 8.h,),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green.shade100,
                                      child: Text(data[index].name[0]),
                                    ),
                                    SizedBox(width: 8.w,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                                        Row(
                                          children: [
                                            Text("${priceFormat.format(data[index].osK)} сўм",style: AppStyle.medium(data[index].osK.toString()[0] =='-'?Colors.red:Colors.green),),
                                            Text(" | ",style: AppStyle.medium(Colors.black),),
                                            Text("${priceFormatUsd.format(data[index].osKS)} \$",style: AppStyle.medium(data[index].osKS.toString()[0] =='-'?Colors.red:Colors.green),),
                                          ],
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                SizedBox(height: 12.h,),
                              ],
                            ),
                          ),
                        );
                      })
              );
            }
            return const EmptyWidgetScreen();
          }
        ),
      )
    );
  }
}
