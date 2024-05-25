// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLength;
  bool enabled,keyboardType,readOnly,textAlign,autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? suffixText;
  final Widget? suffixIcon,prefixIcon;
  TextFieldWidget({super.key, required this.controller,required this.hintText,this.enabled = true,this.keyboardType = false, this.onChanged, this.onSubmitted, this.suffixText,this.readOnly=false, this.suffixIcon, this.prefixIcon,this.textAlign=false, this.maxLength,this.autofocus =false});

  @override
  Widget build(BuildContext context) {
    // ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 14.w,vertical: 8.h),
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      decoration: BoxDecoration(
          border: Border.all(color: enabled?Colors.transparent:Colors.grey.shade600),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.card
      ),
      child: TextField(
        textAlign: textAlign?TextAlign.center:TextAlign.left,
        readOnly: readOnly,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        enabled: enabled,
        autofocus: autofocus,
        controller: controller,
        maxLength: maxLength,
        keyboardType: keyboardType?const TextInputType.numberWithOptions(decimal: true,):TextInputType.text,
        decoration: InputDecoration(
          counterText: '',
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            suffixText: suffixText??"",
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
            )
        ),
      ),
    );
  }
}
