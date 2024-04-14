import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/model/balance/balance_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';


class BalanceScreen extends StatelessWidget {
  final BalanceModel data;
  const BalanceScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              width: 100.w,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Мол етказиб берувчилар",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Омбордаги махсулот",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Харидорлар карзи",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Ойлик хисобланди",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Кассадаги пул",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Кунлик савдо суммаси",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Кунлик савдодаги фарк",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Кунлик савдодаги фарк %",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Кунлик урта чек (13)",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: Text("Фарк",style: AppStyle.medium(Colors.black),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${priceFormat.format(data.sklSm)} сўм",style: AppStyle.mediumBold(Colors.black),),
                        Text("${priceFormatUsd.format(data.sklSmS)} \$",style: AppStyle.mediumBold(Colors.black),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
