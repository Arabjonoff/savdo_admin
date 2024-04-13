import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/model/warehousetransfer/warehouse_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class WareHouseDetailScreen extends StatelessWidget {
  final List<SklPerTov> data;
  const WareHouseDetailScreen({super.key, required this.data});

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
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border:  Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade400
                    )
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.r,
                      height: 80.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>  Icon(Icons.error_outline,size: 23.h,),
                          imageUrl: 'https://naqshsoft.site/images/$db/${data[index].shtr}',fit: BoxFit.fitHeight,)),
                    ),
                    SizedBox(width: 8.w,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].name,style: AppStyle.mediumBold(AppColors.black),maxLines: 1,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('сони',style: AppStyle.small(AppColors.black),),
                            Text(priceFormatUsd.format(data[index].soni),style: AppStyle.medium(AppColors.black),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('нархи',style: AppStyle.small(AppColors.black),),
                            data[index].snarhiS !=0?Text("${priceFormatUsd.format(data[index].snarhiS)} \$",style: AppStyle.medium(AppColors.black),):
                            Text("${priceFormat.format(data[index].snarhi)} сўм",style: AppStyle.medium(AppColors.black),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('жами',style: AppStyle.small(AppColors.black),),
                            data[index].ssmS != 0?Text("${priceFormatUsd.format(data[index].ssmS)} \$",style: AppStyle.mediumBold(AppColors.black),):
                            Text("${priceFormat.format(data[index].ssm)} сўм",style: AppStyle.mediumBold(AppColors.black),),
                          ],
                        ),
                      ],
                    ))
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
