import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/bloc/expense/get_expense_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/expense/get_expense_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/income/expense/add_expense_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';


class IncomeExpenseScreen extends StatefulWidget {
  final dynamic idSklPr;
  const IncomeExpenseScreen({super.key, required this.idSklPr});
  @override
  State<IncomeExpenseScreen> createState() => _IncomeExpenseScreenState();
}
class _IncomeExpenseScreenState extends State<IncomeExpenseScreen> {
  int sklPr = 0;
  @override
  void initState() {
    if(widget.idSklPr.runtimeType == String){
      sklPr = int.parse(widget.idSklPr);
    }else{
      sklPr = widget.idSklPr;
    }
    getExpenseBloc.getAllExpense(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Харажатлар"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<GetExpenseModel>(
                stream: getExpenseBloc.getExpenseStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    double allPriceUzs = 0;
                    double allPriceUsd = 0;
                    var data = snapshot.data!.data[0].tHar;
                    for(int i =0;i<data.length;i++){
                      if(sklPr == data[i].idSklPr){
                        if(data[i].idValuta ==1){
                          allPriceUsd += data[i].sm;
                        }else{
                          allPriceUzs += data[i].sm;
                        }
                      }
                    }
                    CacheService.saveExpenseSummaUzs(allPriceUzs);
                    CacheService.saveExpenseSummaUsd(allPriceUsd);
                    if (data.isEmpty) {
                      return const SizedBox();
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                               if(data[index].idSklPr == sklPr){
                                 return Slidable(
                                   endActionPane: ActionPane(
                                     motion: const ScrollMotion(),
                                     children: [
                                       SlidableAction(
                                         onPressed: (i){
                                           CenterDialog.showDeleteDialog(context, () => (){
                                           });
                                         },
                                         backgroundColor: Colors.red,
                                         label: "Ўчириш",
                                         icon: Icons.delete,)
                                     ],
                                   ),
                                   child: Container(
                                     padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 4.h),
                                     decoration: BoxDecoration(
                                         color: AppColors.white,
                                         border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4)))
                                     ),
                                     width: width,
                                     child: Column(
                                       children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text(data[index].idNimaName,style: AppStyle.medium(AppColors.textBoldLight),),
                                             Text("${priceFormatUsd.format(data[index].sm)}${data[index].idValuta==0?" сўм":data[index].idValuta==1?" \$":data[index].idValuta==2?" банк":" пластик"}",style: AppStyle.mediumBold(AppColors.textBoldLight),),
                                           ],
                                         ),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text("Изоҳи:",style: AppStyle.small(AppColors.textBoldLight),),
                                             Text(data[index].izoh,style: AppStyle.medium(AppColors.textBoldLight),),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 );
                               }
                               return const SizedBox();
                              }),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Жами: ${priceFormatUsd.format(allPriceUzs)} Сўм | ",style: AppStyle.medium(Colors.black),),
                                Text("${priceFormatUsd.format(allPriceUsd)} \$",style: AppStyle.medium(Colors.black),),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  return  Center(child: CircularProgressIndicator(color: AppColors.green,));
                }),
          ),
          ButtonWidget(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx){
              return AddExpenseScreen(idSklPr: sklPr);
            }));
          }, color: AppColors.green, text: "Харажат қўшиш"),
          SizedBox(height: 24.h,),
        ],
      ),
    );
  }
}
