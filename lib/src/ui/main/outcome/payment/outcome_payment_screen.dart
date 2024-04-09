import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/ui/main/outcome/payment/outcome_pay_list.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class OutcomePaymentScreen extends StatefulWidget {
  final dynamic ndocId;
  final dynamic summaUzs;
  final dynamic summaUsd;
  const OutcomePaymentScreen({super.key, required this.ndocId, required this.summaUzs, required this.summaUsd});

  @override
  State<OutcomePaymentScreen> createState() => _OutcomePaymentScreenState();
}

class _OutcomePaymentScreenState extends State<OutcomePaymentScreen> with TickerProviderStateMixin{
  // TextEditingController _controllerClientIdT = TextEditingController();
  final TextEditingController _controllerClient = TextEditingController(text: CacheService.getClientName());
  TextEditingController controllerTotalUzs = TextEditingController();
  TextEditingController controllerTotalUsd = TextEditingController();
  TextEditingController controllerComment = TextEditingController();
  TextEditingController controllerAcceptedSumma = TextEditingController();
  TextEditingController controllerSumma = TextEditingController();
  TextEditingController controllerCurrency = TextEditingController(text: priceFormat.format(CacheService.getCurrency()));
  TextEditingController controllerPercent = TextEditingController(text: '100');
  bool isSearching = false;
  int idValyuta = 0;
  int paymentType = 0;
  num acceptedSumma = 0;
  num percent = 0;
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    idValyuta = 0;
    paymentType = 0;
    controllerSumma = TextEditingController(text: widget.summaUzs.toString().replaceAll(RegExp('[^0-9]'), ""));
    controllerAcceptedSumma = TextEditingController(text: widget.summaUzs.toString().replaceAll(RegExp('[^0-9]'), ""));
    controllerCurrency.addListener(() {
      if(idValyuta ==0&&paymentType==0){
        controllerAcceptedSumma.text =controllerSumma.text;
        controllerAcceptedSumma = TextEditingController(text:controllerAcceptedSumma.text);
      }
      else if(idValyuta==0&&paymentType==1){
        acceptedSumma = num.parse(controllerSumma.text) * int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
        controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
      }
      else if(idValyuta==1&&paymentType==1){
        controllerAcceptedSumma.text =controllerSumma.text;
        controllerAcceptedSumma = TextEditingController(text:controllerAcceptedSumma.text );
      }
      else if(idValyuta ==1 &&paymentType==0){
        acceptedSumma =num.parse(controllerSumma.text) / int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
        controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
      }
      setState(() {
      });
    });
    controllerPercent.addListener(() {
      try{
        percent = num.parse(controllerAcceptedSumma.text) / 100 *int.parse(controllerPercent.text);
        controllerAcceptedSumma = TextEditingController(text: percent.toString());
      }catch(_){
      }
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    controllerTotalUzs = TextEditingController(text: widget.summaUzs);
    controllerTotalUsd = TextEditingController(text: widget.summaUsd);
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            title:  Text(_controllerClient.text,style: AppStyle.large(Colors.black),),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: TabBar(
                labelColor: AppColors.green,
                indicatorColor: AppColors.green,
                controller: _tabController,
                tabs: const [
                 Tab(
                   child:Text("Тўловл"),
                 ),
                 Tab(
                   child:Text("Тўловлар рўйхати",),
                 ),
                ],
              )
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 16.w,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      idValyuta = 0;
                                      if(paymentType==0 || paymentType==2 ||paymentType==3){
                                        controllerAcceptedSumma.text = controllerSumma.text;
                                        acceptedSumma = num.parse(controllerAcceptedSumma.text) /100 *int.parse(controllerPercent.text);
                                        controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(0) );
                                      }
                                      else if(paymentType==1){
                                        acceptedSumma = num.parse(controllerSumma.text) * int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                        acceptedSumma = acceptedSumma /100 *int.parse(controllerPercent.text);
                                        controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                      }
                                    });
                                  },
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    duration: const Duration(milliseconds: 400),
                                    padding: EdgeInsets.symmetric(vertical: 12.w),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: idValyuta==0?AppColors.green:Colors.white),
                                    child: Text(
                                      "Сўм қарзи",
                                      style: AppStyle.medium(idValyuta==0?Colors.white:AppColors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    idValyuta = 1;
                                    if(paymentType==1){
                                      // controllerAcceptedSumma.text =controllerSumma.text.replaceAll(RegExp('[^0-9]'), "");
                                      // acceptedSumma = num.parse(controllerAcceptedSumma.text)/100 *int.parse(controllerPercent.text);
                                      // controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                      acceptedSumma = num.parse(controllerSumma.text)/100*int.parse(controllerPercent.text);
                                      controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                    }
                                    else if(paymentType ==0 || paymentType ==2 ||paymentType ==3){
                                      acceptedSumma =num.parse(controllerSumma.text) / int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                      acceptedSumma = acceptedSumma / 100 * int.parse(controllerPercent.text);
                                      controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                    }
                                    setState(() {
                                    });
                                  },
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    duration: const Duration(milliseconds: 400),
                                    padding: EdgeInsets.symmetric(vertical: 12.w),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: idValyuta==1?AppColors.green:Colors.white),
                                    child: Text(
                                      "Валюта қарзи",
                                      style: AppStyle.medium(idValyuta==1?Colors.white:AppColors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h,),
                          Row(
                            children: [
                              Expanded(child: Padding(
                                padding: EdgeInsets.only(left: 16.0.w),
                                child: Text(
                                  "Жами сўм",
                                  style: AppStyle.medium(Colors.black),
                                ),
                              ),),
                              Expanded(child: Padding(
                                padding: EdgeInsets.only(left: 16.0.w),
                                child: Text(
                                  "Жами валюта",
                                  style: AppStyle.medium(Colors.black),
                                ),
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: TextFieldWidget(
                                readOnly: true,
                                hintText: "",
                                suffixText: "сўм",
                                controller: controllerTotalUzs,
                              ),),
                              Expanded(child: TextFieldWidget(
                                readOnly: true,
                                hintText: "",
                                suffixText: "\$",
                                controller:controllerTotalUsd,
                              ),),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0.w),
                            child: Text(
                              "Харидор исми",
                              style: AppStyle.medium(Colors.black),
                            ),
                          ),
                          TextFieldWidget(
                            hintText: "",
                            controller: _controllerClient,
                            readOnly: true,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.0.w),
                                  child: Text(
                                    "Валюта курси",
                                    style: AppStyle.medium(Colors.black),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.0.w),
                                  child: Text(
                                    "Фоизи",
                                    style: AppStyle.medium(Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFieldWidget(
                                    maxLength: 6,
                                    hintText: "",
                                    controller: controllerCurrency),
                              ),
                              Expanded(
                                child: TextFieldWidget(
                                    onChanged: (i){
                                      paymentType = 8;
                                    },
                                    onSubmitted: (i){
                                      paymentType = 8;
                                      controllerAcceptedSumma.text = (num.parse(controllerSumma.text)/100*int.parse(i)).toStringAsFixed(2);
                                    },
                                    hintText: "",
                                    maxLength: 3,
                                    controller: controllerPercent),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0.w),
                            child: Text(
                              "Сумма",
                              style: AppStyle.medium(Colors.black),
                            ),
                          ),
                          TextFieldWidget(
                              keyboardType: true,
                              onChanged: (i){
                                if(idValyuta==0&&paymentType==0){
                                  controllerAcceptedSumma.text =i.replaceAll(RegExp('[^0-9]'), "");
                                  controllerAcceptedSumma = TextEditingController(text:i );
                                }
                                else if(idValyuta ==0&&paymentType==1){
                                  acceptedSumma = num.parse(i) * int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                  controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(0) );
                                }
                                else if(idValyuta==1&&paymentType==1){
                                  controllerAcceptedSumma.text =i.replaceAll(RegExp('[^0-9]'), "");
                                  controllerAcceptedSumma = TextEditingController(text:i );
                                }
                                else if(idValyuta==1&&paymentType==0){
                                  acceptedSumma =int.parse(i.replaceAll(RegExp('[^0-9]'), "")) / int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                  controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                }

                                setState(() {});
                              },
                              hintText: "",
                              controller: controllerSumma),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0.w, bottom: 10.h),
                            child: Text(
                              "Тўлов тури",
                              style: AppStyle.medium(Colors.black),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 16.w,),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: paymentType ==0?AppColors.green:Colors.white
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                                    child: Text("Сўм",style: AppStyle.medium(paymentType==0?Colors.white:AppColors.black),),
                                  ),
                                  onTap: (){
                                    paymentType =0;
                                    if(idValyuta==0){
                                      controllerAcceptedSumma.text = controllerSumma.text;
                                      acceptedSumma = num.parse(controllerAcceptedSumma.text)/100*int.parse(controllerPercent.text);
                                      controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(0) );
                                    }
                                    else{
                                      try{
                                        acceptedSumma = num.parse(controllerSumma.text) / int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                        acceptedSumma = acceptedSumma /100 *int.parse(controllerPercent.text);
                                        controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                      }catch(_){

                                      }
                                    }
                                    setState(() {

                                    });
                                  },
                                ),
                                SizedBox(width: 8.w,),
                                GestureDetector(
                                  onTap: (){
                                    paymentType =1;
                                    if(idValyuta == 0){
                                      try{
                                        acceptedSumma = num.parse(controllerSumma.text) * int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                        acceptedSumma = acceptedSumma / 100 * int.parse(controllerPercent.text);
                                        controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(0) );
                                      }catch(_){
                                      }
                                    }
                                    else if(idValyuta ==1){
                                      acceptedSumma = num.parse(controllerSumma.text)/100*int.parse(controllerPercent.text);
                                      controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: paymentType ==1?AppColors.green:Colors.white
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                                    child: Text("Валюта",style: AppStyle.medium(paymentType==1?Colors.white:AppColors.black),),
                                  ),
                                ),
                                SizedBox(width: 8.w,),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: paymentType ==2?AppColors.green:Colors.white
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                                    child: Text("Пластик",style: AppStyle.medium(paymentType==2?Colors.white:AppColors.black),),
                                  ),
                                  onTap: (){
                                    paymentType =2;
                                    if(idValyuta==0){
                                      controllerAcceptedSumma.text = controllerSumma.text;
                                      acceptedSumma = num.parse(controllerAcceptedSumma.text)/100*int.parse(controllerPercent.text);
                                      controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(0) );
                                    }
                                    else if(idValyuta==1){
                                      acceptedSumma = num.parse(controllerSumma.text) / int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                      acceptedSumma = acceptedSumma /100 *int.parse(controllerPercent.text);
                                      controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                    }
                                    else{
                                      try{
                                        acceptedSumma = num.parse(controllerSumma.text) / int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                        acceptedSumma = acceptedSumma /100 *int.parse(controllerPercent.text);
                                        controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toString() );
                                      }catch(_){

                                      }
                                    }
                                    setState(() {

                                    });
                                  },
                                ),
                                SizedBox(width: 8.w,),
                                GestureDetector(
                                  onTap: (){
                                    paymentType =3;
                                    if(idValyuta==0){
                                      controllerAcceptedSumma.text = controllerSumma.text;
                                      acceptedSumma = num.parse(controllerAcceptedSumma.text)/100*int.parse(controllerPercent.text);
                                      controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(0) );
                                    }
                                    else if(idValyuta==1){
                                      acceptedSumma = num.parse(controllerSumma.text) / int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                      acceptedSumma = acceptedSumma /100 *int.parse(controllerPercent.text);
                                      controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toStringAsFixed(2) );
                                    }
                                    else{
                                      try{
                                        acceptedSumma = num.parse(controllerSumma.text) / int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), ""));
                                        acceptedSumma = acceptedSumma /100 *int.parse(controllerPercent.text);
                                        controllerAcceptedSumma = TextEditingController(text: acceptedSumma.toString() );
                                      }catch(_){

                                      }
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: paymentType ==3?AppColors.green:Colors.white
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                                    child: Text("Банк",style: AppStyle.medium(paymentType==3?Colors.white:AppColors.black),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0.w, top: 16.h),
                            child: Text(
                              "Тўлов қабул қилинди",
                              style: AppStyle.medium(Colors.black),
                            ),
                          ),
                          TextFieldWidget(
                            readOnly: true,
                            hintText: "",
                            controller: TextEditingController(text: controllerAcceptedSumma.text),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.0.w, top: 10),
                            child: Text(
                              "Изоҳи",
                              style: AppStyle.medium(Colors.black),
                            ),
                          ),
                          TextFieldWidget(
                            hintText: "",
                            controller: controllerComment,
                            onChanged: (i){
                              controllerComment.text = i.replaceAll("'", "`");
                            },
                          ),
                          SizedBox(
                            height: 32.h,
                          )
                        ],
                      ),
                    ),
                  ),
                  controllerSumma.text.isNotEmpty? ButtonWidget(
                    text: "Тўловни сақлаш",
                    onTap: () async {
                      CenterDialog.showLoadingDialog(context, "Илтимос кутинг тўлов амалга ошмоқда");
                      Map payment = {
                        "SANA": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        "ID_TOCH": CacheService.getClientIdT(),
                        "NAME": CacheService.getClientName(),
                        "SM":controllerSumma.text.replaceAll(RegExp('[^0-9]'), ''),
                        "TP": paymentType,
                        "FOIZ":controllerPercent.text,
                        "SM0":idValyuta ==1?controllerAcceptedSumma.text:controllerAcceptedSumma.text.replaceAll(RegExp('[^0-9]'), ''),
                        "ID_HODIMLAR":CacheService.getClientHodim(),
                        "TIP":1,
                        "KURS":int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), '')),
                        "ID_AGENT":CacheService.getIdAgent(),
                        "ID_VALUTA":idValyuta,
                        "ID_SANA": CacheService.getDateId(),
                        "IZOH":controllerComment.text,
                        "OY":DateTime.now().month,
                        "YIL":DateTime.now().year,
                        "ID_SKL_RS":widget.ndocId,
                        "TULOVNAME":""};
                      HttpResult res = await repository.addIncomePayment(payment);
                      if(res.result['status'] == true){
                        if(context.mounted)Navigator.pop(context);
                        if(context.mounted)Navigator.pop(context);
                      }
                      else{
                        if(context.mounted)Navigator.pop(context);
                        if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                      }
                    }, color: AppColors.green,):const SizedBox(),
                  SizedBox(
                    height: 32.w,
                  ),
                ],
              ),
              OutcomePayListScreen(idSklRs: widget.ndocId,)
            ],
          )
        ),
      ),
    );
  }
}
