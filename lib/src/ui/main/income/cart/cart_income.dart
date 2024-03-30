import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/add_income/add_income_product_bloc.dart';
import 'package:savdo_admin/src/bloc/income/income_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/income/expense/income_expense_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class CartIncomeScreen extends StatefulWidget {
  final dynamic idSklPr;

  const CartIncomeScreen({super.key, required this.idSklPr});
  @override
  State<CartIncomeScreen> createState() => _CartIncomeScreenState();
}

class _CartIncomeScreenState extends State<CartIncomeScreen> {
  final Repository _repository = Repository();

  @override
  void initState() {
    incomeProductBloc.getAllIncomeProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<List<IncomeAddModel>>(
        stream: incomeProductBloc.getIncomeProductStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            num countUzs = 0,summa = 0,countUsd = 0;
            var data = snapshot.data!;
            for (int i = 0; i < data.length; i++) {
               if(data[i].narhi !=0){
                 countUzs += data[i].soni;
                 // print(countUzs);
               }
               if(data[i].narhi ==0){
                 countUsd += data[i].soni;
                 // print(countUsd);
               }
              summa += data[i].sm;
            }
            return Scaffold(
                backgroundColor: AppColors.background,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (ctx) {
                                    return IncomeExpenseScreen(
                                      idSklPr: widget.idSklPr,
                                    );
                                  }));
                                },
                                child: Text(
                                  "Харажат қўшиш",
                                  textAlign: TextAlign.center,
                                  style: AppStyle.small(Colors.black),
                                ))),
                        Expanded(
                            child: TextButton(
                                onPressed: () async {
                                  incomeProductBloc.costsAmount(countUzs,countUsd);
                                  // _repository.clearIncomeProductBase();
                                },
                                child: Text("Tаннархи cони бўйича",
                                    textAlign: TextAlign.center,
                                    style: AppStyle.small(Colors.black)))),
                        Expanded(
                            child: TextButton(
                                onPressed: () {
                                   incomeProductBloc.costsPrice(countUzs,summa,countUsd);
                                   Future.delayed(const Duration(milliseconds: 200)).then((value) =>  incomeProductBloc.costsPrice(countUzs,summa,countUsd));
                                },
                                child: Text("Tаннархи Нархи бўйича",
                                    textAlign: TextAlign.center,
                                    style: AppStyle.small(Colors.black)))),
                      ],
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                      onPressed: (i) async {
                                        CenterDialog.showDeleteDialog(context,()async{
                                          HttpResult res  = await _repository.deleteIncomeSklPr(data[index].id, data[index].idSklPr, data[index].idSkl2);
                                          if(res.result['status'] == true){
                                            await _repository.deleteIncomeProduct(data[index]);
                                            await incomeProductBloc.getAllIncomeProduct();
                                            if(context.mounted)Navigator.pop(context);
                                          }
                                        });
                                      },
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                width: width,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.4))),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].name,
                                      style: AppStyle.mediumBold(Colors.black),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       "Миқдори",
                                    //       style: AppStyle.small(Colors.black),
                                    //     ),
                                    //     Text(
                                    //       priceFormatUsd.format(data[index].soni),
                                    //       style: AppStyle.small(Colors.black),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Жами",
                                          style: AppStyle.small(Colors.black),
                                        ),
                                        Text(
                                          data[index].narhi != 0?
                                          "${priceFormatUsd.format(data[index].soni)} x ${priceFormatUsd.format(data[index].narhi)} = ${priceFormatUsd.format(data[index].sm)} сўм":
                                          "${priceFormatUsd.format(data[index].soni)} x ${priceFormatUsd.format(data[index].narhiS)} = ${priceFormatUsd.format(data[index].smS)} \$",
                                          style: AppStyle.small(AppColors.green),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Таннархи сўм",
                                          style: AppStyle.small(Colors.black),
                                        ),
                                        Text(
                                          "${priceFormat.format(data[index].tnarhi)} сўм",
                                          style: AppStyle.small(Colors.black),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Таннархи \$",
                                          style: AppStyle.small(Colors.black),
                                        ),
                                        Text(
                                          "${priceFormatUsd.format(data[index].tnarhiS)} \$",
                                          style: AppStyle.small(Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    ButtonWidget(
                        onTap: () async {
                          CenterDialog.showLoadingDialog(context,"Бир оз кутинг");
                          List<Map> body = [];
                          for(int i =0; i<data.length;i++){
                            body.add({
                                  "ID_SKL_PR": data[i].idSklPr,
                                  "ID": data[i].id,
                                  "ID_SKL2": data[i].idSkl2,
                                  "NAME": data[i].name,
                                  "ID_TIP": data[i].idTip,
                                  "ID_FIRMA": data[i].idFirma,
                                  "ID_EDIZ": data[i].idEdiz,
                                  "SONI": data[i].soni,
                                  "NARHI": data[i].narhi,
                                  "NARHI_S": data[i].narhiS,
                                  "SM": data[i].sm,
                                  "SM_S": data[i].smS,
                                  "SNARHI": data[i].snarhi,
                                  "SNARHI_S": data[i].snarhiS,
                                  "SNARHI1": data[i].snarhi1,
                                  "SNARHI1_S": data[i].snarhi1S,
                                  "SNARHI2": data[i].snarhi2,
                                  "SNARHI2_S": data[i].snarhi2S,
                                  "TNARHI": data[i].tnarhi,
                                  "TNARHI_S": data[i].tnarhiS,
                                  "TSM": data[i].tsm,
                                  "TSM_S": data[i].tsmS,
                                  "SHTR": data[i].shtr,
                                  "price": data[i].price,
                                });
                          }
                          HttpResult res = await _repository.updateIncome2SklPr(body);
                          if(res.result['status'] == true){
                            await incomeBloc.getAllIncome(DateTime.now().year,DateTime.now().month);
                            _repository.clearIncomeProductBase();
                            if(context.mounted)Navigator.pop(context);
                            if(context.mounted)Navigator.pop(context);
                            if(context.mounted)Navigator.pop(context);
                          }
                          else{
                            if(context.mounted)Navigator.pop(context);
                            if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                          }
                        },
                        color: AppColors.green,
                        text: "Сақлаш"),
                    SizedBox(
                      height: 24.h,
                    )
                  ],
                ));
          }
          return Container();
        });
  }
}
