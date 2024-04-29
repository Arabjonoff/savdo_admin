import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/add_income/add_income_product_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class ProductBottomMenuDialog extends StatefulWidget {
  final Map doc;
  final SkladResult data;
  final num price,priceUsd;
  final int priceType;
  const ProductBottomMenuDialog({super.key, required this.data, required this.price, required this.priceUsd, required this.doc, required this.priceType});

  @override
  State<ProductBottomMenuDialog> createState() => _ProductBottomMenuDialogState();
}

class _ProductBottomMenuDialogState extends State<ProductBottomMenuDialog> {
   TextEditingController _controllerOldCount = TextEditingController();
    TextEditingController _controllerCount = TextEditingController(text: '1');
   TextEditingController _controllerPrice = TextEditingController();
   final TextEditingController _controllerTotal = TextEditingController();
   final Repository _repository = Repository();
   int priceType = 0,onTap=0;
   int currency = CacheService.getCurrency();
   @override
   void initState() {
     currency = CacheService.getCurrency();
     priceType = widget.priceType;
     _controllerOldCount = TextEditingController(text: priceFormatUsd.format(widget.data.osoni));
     _controllerCount = TextEditingController(text: '1');
     _controllerPrice = TextEditingController(text: widget.priceUsd == 1 ? priceFormat.format(widget.price * currency).replaceAll(',', '.') : priceFormat.format(widget.price).replaceAll(',', '.'));
     // _controllerPrice = TextEditingController(text: widget.price.toString());
     if(priceType==1){
       if (widget.priceUsd == 0) {
         _controllerPrice.text = priceFormatUsd.format(num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')) / currency);
         _controllerTotal.text = priceFormatUsd.format(num.parse(_controllerCount.text) * num.parse(_controllerPrice.text.replaceAll(RegExp('^0-9'), '')));
       } else {
         _controllerPrice.text = priceFormatUsd.format(widget.price).replaceAll(",", ".");
         _controllerTotal.text = priceFormatUsd.format(num.parse(_controllerCount.text) * widget.price).replaceAll(",", ".");
       }
     }
     else{
       if (widget.priceUsd == 0) {
         _controllerPrice.text = priceFormat.format(widget.price);
         _controllerTotal.text = priceFormat.format(num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')) * num.parse(_controllerCount.text));
       } else {
         _controllerTotal.text = priceFormat.format(num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')) * num.parse(_controllerCount.text));
       }
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
                         Expanded(child: Text("Ўтказма миқдори",style: AppStyle.smallBold(Colors.black),)),
                       ],
                     ),
                   ),
                   Row(
                     children: [
                       /// count the number
                       Expanded(child: TextFieldWidget(
                         controller: _controllerOldCount,
                         hintText: widget.data.osoni.toString(),
                         readOnly: true,
                       )),
                       Expanded(child: TextFieldWidget(
                         controller: _controllerCount,
                         hintText: "1",
                         keyboardType: true,
                         onChanged: (i){
                           try{
                             if(widget.data.osoni < num.parse(_controllerCount.text)){
                               Navigator.pop(context);
                               // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Siz kiritgan son maxsulot sonidan ko'p !",style: AppStyle.medium(AppColor.black),),backgroundColor: AppColor.red,));
                             }
                             else if(i == '0'){
                               Navigator.pop(context);
                               // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Maxsulot sonini 0 qilib kiritish mumkin emas!",textAlign:TextAlign.center,style: AppStyle.medium(AppColor.black),),backgroundColor: AppColor.red,));
                             }
                             else{
                               try {
                                 if (priceType == 0 && widget.priceUsd == 0) {
                                   _controllerTotal.text = priceFormat.format(
                                       num.parse(i) * num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')));
                                 } else if (priceType == 0 && widget.priceUsd == 1) {
                                   _controllerTotal.text = priceFormat.format(
                                       num.parse(i) * num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')));
                                 } else if (priceType == 1 && widget.priceUsd == 1) {
                                   _controllerTotal.text = priceFormatUsd.format(
                                       num.parse(i) * num.parse(_controllerPrice.text));
                                 } else if (priceType == 1 && widget.priceUsd == 0) {
                                   _controllerTotal.text = priceFormatUsd.format(
                                       num.parse(i) * num.parse(_controllerPrice.text));
                                 }
                               } catch (_) {}
                             }
                           }catch(_){}
                         },
                       )),
                     ],
                   ),
                   /// price calculation
                   Padding(
                     padding: EdgeInsets.only(left: 16.0.w,right: 16.w),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Нархи",style: AppStyle.smallBold(Colors.black),),
                         const Tooltip(
                             message: 'Валюта курси 12450 сўм',
                             child: Icon(Icons.more_horiz_rounded))
                       ],
                     ),
                   ),
                   TextFieldWidget(
                     controller: _controllerPrice,
                     hintText: "",
                     suffixText: priceType==1?"\$":"Сўм",
                     keyboardType: true,
                     onChanged: (i){
                       try{
                         if(widget.priceUsd == 1){
                           priceType == 0?_controllerTotal.text = priceFormat.format(num.parse(i.replaceAll(",", "")) * num.parse(_controllerCount.text)):
                           _controllerTotal.text = priceFormatUsd.format(num.parse(i.replaceAll(",", "")) * num.parse(_controllerCount.text));
                         }
                         else{
                           priceType == 0?_controllerTotal.text = priceFormat.format(num.parse(i.replaceAll(",", "")) * num.parse(_controllerCount.text)):
                           _controllerTotal.text = priceFormatUsd.format(num.parse(i) * num.parse(_controllerCount.text));
                         }
                       }catch(_){
                       }
                     },
                   ),
                   SizedBox(height: 8.w,),
                   Row(
                     children: [
                       SizedBox(width: 16.w,),
                       GestureDetector(
                         onTap: (){
                           onTap = 0;
                           if (widget.priceUsd == 0) {
                             _controllerPrice.text = priceFormat.format(widget.price);
                             _controllerTotal.text = priceFormat.format(num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')) * num.parse(_controllerCount.text));
                           } else {
                             _controllerPrice.text = priceFormat.format(num.parse(_controllerPrice.text) * currency);
                             _controllerTotal.text = priceFormat.format(num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')) * num.parse(_controllerCount.text));
                           }
                           setState(() => priceType = 0);
                         },
                         child: Container(
                           padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
                           decoration: BoxDecoration(
                               boxShadow: const [
                                 BoxShadow(
                                     color: Colors.grey,
                                     blurRadius: 2
                                 )
                               ],
                               borderRadius: BorderRadius.circular(10),
                               color: priceType==0?AppColors.green:Colors.white
                           ),
                           child: Text("Сўм",style: AppStyle.mediumBold(priceType==0?AppColors.white:Colors.black),),
                         ),
                       ),
                       SizedBox(width: 8.w,),
                       GestureDetector(
                         onTap: (){
                           onTap+=1;
                           priceType = 1;
                           if (widget.priceUsd == 0) {
                             if(onTap ==1){
                               _controllerPrice.text = priceFormatUsd.format(num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')) / currency);
                               _controllerTotal.text = priceFormatUsd.format(num.parse(_controllerCount.text) * num.parse(_controllerPrice.text.replaceAll(RegExp('^0-9'), '')));
                             }
                           } else {
                             _controllerPrice.text = priceFormatUsd.format(widget.price).replaceAll(",", ".");
                             _controllerTotal.text = priceFormatUsd.format(num.parse(_controllerCount.text) * widget.price).replaceAll(",", ".");
                           }
                           // controllerPrice.text = (num.parse(controllerPrice.text.replaceAll(" ", "")) / CacheService.getCurrency()).toString();
                           setState(() {});
                         },
                         child: Container(
                           padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
                           decoration: BoxDecoration(
                               boxShadow: const [
                                 BoxShadow(
                                     color: Colors.grey,
                                     blurRadius: 2
                                 )
                               ],
                               borderRadius: BorderRadius.circular(10),
                               color: priceType==1?AppColors.green:Colors.white
                           ),
                           child: Text("Валюта",style: AppStyle.mediumBold(priceType==1?AppColors.white:Colors.black),),
                         ),
                       ),
                     ],
                   ),
                   SizedBox(height: 8.w,),
                   Padding(
                     padding: EdgeInsets.only(left: 16.0.w),
                     child: Text("Жами",style: AppStyle.smallBold(Colors.black),),
                   ),
                   TextFieldWidget(controller: _controllerTotal, hintText: "",keyboardType: true,readOnly: true,suffixText: priceType==1?"\$":"Сўм",),
                 ],
               ),
             ),
             ButtonWidget(onTap: ()async{
               CenterDialog.showLoadingDialog(context, "Бироз кутинг");
                Map<String,dynamic> data = {
                  "ID_SKL_PER":widget.doc['NDOC'],
                  "ID_SKL2":widget.data.idSkl2,
                  "NAME": widget.data.name,
                  "ID_TIP": widget.data.idTip,
                  "ID_EDIZ": widget.data.idEdiz,
                  "SONI":_controllerCount.text,
                  "NARHI":widget.data.narhi,
                  "NARHI_S":widget.data.narhiS,
                  "TNARHI":widget.data.narhi,
                  "TNARHI_S":widget.data.narhiS,
                  "SM": num.parse(_controllerCount.text) * widget.data.narhi,
                  "SM_S": num.parse(_controllerCount.text) * widget.data.narhiS,
                  "SNARHI": priceType==0?num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')):0,
                  "SNARHI_S": priceType==1?num.parse(_controllerPrice.text):0,
                  "SSM": priceType == 0 ? num.parse(_controllerTotal.text.replaceAll(RegExp('[^0-9]'), '')) : 0,
                  "SSM_S": priceType == 1 ? num.parse(_controllerTotal.text.replaceAll(",", '')) : 0,
                  "TSM": num.parse(_controllerCount.text) * widget.data.narhi,
                  "TSM_S": num.parse(_controllerCount.text) * widget.data.narhiS,
                  "SNARHI1":widget.data.snarhi1,
                  "SNARHI1_S":widget.data.snarhi1S,
                  "SNARHI2":widget.data.snarhi2,
                  "SNARHI2_S":widget.data.snarhi2S,
                  "SHTR":widget.data.photo
               };
               HttpResult res = await _repository.warehouseTransferItem(data);
               try{
                 if(res.result['status'] == true){
                   Map<String,dynamic> dataIncome = {
                     "ID_SKL_PER":widget.doc['NDOC'],
                     "ID":res.result['id'],
                     "ID_SKL2":widget.data.idSkl2,
                     "NAME": widget.data.name,
                     "ID_TIP": widget.data.idTip,
                     "ID_EDIZ": widget.data.idEdiz,
                     "SONI":_controllerCount.text,
                     "NARHI":widget.data.narhi,
                     "NARHI_S":widget.data.narhiS,
                     "TNARHI":widget.data.narhi,
                     "TNARHI_S":widget.data.narhiS,
                     "SM": num.parse(_controllerCount.text) * widget.data.narhi,
                     "SM_S": num.parse(_controllerCount.text) * widget.data.narhiS,
                     "SNARHI": priceType==0?num.parse(_controllerPrice.text.replaceAll(RegExp('[^0-9]'), '')):0,
                     "SNARHI_S": priceType==1?num.parse(_controllerPrice.text):0,
                     "SSM": priceType == 0 ? num.parse(_controllerTotal.text.replaceAll(RegExp('[^0-9]'), '')) : 0,
                     "SSM_S": priceType == 1 ? num.parse(_controllerTotal.text.replaceAll(",", '')) : 0,
                     "TSM":num.parse(_controllerCount.text) * widget.data.narhi,
                     "TSM_S":num.parse(_controllerCount.text) * widget.data.narhiS,
                     "SNARHI1":widget.data.snarhi1,
                     "SNARHI1_S":widget.data.snarhi1S,
                     "SNARHI2":widget.data.snarhi2,
                     "SNARHI2_S":widget.data.snarhi2S,
                     "SHTR":widget.data.photo
                   };
                   _repository.saveIncomeProductBase(dataIncome);
                   // skladBloc.updateSklad(widget.data, res.result['osoni']);
                   incomeProductBloc.getAllIncomeProduct();
                   if(context.mounted)Navigator.pop(context);
                   if(context.mounted)Navigator.pop(context);
                 }
                 else{
                   if(context.mounted)Navigator.pop(context);
                   if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                 }
               }catch(e){
                 if(context.mounted)Navigator.pop(context);
                 CenterDialog.showErrorDialog(context, e.toString());
               }
             }, color: AppColors.green, text: "Саватга қўшиш"),
             SizedBox(height: 32.h,)
           ],
         ),
       ),
     );
   }
}
