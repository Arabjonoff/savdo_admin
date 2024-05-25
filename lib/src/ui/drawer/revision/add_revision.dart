import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class AddRevisionScreen extends StatefulWidget {
  final num price;
  final  int priceUsd;
  final dynamic data,ndocId;
  const AddRevisionScreen({super.key, required this.price, required this.priceUsd, this.data, this.ndocId});

  @override
  State<AddRevisionScreen> createState() => _AddRevisionScreenState();
}

class _AddRevisionScreenState extends State<AddRevisionScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250.h,
                    color: Colors.white,
                    child: Hero(
                      tag: widget.data.id.toString(),
                      child: CachedNetworkImage(
                        imageUrl: 'https://naqshsoft.site/images/$db/${widget.data.photo}',
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>  const Icon(Icons.image_not_supported_outlined,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w,top: 16.w),
                    child: Text(widget.data.name,style: AppStyle.mediumBold(Colors.black),),
                  ),
                  SizedBox(height: 12.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Row(
                      children: [
                        Expanded(child: Text("Қолдиқ",style: AppStyle.smallBold(Colors.black),)),
                        Expanded(child: Text("Миқдори",style: AppStyle.smallBold(Colors.black),)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      /// count the number
                      Expanded(child: TextFieldWidget(
                        hintText: "1",
                        keyboardType: true,
                        controller: TextEditingController(),
                      )),
                      /// price calculation
                      Expanded(child: TextFieldWidget(
                        controller: TextEditingController(),
                        hintText: "",
                      )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Text("Валюта курс",style: AppStyle.smallBold(Colors.black),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/2),
                    child: TextFieldWidget(controller: TextEditingController(), hintText: "",keyboardType: true,readOnly: true,suffixText: "Сўм",),
                  ),
                  SizedBox(height: 8.w,),
                  Row(
                    children: [
                      SizedBox(width: 16.w,),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w,),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Text("Жами",style: AppStyle.smallBold(Colors.black),),
                  ),
                ],
              ),
            ),
            ButtonWidget(onTap: ()async{
              CenterDialog.showLoadingDialog(context, "Бироз кутинг");
            }, color: AppColors.green, text: "Саватга қўшиш"),
            SizedBox(height: 32.h,)
          ],
        ),
      ),
    );
  }
}
