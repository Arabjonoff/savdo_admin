import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/expense/get_expense_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/expense/expense_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/income/expense/add_expense_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class AddCostScreen extends StatefulWidget {
  const AddCostScreen({super.key});

  @override
  State<AddCostScreen> createState() => _AddCostScreenState();
}

class _AddCostScreenState extends State<AddCostScreen> {
  final Repository _repository = Repository();
  final TextEditingController _controllerExpense = TextEditingController();
  final TextEditingController _controllerExpenseId = TextEditingController();
  final TextEditingController _controllerSumma = TextEditingController();
  final TextEditingController _controllerComment = TextEditingController();
  int paymentType = 0;
  int expenseId = 0;
  bool isLoad = false,summa = false,expenseCode = false;
  @override
  void initState() {
    _initBus();
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
              AddExpenseModel item = AddExpenseModel(
                  sana: DateTime.now().toString(),
                  idAgent: CacheService.getIdAgent().toString(),
                  idNima: int.parse(_controllerExpenseId.text),
                  sm: num.parse(_controllerSumma.text),
                  idValuta: expenseId,
                  idSana: CacheService.getDateId(),
                  yil: DateTime.now().year.toString(),
                  oy: DateTime.now().month.toString(),
                  idHodimlar: CacheService.getIdAgent().toString(),
                  izoh: _controllerComment.text,
                  idChet: 1,
                  idSklPr: 0,
                  idSklPer: 0);
              HttpResult res = await _repository.addExpense(item);
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
  void _initBus() {
    RxBus.register(tag: "expenseName").listen((event) {
      _controllerExpense.text = event;
    });
    RxBus.register(tag: "expenseId").listen((event) {
      _controllerExpenseId.text = event;
    });
  }
}
