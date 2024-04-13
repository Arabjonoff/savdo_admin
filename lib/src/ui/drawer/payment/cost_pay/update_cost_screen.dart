import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/expense/get_expense_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/expense/get_expense_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/income/expense/add_expense_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class UpdateCostScreen extends StatefulWidget {
  final THar data;
  const UpdateCostScreen({super.key, required this.data});

  @override
  State<UpdateCostScreen> createState() => _UpdateCostScreenState();
}

class _UpdateCostScreenState extends State<UpdateCostScreen> {
  final Repository _repository = Repository();
   TextEditingController _controllerExpense = TextEditingController();
   TextEditingController _controllerExpenseId = TextEditingController();
   TextEditingController _controllerSumma = TextEditingController();
   TextEditingController _controllerComment = TextEditingController();
  int paymentType = 0;
  int expenseId = 0;
  bool isLoad = false,summa = false,expenseCode = false;

  @override
  void initState() {
    _controllerExpense = TextEditingController(text: widget.data.idNimaName);
    _controllerExpenseId = TextEditingController(text: widget.data.idNima.toString());
    _controllerComment = TextEditingController(text: widget.data.izoh);
    _controllerSumma = TextEditingController(text: widget.data.sm.toString());
    expenseId = widget.data.idValuta;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: const Text("Харажат киритиш"),
        ),
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text("Нима учун:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerExpense, hintText: 'Нима учун',readOnly: true,
                      suffixIcon: IconButton(onPressed: (){
                        CenterDialog.showProductTypeDialog(context, 'Харажат тури', ExpenseTypeChoseScreen(idSklPr: 0,));
                      },icon: const Icon(Icons.arrow_drop_down_circle_outlined),),),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text("Сумма:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerSumma, hintText: 'Сумма',keyboardType: true,),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text("Изох:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerComment, hintText: 'Изох:'),
                    SizedBox(height: 16.h,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(width: 14.w,),
                          GestureDetector(
                            onTap: (){
                              expenseId = 0;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: expenseId==0?AppColors.green:Colors.grey.withOpacity(0.4)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                              child: Text("Сўм",style: AppStyle.medium(expenseId==0?Colors.white:Colors.black),),
                            ),
                          ),
                          SizedBox(width: 4.w,),
                          GestureDetector(
                            onTap: (){
                              expenseId = 1;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:  expenseId==1?AppColors.green:Colors.grey.withOpacity(0.4)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                              child: Text("Валюта",style: AppStyle.medium(expenseId==1?Colors.white:Colors.black),),
                            ),
                          ),
                          SizedBox(width: 4.w,),
                          GestureDetector(
                            onTap: (){
                              expenseId = 2;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:  expenseId==2?AppColors.green:Colors.grey.withOpacity(0.4)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                              child: Text("Банк",style: AppStyle.medium(expenseId==2?Colors.white:Colors.black),),
                            ),
                          ),
                          SizedBox(width: 4.w,),
                          GestureDetector(
                            onTap: (){
                              expenseId = 3;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:  expenseId==3?AppColors.green:Colors.grey.withOpacity(0.4)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                              child: Text("Пластик",style: AppStyle.medium(expenseId==3?Colors.white:Colors.black),),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h,),
            ButtonWidget(onTap: ()async{
              Map update = {
                "SANA": DateTime.now().toString(),
              "ID_AGENT": CacheService.getIdAgent().toString(),
              "ID_NIMA": int.parse(_controllerExpenseId.text),
              "SM": num.parse(_controllerSumma.text),
              "ID_VALUTA": expenseId,
              "ID_SANA": CacheService.getDateId(),
              "YIL": DateTime.now().year.toString(),
              "OY": DateTime.now().month.toString(),
              "ID_HODIMLAR": CacheService.getIdAgent().toString(),
              "IZOH": _controllerComment.text,
              "ID_CHET": 1,
              "ID_SKL_PR": widget.data.idSklPr,
              "ID_SKL_PER": 0,
              "ID": widget.data.id,
            };
              HttpResult res = await _repository.updateExpense(update);
              if(res.result["status"] == true){
                await getExpenseBloc.getAllExpense(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                if(context.mounted)Navigator.pop(context);
              }
            }, color: AppColors.green, text: "Саклаш"),
            SizedBox(height: 24.h,)
          ],
        ),
      ),
    );
  }
}
