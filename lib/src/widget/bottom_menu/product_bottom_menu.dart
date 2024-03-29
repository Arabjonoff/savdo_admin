import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class ProductBottomMenuDialog extends StatefulWidget {
  final SkladResult data;
  final num price,priceUsd;
  const ProductBottomMenuDialog({super.key, required this.data, required this.price, required this.priceUsd});

  @override
  State<ProductBottomMenuDialog> createState() => _ProductBottomMenuDialogState();
}

class _ProductBottomMenuDialogState extends State<ProductBottomMenuDialog> {
   TextEditingController _controllerOldCount = TextEditingController();
   final TextEditingController _controllerCount = TextEditingController(text: '1');
   final TextEditingController _controllerAllPrice = TextEditingController();
   TextEditingController _controllerSales = TextEditingController();
  int paymentType = 0;
  int currency = 12450;
  @override
  void initState() {
    _controllerOldCount = TextEditingController(text: priceFormatUsd.format(widget.data.osoni));
    _controllerSales = TextEditingController(text: widget.priceUsd==0?priceFormat.format(widget.price):priceFormatUsd.format(widget.price));
    if(paymentType == 0 && widget.priceUsd==0){
      _controllerAllPrice.text = priceFormat.format(num.parse(_controllerCount.text)*num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), "")));
    }
    else if(paymentType == 1 && widget.priceUsd==1){
      _controllerAllPrice.text = priceFormatUsd.format(num.parse(_controllerCount.text)*num.parse(_controllerSales.text));
    }
    else if(paymentType == 0 && widget.priceUsd==1){
      _controllerAllPrice.text = priceFormat.format((num.parse(_controllerSales.text)*currency)*num.parse(_controllerCount.text));
    }
    else if(paymentType == 1 && widget.priceUsd==0){
      _controllerAllPrice.text = priceFormatUsd.format((num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), ''))/currency)*num.parse(_controllerCount.text));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300.h,
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300.h,
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                        imageUrl: "https://naqshsoft.site/images/$db/${widget.data.photo}",fit: BoxFit.fitHeight,),
                    ),
                    Positioned(
                      left: 10,
                      top: 20.h,
                        child: CircleAvatar(
                          backgroundColor: AppColors.green.withOpacity(0.4),
                          radius: 25,
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.clear)),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: Text(widget.data.name,style: AppStyle.large(Colors.black),),
              ),
              SizedBox(height: 12.h,),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: Row(
                  children: [
                    Expanded(child: Text("Қолдиқ сони",style: AppStyle.small(Colors.black),)),
                    Expanded(child: Text("Ўтказма сони",style: AppStyle.small(Colors.black),))
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: TextFieldWidget(controller: _controllerOldCount,readOnly: false, hintText: "Қолдиқ сони")),
                  Expanded(child: TextFieldWidget(
                    keyboardType: true,
                    onChanged: (i){
                      if(num.parse(_controllerOldCount.text)<=num.parse(_controllerCount.text)){
                        _controllerCount.text =_controllerOldCount.text;
                        CenterDialog.showErrorDialog(context, "Маҳсулот сони хато киритилди");
                      }
                      else if(paymentType == 0 && widget.priceUsd==0){
                        _controllerAllPrice.text = priceFormat.format(num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), ''))*num.parse(i));
                      }
                      else if(paymentType == 1 && widget.priceUsd==0){
                        _controllerAllPrice.text = priceFormatUsd.format((num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), ''))/currency)*num.parse(i));
                      }
                      else if(paymentType == 1 && widget.priceUsd==1){
                        _controllerAllPrice.text = priceFormatUsd.format(num.parse(i)*num.parse(_controllerSales.text));
                      }
                      else if(paymentType == 0 && widget.priceUsd==1){
                        _controllerAllPrice.text = priceFormat.format((num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), ''))*currency)*num.parse(i));
                      }
                    },
                      controller: _controllerCount, hintText: "Ўтказма сони"))
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(left:16.0.w),
                child: Text("Сотиш нархи",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(
                keyboardType: true,
                onChanged: (i){
                  try{
                    if(_controllerSales.text.isEmpty){
                      _controllerAllPrice.text = '0';
                    }
                    if(paymentType==0&&widget.priceUsd==0){
                      _controllerAllPrice.text = priceFormat.format(num.parse(_controllerCount.text)*num.parse(i.replaceAll(RegExp('[^0-9]'), '')));
                    }
                    else if(paymentType==1&&widget.priceUsd==0){
                      _controllerAllPrice.text = priceFormatUsd.format((num.parse(i)/currency)*num.parse(_controllerCount.text));
                    }
                    else if(paymentType==0&&widget.priceUsd==1){
                      _controllerAllPrice.text = priceFormat.format((num.parse(i)*currency)*num.parse(_controllerCount.text));
                    }
                    else if(paymentType==1&&widget.priceUsd==1){
                      _controllerAllPrice.text = priceFormatUsd.format(num.parse(_controllerCount.text)*num.parse(i));
                    }
                  }catch(_){}
                },
                  controller: _controllerSales, hintText: "Сотиш нархи"),
              Padding(
                padding:  EdgeInsets.only(left:16.0.w,bottom: 8.h),
                child: Text("Валюта тури",style: AppStyle.small(Colors.black),),
              ),
              Row(
                children: [
                  SizedBox(width: 16.w,),
                  GestureDetector(
                    onTap: (){
                      paymentType = 0;
                      if(paymentType == 0 && widget.priceUsd==0){
                        _controllerSales.text = priceFormat.format((num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), '')))*num.parse(_controllerCount.text));
                        _controllerAllPrice.text = priceFormat.format((num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), '')))*num.parse(_controllerCount.text));
                      }
                      else if(paymentType == 0 && widget.priceUsd==1){
                        _controllerSales.text = priceFormat.format((num.parse(_controllerSales.text)*currency)*num.parse(_controllerCount.text));
                        _controllerAllPrice.text = priceFormat.format((num.parse(_controllerSales.text)*currency)*num.parse(_controllerCount.text));
                      }
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: paymentType==0?AppColors.green:Colors.grey
                      ),
                      child: Text("Сўм",style: AppStyle.medium(Colors.white),),
                    ),
                  ),
                  SizedBox(width: 12.w,),
                  GestureDetector(
                    onTap: (){
                      paymentType = 1;
                      if(paymentType == 1 && widget.priceUsd==0){
                        _controllerSales.text = priceFormatUsd.format((num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), ''))/currency)*num.parse(_controllerCount.text));
                        _controllerAllPrice.text = priceFormatUsd.format((num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), ''))/currency)*num.parse(_controllerCount.text));
                      }
                      else if(paymentType == 1 && widget.priceUsd==1){
                        _controllerSales.text = priceFormatUsd.format((num.parse(_controllerSales.text.replaceAll(RegExp('[^0-9]'), ''))*num.parse(_controllerCount.text)));
                        _controllerAllPrice.text = priceFormatUsd.format((num.parse(_controllerSales.text)*num.parse(_controllerCount.text)));
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: paymentType==1?AppColors.green:Colors.grey
                      ),
                      child: Text("Валюта",style: AppStyle.medium(Colors.white),),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(left:16.0.w,top: 8.h),
                child: Text("Жами сумма",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerAllPrice, hintText: "Жами сумма",readOnly: true,),
              SizedBox(height: 42.h,),
              ButtonWidget(onTap: (){}, color: AppColors.green, text: "Сақлаш"),
              SizedBox(height: 24.h,),
            ],
          ),
        ),
      ),
    );
  }
}
