import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/add_income/add_income_product_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/utils.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class UpdateIncomeItem extends StatefulWidget {
  final dynamic id;
  final IncomeAddModel data;
  const UpdateIncomeItem({super.key, required this.id, required this.data});

  @override
  State<UpdateIncomeItem> createState() => _UpdateIncomeItemState();
}

class _UpdateIncomeItemState extends State<UpdateIncomeItem> {
  ScrollController? _scrollController;
  final Repository _repository = Repository();
  String db = CacheService.getDb();
  bool lastStatus = true;
  final TextEditingController _controllerCount = TextEditingController();
  final TextEditingController _controllerIncomePriceUzs = TextEditingController(text: '0');
  final TextEditingController _controllerIncomePriceUsd = TextEditingController(text: '0');
  final TextEditingController _controllerSalePriceUzs1 = TextEditingController(text: '0');
  final TextEditingController _controllerSalePriceUsd1 = TextEditingController(text: '0');
  final TextEditingController _controllerSalePriceUsd2 = TextEditingController(text: '0');
  final TextEditingController _controllerSalePriceUzs2 = TextEditingController(text: '0');
  final TextEditingController _controllerSalePriceUzs3 = TextEditingController(text: '0');
  final TextEditingController _controllerSalePriceUsd3 = TextEditingController(text: '0');
  final TextEditingController _controllerIncomePriceTotal = TextEditingController(text: '0');
  final TextEditingController _controllerIncomePrice1Total = TextEditingController(text: '0');
  final TextEditingController _controllerIncomePrice2Total = TextEditingController(text: '0');
  final TextEditingController _controllerIncomePrice3Total = TextEditingController(text: '0');
  @override
  void initState() {
    if(widget.data.narhi==0){
      _controllerIncomePriceTotal.text = (widget.data.narhiS*widget.data.soni).toString();
    }else{
      _controllerIncomePriceTotal.text = (widget.data.narhi*widget.data.soni).toString();
    }
    if(widget.data.snarhi==0){
      _controllerIncomePrice1Total.text = (widget.data.snarhiS*widget.data.soni).toString();
    }else{
      _controllerIncomePrice1Total.text = (widget.data.snarhi*widget.data.soni).toString();
    }
    if(widget.data.snarhi1==0){
      _controllerIncomePrice2Total.text = (widget.data.snarhi1S*widget.data.soni).toString();
    }else{
      _controllerIncomePrice2Total.text = (widget.data.snarhi1*widget.data.soni).toString();
    }
    if(widget.data.snarhi2==0){
      _controllerIncomePrice3Total.text = (widget.data.snarhi2S*widget.data.soni).toString();
    }else{
      _controllerIncomePrice3Total.text = (widget.data.snarhi2*widget.data.soni).toString();
    }
    _controllerCount.text = priceFormatUsd.format(widget.data.soni);
    _controllerIncomePriceUzs.text = priceFormat.format(widget.data.narhi);
    _controllerIncomePriceUsd.text = priceFormatUsd.format(widget.data.narhiS);
    _controllerSalePriceUzs1.text = priceFormat.format(widget.data.snarhi);
    _controllerSalePriceUsd1.text = priceFormatUsd.format(widget.data.snarhiS);
    _controllerSalePriceUsd2.text = priceFormatUsd.format(widget.data.snarhi1S);
    _controllerSalePriceUzs2.text = priceFormat.format(widget.data.snarhi1);
    _controllerSalePriceUzs3.text = priceFormat.format(widget.data.snarhi2);
    _controllerSalePriceUsd3.text = priceFormatUsd.format(widget.data.snarhi2S);
    db = CacheService.getDb();
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data.name,style: AppStyle.large(Colors.black),),
        ),
          backgroundColor: AppColors.background,
          body: Padding(
            padding: EdgeInsets.only(left: 12.w,right: 12.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Кирим миқдори:",style: AppStyle.medium(Colors.black),),
                  Container(
                    margin: EdgeInsets.only(top: 8.h),
                    padding: EdgeInsets.only(left: 8.w),
                    width: MediaQuery.of(context).size.width,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: AppStyle.medium(Colors.black),
                      controller: _controllerCount,
                      onChanged: (i){
                        if(_controllerIncomePriceUzs.text == '0'||_controllerIncomePriceUzs.text.isEmpty){
                          _controllerIncomePriceTotal.text = (num.parse(i)*num.parse(_controllerIncomePriceUsd.text.replaceAll(',', '.'))).toString();
                        }
                        else{
                          _controllerIncomePriceTotal.text = (num.parse(i)*num.parse(_controllerIncomePriceUzs.text.replaceAll(RegExp("[^0-9]"), ''))).toString();
                        }
                        if(_controllerSalePriceUzs1.text == '0'||_controllerSalePriceUzs1.text.isEmpty){
                          _controllerIncomePrice1Total.text = (num.parse(i)*num.parse(_controllerSalePriceUsd1.text.replaceAll(',', '.'))).toString();
                        }
                        else{
                          _controllerIncomePrice1Total.text = (num.parse(i)*num.parse(_controllerSalePriceUzs1.text.replaceAll(RegExp("[^0-9]"), ''))).toString();
                        }
                        if(_controllerSalePriceUzs2.text == '0'||_controllerSalePriceUzs2.text.isEmpty){
                          _controllerIncomePrice2Total.text = (num.parse(i)*num.parse(_controllerSalePriceUsd2.text.replaceAll(',', '.'))).toString();
                        }
                        else{
                          _controllerIncomePrice2Total.text = (num.parse(i)*num.parse(_controllerSalePriceUzs2.text.replaceAll(RegExp("[^0-9]"), ''))).toString();
                        }
                        if(_controllerSalePriceUzs3.text == '0'||_controllerSalePriceUzs3.text.isEmpty){
                          _controllerIncomePrice3Total.text = (num.parse(i)*num.parse(_controllerSalePriceUsd3.text.replaceAll(',', '.'))).toString();
                        }
                        else{
                          _controllerIncomePrice3Total.text = (num.parse(i)*num.parse(_controllerSalePriceUzs3.text.replaceAll(RegExp("[^0-9]"), ''))).toString();
                        }
                          setState(() {});
                      },
                      decoration:  InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5.h),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  /// Income Price Widget UI
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Text("Кирим нархи белгилаш:",style: AppStyle.medium(Colors.black),),
                  ),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    child: const DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                  ),
                  SizedBox(height: 12.h,),
                  Row(
                    children: [
                      Expanded(child: Text("Нархи сўм:",style: AppStyle.small(Colors.black),)),
                      Expanded(child: Text("Нархи \$:",style: AppStyle.small(Colors.black),)),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            controller: _controllerIncomePriceUzs,
                            onChanged: (i){
                              try{
                                _controllerIncomePriceUsd.text ='0';
                                _controllerIncomePriceTotal.text = (num.parse(_controllerCount.text.replaceAll(",", '.'))*num.parse(_controllerIncomePriceUzs.text.replaceAll(RegExp('[^0-9]'), ''))).toString();
                                setState(() {});
                              }catch(_){}
                            },
                            decoration:  InputDecoration(
                              suffixText: "сум",
                              contentPadding: EdgeInsets.only(top: 5.h),
                              isDense: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            controller: _controllerIncomePriceUsd,
                            onChanged: (i){
                              try{
                                _controllerIncomePriceUzs.text = '0';
                                _controllerIncomePriceTotal.text = (num.parse(_controllerCount.text.replaceAll(",", '.'))*num.parse(_controllerIncomePriceUsd.text.replaceAll(",", "."))).toString();
                                setState(() {
                                });
                              }catch(_){

                              }
                            },
                            decoration: InputDecoration(
                              suffixText: "\$",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 5.h),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Жами сумма:",style: AppStyle.mediumBold(Colors.black),),
                      Text(priceFormat.format(num.parse(_controllerIncomePriceTotal.text)),style: AppStyle.mediumBold(AppColors.green),),
                    ],
                  ),
                  SizedBox(height: 12.h,),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    child: const DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                  ),
                  /// Sales Price 1  Widget UI
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Text("Сотиш нархи 1:",style: AppStyle.medium(Colors.black),),
                  ),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    child: const DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                  ),
                  SizedBox(height: 12.h,),
                  Row(
                    children: [
                      Expanded(child: Text("Сотиш Нархи (1) сўм:",style: AppStyle.small(Colors.black),)),
                      Expanded(child: Text("Сотиш Нархи (1) \$:",style: AppStyle.small(Colors.black),)),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            controller: _controllerSalePriceUzs1,
                            onChanged: (i){
                              _controllerSalePriceUsd1.text='0';
                              try{
                                _controllerIncomePrice1Total.text = (num.parse(_controllerSalePriceUzs1.text.replaceAll(RegExp('[^0-9]'), '')) * num.parse(_controllerCount.text.replaceAll(",", '.'))).toString();
                                setState(() {});
                              }catch(_){}
                            },
                            decoration:  InputDecoration(
                              suffixText: "сум",
                              contentPadding: EdgeInsets.only(top: 5.h),
                              isDense: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            controller: _controllerSalePriceUsd1,
                            onChanged: (i){
                              _controllerSalePriceUzs1.text = '0';
                              try{
                                _controllerIncomePrice1Total.text = (num.parse(_controllerSalePriceUsd1.text.replaceAll(",", ".")) * num.parse(_controllerCount.text.replaceAll(",", '.'))).toString();
                                setState(() {});
                              }catch(_){}
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixText: "\$",
                              contentPadding: EdgeInsets.only(top: 5.h),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Жами сумма:",style: AppStyle.mediumBold(Colors.black),),
                      Text(priceFormat.format(num.parse(_controllerIncomePrice1Total.text)),style: AppStyle.mediumBold(AppColors.green),),
                    ],
                  ),
                  /// Sales Price 2  Widget UI
                  SizedBox(height: 12.h,),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    child: const DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Text("Сотиш нархи 2:",style: AppStyle.medium(Colors.black),),
                  ),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    child: const DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                  ),
                  SizedBox(height: 12.h,),
                  Row(
                    children: [
                      Expanded(child: Text("Сотиш Нархи (2) сўм:",style: AppStyle.small(Colors.black),)),
                      Expanded(child: Text("Сотиш Нархи (2) \$:",style: AppStyle.small(Colors.black),)),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            controller: _controllerSalePriceUzs2,
                            onChanged: (i){
                              _controllerSalePriceUsd2.text = '0';
                              try{
                                _controllerIncomePrice2Total.text = (num.parse(_controllerSalePriceUzs2.text.replaceAll(RegExp('[^0-9]'), '')) * num.parse(_controllerCount.text.replaceAll(",", '.'))).toString();
                                setState(() {});
                              }catch(_){}
                            },
                            decoration:  InputDecoration(
                              suffixText: "сум",
                              contentPadding: EdgeInsets.only(top: 5.h),
                              isDense: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            controller: _controllerSalePriceUsd2,
                            onChanged: (i){
                              _controllerSalePriceUzs2.text = '0';
                              try{
                                _controllerIncomePrice2Total.text = (num.parse(_controllerSalePriceUsd2.text.replaceAll(",", ".")) * num.parse(_controllerCount.text.replaceAll(",", '.'))).toString();
                                setState(() {});
                              }catch(_){}
                            },
                            decoration: InputDecoration(
                              suffixText: "\$",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 5.h),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Жами сумма:",style: AppStyle.mediumBold(Colors.black),),
                      Text(priceFormat.format(num.parse(_controllerIncomePrice2Total.text)),style: AppStyle.mediumBold(AppColors.green),),
                    ],
                  ),
                  /// Sales Price 3  Widget UI
                  SizedBox(height: 12.h,),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    child: const DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.h),
                    child: Text("Сотиш нархи 3:",style: AppStyle.medium(Colors.black),),
                  ),
                  SizedBox(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    child: const DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                  ),
                  SizedBox(height: 12.h,),
                  Row(
                    children: [
                      Expanded(child: Text("Сотиш Нархи (3) сўм:",style: AppStyle.small(Colors.black),)),
                      Expanded(child: Text("Сотиш Нархи (3) \$:",style: AppStyle.small(Colors.black),)),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            controller: _controllerSalePriceUzs3,
                            onChanged: (i){
                              _controllerSalePriceUsd3.text = '0';
                              try{
                                _controllerIncomePrice3Total.text = (num.parse(_controllerSalePriceUzs3.text.replaceAll(RegExp('[^0-9]'), '')) * num.parse(_controllerCount.text.replaceAll(",", '.'))).toString();
                                setState(() {});
                              }catch(_){}
                            },
                            decoration:  InputDecoration(
                              suffixText: "сум",
                              contentPadding: EdgeInsets.only(top: 5.h),
                              isDense: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w),
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            scrollPadding: EdgeInsets.zero,
                            controller: _controllerSalePriceUsd3,
                            onChanged: (i){
                              _controllerSalePriceUzs3.text = '0';
                              try{
                                _controllerIncomePrice3Total.text = (num.parse(_controllerSalePriceUsd3.text.replaceAll(",", ".")) * num.parse(_controllerCount.text.replaceAll(",", '.'))).toString();
                                setState(() {});
                              }catch(_){}
                            },
                            decoration: InputDecoration(
                              suffixText: "\$",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 5.h),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Жами сумма:",style: AppStyle.mediumBold(Colors.black),),
                      Text(priceFormat.format(num.parse(_controllerIncomePrice3Total.text)),style: AppStyle.mediumBold(AppColors.green),),
                    ],
                  ),
                  SizedBox(height: 12.h,),
                  ButtonWidget(onTap: () async {
                    CenterDialog.showLoadingDialog(context, "Бир оз кутинг");
                    IncomeAddModel addIncome = IncomeAddModel(
                      id: widget.data.id,
                      price: _controllerIncomePriceUzs.text=='0'?num.parse(_controllerIncomePriceUsd.text.replaceAll(',', '.')):num.parse(_controllerIncomePriceUzs.text.replaceAll(RegExp('[^0-9]'), '')),
                      idSklPr: widget.id,
                      idSkl2: widget.data.idSkl2,
                      name: widget.data.name,
                      idTip: widget.data.idTip,
                      idFirma: widget.data.idFirma,
                      idEdiz: widget.data.idEdiz,
                      soni: num.parse(_controllerCount.text.replaceAll(",", '.')),
                      narhi: num.parse(_controllerIncomePriceUzs.text.replaceAll(RegExp('[^0-9]'), '')),
                      narhiS: num.parse(_controllerIncomePriceUsd.text.replaceAll(",", ".")),
                      sm: _controllerIncomePriceUzs.text!='0'?num.parse(_controllerIncomePriceTotal.text):0,
                      smS: _controllerIncomePriceUsd.text !="0"?num.parse(_controllerIncomePriceTotal.text):0,
                      snarhi: num.parse(_controllerSalePriceUzs1.text.replaceAll(RegExp('[^0-9]'), '')),
                      snarhiS: num.parse(_controllerSalePriceUsd1.text.replaceAll(",", ".")),
                      snarhi1: num.parse(_controllerSalePriceUzs2.text.replaceAll(RegExp('[^0-9]'), '')),
                      snarhi1S: num.parse(_controllerSalePriceUsd2.text.replaceAll(",", ".")),
                      snarhi2: num.parse(_controllerSalePriceUzs3.text.replaceAll(RegExp('[^0-9]'), '')),
                      snarhi2S: num.parse(_controllerSalePriceUsd3.text.replaceAll(",", ".")),
                      tnarhi:  num.parse(_controllerIncomePriceUzs.text.replaceAll(RegExp('[^0-9]'), '')),
                      tnarhiS: num.parse(_controllerIncomePriceUsd.text.replaceAll(",", ".")),
                      tsm: _controllerIncomePriceUzs.text!='0'?num.parse(_controllerIncomePriceTotal.text):0,
                      tsmS: _controllerIncomePriceUsd.text !="0"?num.parse(_controllerIncomePriceTotal.text):0,
                      shtr: '',
                    );
                    HttpResult res = await _repository.updateIncomeSklPr(addIncome);
                    if(res.result['status'] == true){
                      IncomeAddModel addIncomeBase = IncomeAddModel(
                        id: widget.data.id,
                        price: _controllerIncomePriceUzs.text=='0'?num.parse(_controllerIncomePriceUsd.text.replaceAll(',', '.')):num.parse(_controllerIncomePriceUzs.text.replaceAll(RegExp('[^0-9]'), '')),
                        idSklPr: widget.id,
                        idSkl2: widget.data.id,
                        name: widget.data.name,
                        idTip: widget.data.idTip,
                        idFirma: widget.data.idFirma,
                        idEdiz: widget.data.idEdiz,
                        soni: num.parse(_controllerCount.text.replaceAll(",", '.')),
                        narhi: num.parse(_controllerIncomePriceUzs.text.replaceAll(RegExp('[^0-9]'), '')),
                        narhiS: num.parse(_controllerIncomePriceUsd.text.replaceAll(",", ".")),
                        sm: _controllerIncomePriceUzs.text!='0'?num.parse(_controllerIncomePriceTotal.text):0,
                        smS: _controllerIncomePriceUsd.text !="0"?num.parse(_controllerIncomePriceTotal.text):0,
                        snarhi: num.parse(_controllerSalePriceUzs1.text.replaceAll(RegExp('[^0-9]'), '')),
                        snarhiS: num.parse(_controllerSalePriceUsd1.text.replaceAll(",", ".")),
                        snarhi1: num.parse(_controllerSalePriceUzs2.text.replaceAll(RegExp('[^0-9]'), '')),
                        snarhi1S: num.parse(_controllerSalePriceUsd2.text.replaceAll(",", ".")),
                        snarhi2: num.parse(_controllerSalePriceUzs3.text.replaceAll(RegExp('[^0-9]'), '')),
                        snarhi2S: num.parse(_controllerSalePriceUsd3.text.replaceAll(",", ".")),
                        tnarhi:  num.parse(_controllerIncomePriceUzs.text.replaceAll(RegExp('[^0-9]'), '')),
                        tnarhiS: num.parse(_controllerIncomePriceUsd.text.replaceAll(",", ".")),
                        tsm: _controllerIncomePriceUzs.text!='0'?num.parse(_controllerIncomePriceTotal.text):0,
                        tsmS: _controllerIncomePriceUsd.text !="0"?num.parse(_controllerIncomePriceTotal.text):0,
                        shtr: '',
                      );
                      _repository.updateIncomeProductBase(addIncomeBase);
                      incomeProductBloc.getAllIncomeProduct();
                      if(context.mounted)Navigator.pop(context);
                      if(context.mounted)Navigator.pop(context);
                    }
                  }, color: AppColors.green, text: "Янгилаш"),
                  SizedBox(height: 24.h,),
                ],
              ),
            ),
          ),
      ),
    );
  }
  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController!.hasClients &&
        _scrollController!.offset > (230.h - kToolbarHeight);
  }
}
