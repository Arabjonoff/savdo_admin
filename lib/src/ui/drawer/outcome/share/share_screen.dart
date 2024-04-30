import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/utils.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatefulWidget {
  final OutcomeResult data;
  const ShareScreen({super.key, required this.data,});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }
  num priceAll = 0;
  String images = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("check".tr()),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8.r),
          margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 10.h),
          width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
                    child: RepaintBoundary(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text("№: ${widget.data.ndoc}",style: AppStyle.mediumBold(Colors.black),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("home.date".tr(),style: AppStyle.smallBold(Colors.black),),
                              Text(DateFormat('yyyy-MM-dd | kk:mm:ss').format(widget.data.vaqt),style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("home.client".tr(),style: AppStyle.smallBold(Colors.black),),
                              Text("${widget.data.idT} - ${widget.data.name}",style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("home.phone".tr(),style: AppStyle.smallBold(Colors.black),),
                              Text(widget.data.clientPhone,style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("home.address".tr(),style: AppStyle.smallBold(Colors.black),),
                              Text(widget.data.clientTarget,style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("home.target".tr(),style: AppStyle.smallBold(Colors.black),),
                              Text(widget.data.clientAddress,style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Agent",style: AppStyle.smallBold(Colors.black),),
                              Text(widget.data.idAgentName,style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("home.storage".tr(),style: AppStyle.smallBold(Colors.black),),
                              Text(widget.data.sklName,style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text("home.product".tr(),style: AppStyle.mediumBold(Colors.black),),
                          ),
                          /// Header
                          createTable(widget.data.sklRsTov),
                          Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            border: const TableBorder(
                                verticalInside: BorderSide(width: 1,color: Colors.grey, style: BorderStyle.solid)
                            ),
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 0.5),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text("home.total".tr(),style: AppStyle.smallBold(Colors.black),textAlign: TextAlign.center,),
                                  ),
                                  Text("${priceFormat.format(widget.data.sm)} ${"uzs".tr()}",style: AppStyle.smallBold(Colors.black),textAlign: TextAlign.center,),
                                  Text("${priceFormatUsd.format(widget.data.smS)} \$",style: AppStyle.smallBold(Colors.black),textAlign: TextAlign.center,),
                                ],),
                            ],
                          ),
                          /// Footer
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text("home.payment".tr(),style: AppStyle.mediumBold(AppColors.green),),
                          ),
                          Table(
                            border: const TableBorder(
                                verticalInside: BorderSide(width: 1,color: Colors.grey, style: BorderStyle.solid)
                            ),
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey,width: 0.5),
                                ),
                                children: [
                                  Text("tolovsom".tr(),style: AppStyle.small(Colors.black),),
                                  Text("${priceFormat.format(widget.data.tlNaqd)} ${"uzs".tr()}",style: AppStyle.smallBold(AppColors.green),textAlign: TextAlign.end,),
                                ],),
                              TableRow(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey,width: 0.5)
                                ),
                                children: [
                                  Text("tolovvalyuta".tr(),style: AppStyle.small(Colors.black),),
                                  Text("${priceFormat.format(widget.data.tlVal)} \$",style: AppStyle.smallBold(AppColors.green),textAlign: TextAlign.end),
                                ],),
                              TableRow(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey,width: 0.5)
                                ),
                                children: [
                                  Text("tolovbank".tr(),style: AppStyle.small(Colors.black),),
                                  Text("${priceFormat.format(widget.data.tlBank)} ${"uzs".tr()}",style: AppStyle.smallBold(AppColors.green),textAlign: TextAlign.end),
                                ],),
                              TableRow(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey,width: 0.5)
                                ),
                                children: [
                                  Text("tolovplastik".tr(),style: AppStyle.small(Colors.black),),
                                  Text("${priceFormat.format(widget.data.tlKarta)} ${"uzs".tr()}",style: AppStyle.smallBold(AppColors.green),textAlign: TextAlign.end),
                                ],),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await screenshotController.capture(delay: const Duration(milliseconds: 10)).then((Uint8List? image) async {
            if (image != null) {
              final directory = await getApplicationDocumentsDirectory();
              final imagePath = await File('${directory.path}/image.png').create();
              await imagePath.writeAsBytes(image);
              /// Share Plugin
              await Share.shareFiles([imagePath.path]);
            }
          });
        },
        backgroundColor: AppColors.green,
        child: const Icon(Icons.upload,color: Colors.white,),
      ),
    );
  }
  Widget createTable(List<SklRsTov> data,) {
    List<TableRow> rows = [
      TableRow(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 0.5)
          ),
          children: [
            Text('№',style: AppStyle.smallBold(Colors.black),),
            Text("name".tr(),style: AppStyle.smallBold(Colors.black),textAlign: TextAlign.center,),
            Text('s/n',style: AppStyle.smallBold(Colors.black),textAlign: TextAlign.center),
            Text("home.price".tr(),textAlign: TextAlign.center,style: AppStyle.smallBold(Colors.black)),
            Text("home.summa".tr(),style: AppStyle.smallBold(Colors.black),textAlign: TextAlign.center,),
          ])
    ];
    for (int i = 0; i < data.length; i++) {
      rows.add(TableRow(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey,width: 0.5)
        ),
          children: [
        Text("${i+1}",textAlign: TextAlign.center,),
        Text(data[i].name,style: AppStyle.small(Colors.black)),
        Text(data[i].soni.toString(),style: AppStyle.small(Colors.black),textAlign: TextAlign.center),
        data[i].snarhi ==0?Text("${priceFormatUsd.format(data[i].snarhiS)} \$",textAlign: TextAlign.center,style: AppStyle.small(Colors.black)):Text("${priceFormat.format(data[i].snarhi)} ${"uzs".tr()}",textAlign: TextAlign.center,style: AppStyle.small(Colors.black)),
        data[i].ssm==0?Text("${priceFormatUsd.format(data[i].ssmS)} \$",style: AppStyle.small(Colors.black),textAlign: TextAlign.center,):Text("${priceFormat.format(data[i].ssm)} ${"uzs".tr()}",style: AppStyle.small(Colors.black),textAlign: TextAlign.center,),
      ]));
    }
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths:  {
          0: const FlexColumnWidth(0.3),
          1: FlexColumnWidth(1.59.spMax),
          2: FlexColumnWidth(0.4.w),
        },
        border: const TableBorder(
            verticalInside: BorderSide(width: 0.5,color: Colors.grey, style: BorderStyle.solid)
        ),
        children: rows);
  }
}
