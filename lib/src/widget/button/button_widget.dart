// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final String text;
  bool disable;

  ButtonWidget({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (disable) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        width: MediaQuery.of(context).size.width,
        height: 50.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.green.withOpacity(0.4)),
        child: Text(
          text,
          style: AppStyle.large(AppColors.white),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          width: MediaQuery.of(context).size.width,
          height: 50.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color),
          child: Text(
            text,
            style: AppStyle.large(AppColors.white),
          ),
        ),
      );
    }
  }
}
