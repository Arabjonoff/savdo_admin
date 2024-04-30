import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as dt;
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/bloc/client/debt_client_bloc.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/model/client/debt_detail_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:shimmer/shimmer.dart';

class DebtBookDetail extends StatefulWidget {
  final DebtClientModel data;
  final String idT;
  final String name;
  const DebtBookDetail({super.key, required this.data, required this.idT, required this.name});
  @override
  State<DebtBookDetail> createState() => _DebtBookDetailState();
}

class _DebtBookDetailState extends State<DebtBookDetail> {
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  @override
  void initState() {
    super.initState();
    clientDebtBloc.getClientDebtDetail(year,month, widget.idT,1);
  }
  @override
  void dispose() {
    clientDebtBloc.getClientDebtDetail(DateTime.now().year,DateTime.now().month, widget.idT,1);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.name),
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
                // _repository.clearSkladBase();
                clientDebtBloc.getClientDebtDetail(dateTime.year,dateTime.month, widget.idT,1);
              }
            });
          }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: widget.idT,
              child: GestureDetector(
                onTap: (){
                  // CenterDialog.clientShowDetailDialog(context,widget.data);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.green.shade300,
                  child: Text(
                    widget.name[0].toUpperCase(),
                    style: AppStyle.smallBold(Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(height: 14.h,),
          // Row(
          //   children: [
          //     SizedBox(width: 16.h,),
          //     GestureDetector(
          //       onTap: (){
          //         month--;
          //         setState(() {
          //
          //         });
          //         if(month >= 1){
          //           // clientDetailBloc.getAllDetail(year,month, widget.idT);
          //         }
          //         else{
          //           month = 1;
          //           setState(() {
          //
          //           });
          //         }
          //       },
          //       child: Container(
          //         alignment: Alignment.center,
          //         width: 50,
          //         height: 50,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                   blurRadius: 5,
          //                   color: Colors.grey.shade400
          //               )
          //             ]
          //         ),
          //         child:  const Icon(Icons.arrow_back_ios,color: Colors.black,),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         alignment: Alignment.center,
          //         margin: const EdgeInsets.symmetric(horizontal: 16),
          //         height: 50,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color:Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                   blurRadius: 5,
          //                   color: Colors.grey.shade400
          //               )
          //             ]
          //         ),
          //         child: Text(monthFormat(month),style: AppStyle.large(Colors.black),),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: (){
          //         month++;
          //         setState(() {
          //
          //         });
          //         if(month <= 12){
          //           // clientDetailBloc.getAllDetail(year,month, widget.idT);
          //         }
          //         else{
          //           month = 12;
          //         }
          //       },
          //       child: Container(
          //         alignment: Alignment.center,
          //         width: 50,
          //         height: 50,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                   blurRadius: 5,
          //                   color: Colors.grey.shade400
          //               )
          //             ]
          //         ),
          //         child:  Icon(Icons.arrow_forward_ios,color: Colors.black,),
          //       ),
          //     ),
          //     SizedBox(width: 16.h,),
          //   ],
          // ),
          Expanded(
            child: StreamBuilder<List<DebtClientDetail>>(
                stream: clientDebtBloc.getClientDebtDetailStream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    var data = snapshot.data!;
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (ctx,index){
                                bool isSameDate = true;
                                final String dateString = data[index].sana.toString();
                                final DateTime date = DateTime.parse(dateString);
                                if(index == 0){
                                  isSameDate = false;
                                }
                                else{
                                  final String prevDateString = data[index - 1].sana.toString();
                                  final DateTime prevDate = DateTime.parse(prevDateString);
                                  isSameDate = date.isSameDate(prevDate);
                                }
                                if(index == 0 || !(isSameDate)){
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.white
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(dateFormat(date.formatDate()),style: AppStyle.small(Colors.black),),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          if(data[index].idOper ==1){
                                            // BottomDialog.showScreenDialog(context,Skl2DetailScreen(idT: widget.idT, startDate: DateFormat('yyyy-MM-dd').format(data[index].sana), endDate: DateFormat('yyyy-MM-dd').format(data[index].sana), id: data[index].idToch0, idTouch: data[index].idToch0, name: data[index].name,));
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8.h),
                                          margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black.withOpacity(0.2),
                                                    blurRadius: 10,
                                                    blurStyle: BlurStyle.normal
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${data[index].name}:",style: AppStyle.medium(Colors.black),),
                                              checkIdOper(data[index]),
                                              Container(
                                                margin: const EdgeInsets.symmetric(vertical: 4),
                                                width: MediaQuery.of(context).size.width,
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              data[index].idOper == 0?const SizedBox(): Text("qoldiq",style: AppStyle.medium(AppColors.red),),
                                              data[index].idOper == 0?const SizedBox():Row(
                                                children: [
                                                  Text("${priceFormat.format(data[index].oKarzi)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
                                                  Text("${priceFormatUsd.format(data[index].oKarziS)} \$",style: AppStyle.medium(Colors.black),),
                                                ],
                                              )
                                              // Text(DateFormat('yyyy-MM-dd').format(data[index].sana),style: AppStyle.small(AppColor.black),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                else {
                                  return GestureDetector(
                                    onTap: (){
                                      if(data[index].idOper ==1 ){
                                        // BottomDialog.showScreenDialog(context,Skl2DetailScreen(idT: widget.idT, startDate: DateFormat('yyyy-MM-dd').format(data[index].sana), endDate: DateFormat('yyyy-MM-dd').format(data[index].sana), id: data[index].idToch0, idTouch: data[index].idToch0, name: data[index].name,));
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8.h),
                                      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 10,
                                                blurStyle: BlurStyle.normal
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${data[index].name}:",style: AppStyle.medium(Colors.black),),
                                          checkIdOper(data[index]),
                                          Container(
                                            margin: const EdgeInsets.symmetric(vertical: 4),
                                            width: MediaQuery.of(context).size.width,
                                            height: 1,
                                            color: Colors.grey,
                                          ),
                                          data[index].idOper == 0?const SizedBox(): Text("qoldiq",style: AppStyle.medium(AppColors.red),),
                                          data[index].idOper == 0?const SizedBox():Row(
                                            children: [
                                              Text("${priceFormat.format(data[index].oKarzi)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
                                              Text("${priceFormatUsd.format(data[index].oKarziS)} \$",style: AppStyle.medium(Colors.black),),
                                            ],
                                          ),
                                          // Text(DateFormat('yyyy-MM-dd').format(data[index].sana),style: AppStyle.small(AppColors.black),)
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration:  BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    color: Colors.grey.shade400
                                )
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${priceFormat.format(widget.data.osK)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
                                  Text("${priceFormatUsd.format(widget.data.osKS)} \$",style: AppStyle.medium(Colors.black),),
                                ],
                              ),
                              // TextButton(onPressed: (){
                              //   // CenterDialog.showDebtPrinterDialog(context,data,widget.name);
                              // }, child: Text("check",style: AppStyle.medium(AppColors.green),).tr()),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Shimmer.fromColors(
                    baseColor: Colors.white12,
                    highlightColor: Colors.grey.shade400,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (ctx,index){
                          return Container(
                            height: 120,
                            margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey
                            ),
                            width: MediaQuery.of(context).size.width,
                          );
                        }),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
  Widget checkIdOper(DebtClientDetail data,){
    switch(data.idOper){
      case 0:
        return Row(
          children: [
            Text("${priceFormat.format(data.oKarzi)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
            Text("${priceFormatUsd.format(data.oKarziS)} \$",style: AppStyle.medium(Colors.black),),
          ],
        );
      case 1:
        return Row(
          children: [
            Text("${priceFormat.format(data.tovar)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
            Text("${priceFormatUsd.format(data.tovarS)} \$",style: AppStyle.medium(Colors.black),),
          ],
        );
      case 2:
        return Row(
          children: [
            Text("${priceFormat.format(data.tulov)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
            Text("${priceFormatUsd.format(data.tulovS)} \$",style: AppStyle.medium(Colors.black),),
          ],
        );
      case 3:
        return Row(
          children: [
            Text("${priceFormat.format(data.kaytdi)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
            Text("${priceFormatUsd.format(data.kaytdiS)} \$",style: AppStyle.medium(Colors.black),),
          ],
        );
      case 4:
        return Row(
          children: [
            Text("${priceFormat.format(data.skidka)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
            Text("${priceFormatUsd.format(data.skidkaS)} \$",style: AppStyle.medium(Colors.black),),
          ],
        );
      case 5:
        return Row(
          children: [
            Text("${priceFormat.format(data.tovarP)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
            Text("${priceFormatUsd.format(data.tovarPS)} \$",style: AppStyle.medium(Colors.black),),
          ],
        );
      case 6:
        return Row(
          children: [
            Text("${priceFormat.format(data.tulovP)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
            Text("${priceFormatUsd.format(data.tulovPS)} \$",style: AppStyle.medium(Colors.black),),
          ],
        );
      case 10:
        return Row(
          children: [
            Text("${priceFormat.format(data.oKarzi)} ${('uzs')} | ",style: AppStyle.medium(Colors.black),),
            Text("${priceFormatUsd.format(data.oKarziS)} \$",style: AppStyle.medium(Colors.black),),
          ],
        );

      default:
        return const Text('');
    }
  }
  String dateFormat(String data){
    String dateTime = '';
    switch(data.substring(3,5)){
      case '01':
        return dateTime += '${data.substring(0,2)}-Yanvar';
      case '02':
        return dateTime += '${data.substring(0,2)}-Fevral';
      case '03':
        return dateTime += '${data.substring(0,2)}-Mart';
      case '04':
        return dateTime += '${data.substring(0,2)}-Aprel';
      case '05':
        return dateTime += '${data.substring(0,2)}-May';
      case '06':
        return dateTime += '${data.substring(0,2)}-Iyun';
      case '07':
        return dateTime += '${data.substring(0,2)}-Iyul';
      case '08':
        return dateTime += '${data.substring(0,2)}-Avgust';
      case '09':
        return dateTime += '${data.substring(0,2)}-Sentyabr';
      case '10':
        return dateTime += '${data.substring(0,2)}-Oktyabr';
      case '11':
        return dateTime += '${data.substring(0,2)}-Noyabr';
      case '12':
        return dateTime += '${data.substring(0,2)}-Dekabr';
      default:
        return '';
    }
  }
  String monthFormat(int data){
    String dateTime = '';
    switch(data){
      case 01:
        return dateTime += 'Yanvar';
      case 02:
        return dateTime += 'Fevral';
      case 03:
        return dateTime += 'Mart';
      case 04:
        return dateTime += 'Aprel';
      case 05:
        return dateTime += 'May';
      case 06:
        return dateTime += 'Iyun';
      case 07:
        return dateTime += 'Iyul';
      case 08:
        return dateTime += 'Avgust';
      case 09:
        return dateTime += 'Sentyabr';
      case 10:
        return dateTime += 'Oktyabr';
      case 11:
        return dateTime += 'Noyabr';
      case 12:
        return dateTime += 'Dekabr';
      default:
        return '';
    }
  }
}
const String dateFormatter = 'dd-MM';

extension DateHelper on DateTime {

  String formatDate() {
    final formatter = dt.DateFormat(dateFormatter,);
    return formatter.format(this);
  }
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
