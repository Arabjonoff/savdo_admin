import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/model/income/income_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/utils.dart';

import '../../../theme/icons/app_fonts.dart';

class IncomeDetailScreen extends StatelessWidget {
  final List<SklPrTovResult> data;
  const IncomeDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            width: 100.w,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5)
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx,index){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 4.h),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey
                            )
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Миқдори:',style: AppStyle.small(Colors.grey),),
                            Text(priceFormatUsd.format(data[index].soni),style: AppStyle.smallBold(Colors.black),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Нархи:',style: AppStyle.small(Colors.grey),),
                            data[index].narhi!=0?Text("${priceFormat.format(data[index].narhi)} сўм",style: AppStyle.smallBold(Colors.black),):Text("${priceFormatUsd.format(data[index].narhiS)} \$",style: AppStyle.smallBold(Colors.black),),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8,bottom: 2),
                          width: MediaQuery.of(context).size.width,
                          child: DashedRect(
                            gap: 8.w,
                            strokeWidth: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child: Text('Сотиш нархи 1',style: AppStyle.small(AppColors.green),)),
                            Expanded(child: Text('Сотиш нархи 2',style: AppStyle.small(AppColors.green),)),
                            Expanded(child: Text('Сотиш нархи 3',style: AppStyle.small(AppColors.green),)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text(data[index].snarhi != 0?"${priceFormat.format(data[index].snarhi)} сўм":"${priceFormatUsd.format(data[index].snarhiS)} \$",style: AppStyle.small(AppColors.green),)),
                            Expanded(child: Text(data[index].snarhi1 != 0?"${priceFormat.format(data[index].snarhi1)} сўм":"${priceFormatUsd.format(data[index].snarhi1S)} \$",style: AppStyle.small(AppColors.green),)),
                            Expanded(child: Text(data[index].snarhi2 != 0?"${priceFormat.format(data[index].snarhi2)} сўм":"${priceFormatUsd.format(data[index].snarhi2S)} \$",style: AppStyle.small(AppColors.green),)),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
