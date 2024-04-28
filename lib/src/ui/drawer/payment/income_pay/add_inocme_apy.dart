import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/payments/income_pay_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/income/documnet_income_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';
class AddIncomePayScreen extends StatefulWidget {
  const AddIncomePayScreen({super.key});

  @override
  State<AddIncomePayScreen> createState() => _AddIncomePayScreenState();
}

class _AddIncomePayScreenState extends State<AddIncomePayScreen> {
  final TextEditingController _controllerClient = TextEditingController();
  final TextEditingController controllerClientIdT = TextEditingController();
  final TextEditingController _controllerClientHodim = TextEditingController();
  final TextEditingController _controllerClientIdAgent = TextEditingController();
  TextEditingController controllerClientUzs = TextEditingController();
  TextEditingController controllerClientUsd = TextEditingController();
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
  @override
  void initState() {
    _initBus();
    idValyuta = 0;
    paymentType = 0;
    controllerSumma = TextEditingController();
    controllerAcceptedSumma = TextEditingController();
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
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
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
                      suffixIcon: IconButton(onPressed: () => CenterDialog.showProductTypeDialog(context, "Харидорлар", const DocumentClientScreen()),icon: const Icon(Icons.perm_contact_cal_outlined),),
                    ),
                    Row(
                      children: [
                        Expanded(child: Padding(
                          padding: EdgeInsets.only(left: 16.0.w),
                          child: Text(
                            "Жами қарзи сўм",
                            style: AppStyle.medium(Colors.red),
                          ),
                        ),),
                        Expanded(child: Padding(
                          padding: EdgeInsets.only(left: 16.0.w),
                          child: Text(
                            "Жами қарзи \$",
                            style: AppStyle.medium(Colors.red),
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
                          controller:controllerClientUzs.text.isEmpty?controllerClientUzs:TextEditingController(text: priceFormat.format(num.parse(controllerClientUzs.text))),
                        ),),
                        Expanded(child: TextFieldWidget(
                          readOnly: true,
                          hintText: "",
                          suffixText: "\$",
                          controller:controllerClientUsd.text.isEmpty?controllerClientUsd:TextEditingController(text: priceFormatUsd.format(num.parse(controllerClientUsd.text))),
                        ),),
                      ],
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
                if(paymentType == 8){
                  CenterDialog.showErrorDialog(context, "Тўлов турини танланг");
                }
                else{
                  CenterDialog.showLoadingDialog(context, "Илтимос кутинг тўлов амалга ошмоқда");
                  Map payment = {
                    "SANA": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    "ID_TOCH": controllerClientIdT.text,
                    "NAME": _controllerClient.text,
                    "SM":controllerSumma.text.replaceAll(RegExp('[^0-9]'), ''),
                    "TP": paymentType,
                    "FOIZ":controllerPercent.text,
                    "SM0":idValyuta ==1?controllerAcceptedSumma.text:controllerAcceptedSumma.text.replaceAll(RegExp('[^0-9]'), ''),
                    "ID_HODIMLAR":_controllerClientHodim.text,
                    "TIP":1,
                    "KURS":int.parse(controllerCurrency.text.replaceAll(RegExp('[^0-9]'), '')),
                    "ID_AGENT":_controllerClientIdAgent.text,
                    "ID_VALUTA":idValyuta,
                    "ID_SANA": CacheService.getDateId(),
                    "IZOH":controllerComment.text,
                    "OY":DateTime.now().month,
                    "YIL":DateTime.now().year,
                    "ID_SKL_RS":0,
                    "TULOVNAME":""};
                  HttpResult res = await repository.addIncomePayment(payment);
                  if(res.result['status'] == true){
                    if(context.mounted)FocusScope.of(context).unfocus();
                    incomePayBloc.getAllIncomePay(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                    _controllerClient.clear();
                    controllerClientUzs.clear();
                    controllerClientUsd.clear();
                    controllerSumma.clear();
                    controllerAcceptedSumma.clear();
                    controllerComment.clear();
                    if(context.mounted)Navigator.pop(context);
                    if(context.mounted)CenterDialog.showSuccessDialog(context);
                  }
                  else{
                    if(context.mounted)Navigator.pop(context);
                    if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                  }
                }
              }, color: AppColors.green,):const SizedBox(),
            SizedBox(
              height: 32.w,
            ),
          ],
        ),
      ),
    );
  }
  void _initBus() {
    RxBus.register(tag: 'clientName').listen((event) {
      _controllerClient.text = event;
    });
    RxBus.register(tag: 'clientId').listen((event) {
      controllerClientIdT.text = event;
    });
    RxBus.register(tag: 'idAgent').listen((event) {
      _controllerClientIdAgent.text = event;
    });
    RxBus.register(tag: 'idHodimlar').listen((event) {
      _controllerClientHodim.text = event;
    });
    RxBus.register(tag: 'clientDebtUsd').listen((event) {
      controllerClientUsd.text = event;
    });
    RxBus.register(tag: 'clientDebtUzs').listen((event) {
      controllerClientUzs.text = event;
    });
  }
}
