// ignore_for_file: must_be_immutable


import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';

class BaseCardWidget extends StatefulWidget {
  final data;
  final int idPrice;
  final int filterId;
  const BaseCardWidget({super.key, required this.data, required this.idPrice, required this.filterId,});

  @override
  State<BaseCardWidget> createState() => _BaseCardWidgetState();
}

class _BaseCardWidgetState extends State<BaseCardWidget> {
  @override
  void initState() {
    priceFunc();
    super.initState();
  }
  num price = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.data.idTip == widget.filterId) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: MediaQuery.of(context).size.width,
        height: 100.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.card,
            boxShadow:  [
              BoxShadow(
                  blurRadius: 8
              )
            ]
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
              },
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Hero(
                  tag: 'https://naqshsoft.site/images/$db/${widget.data.photo}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: 'https://naqshsoft.site/images/$db/${widget.data.photo}',
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),

                  ),
                ),

              ),
            ),
            SizedBox(width: 16.w,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.w,),
                Text(widget.data.name,style: AppStyle.medium(AppColors.black),maxLines: 2,),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    priceCheck(widget.idPrice),
                    Text("${widget.data.osoni}",style: AppStyle.medium(AppColors.black),),
                  ],
                ),
                SizedBox(height: 8.w,),
              ],
            ))
          ],
        ),
      );
    } else {
      if (widget.filterId==0) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: MediaQuery.of(context).size.width,
          height: 100.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.card,
              boxShadow:  [
                BoxShadow(
                    blurRadius: 8
                )
              ]
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: 'https://naqshsoft.site/images/$db/${widget.data.photo}',
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),

                  ),
                ),
              ),
              SizedBox(width: 16.w,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.w,),
                  Text(widget.data.name,style: AppStyle.medium(AppColors.black),maxLines: 2,),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      priceCheck(widget.idPrice),
                      Text("${widget.data.osoni}",style: AppStyle.medium(AppColors.black),),
                    ],
                  ),
                  SizedBox(height: 8.w,),
                ],
              ))
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    }
  }


  priceFunc(){
    if(widget.idPrice == 0){
      if(widget.data.snarhi != 0){
        price = widget.data.snarhi;
      }
      else{
        price = widget.data.snarhiS;
      }
    }
    else if(widget.idPrice == 1){
      if(widget.data.snarhi1 != 0){
        price = widget.data.snarhi1;

      }
      else{
        price = widget.data.snarhi1S;

      }
    }
    else if(widget.idPrice == 2){
      if(widget.data.snarhi2 != 0){
        price = widget.data.snarhi2;
      }
      else{
        price = widget.data.snarhi2S;
      }
    }
  }

  Widget priceCheck(int idPrice){
    switch(idPrice){
      case 0:
        return widget.data.snarhi == 0?Text("${priceFormatUsd.format(widget.data.snarhiS)} \$",style: AppStyle.medium(AppColors.green),):Text("${priceFormat.format(widget.data.snarhi)} ${('uzs').tr()}",style: AppStyle.medium(AppColors.green),);
      case 1:
        return widget.data.snarhi1 == 0?Text("${priceFormatUsd.format(widget.data.snarhi1S)} \$",style: AppStyle.medium(AppColors.green),):Text("${priceFormat.format(widget.data.snarhi1)} ${('uzs').tr()}",style: AppStyle.medium(AppColors.green),);
      case 2:
        return widget.data.snarhi2 == 0?Text("${priceFormatUsd.format(widget.data.snarhi2S)} \$",style: AppStyle.medium(AppColors.green),):Text("${priceFormat.format(widget.data.snarhi2)} ${('uzs').tr()}",style: AppStyle.medium(AppColors.green),);
      default:
        return const Text("");
    }
  }
}

