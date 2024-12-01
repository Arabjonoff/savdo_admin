import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/payments/income_pay_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/payments/payments_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/payment/income_pay/update_inocme_pay.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class IncomePayScreen extends StatefulWidget {
  final bool? isPayment;
  final int? idSklPr;
  final int idAgent;
  const IncomePayScreen({super.key,  this.isPayment,  this.idSklPr, this.idAgent =0});

  @override
  State<IncomePayScreen> createState() => _IncomePayScreenState();
}

class _IncomePayScreenState extends State<IncomePayScreen> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
   final TextEditingController _controllerDate = TextEditingController();
   List<AgentsResult> agents = [];
  num card = 0, bank = 0, price = 0;
  double currency = 0.0;
  @override
  void initState() {
    _controllerDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    incomePayBloc.getAllIncomePay(_controllerDate.text);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Repository repository = Repository();
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _key,
        backgroundColor: AppColors.background,
        body:StreamBuilder<List<PaymentsResult>>(
            stream: incomePayBloc.getIncomePayStream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var data = snapshot.data!;
                price = 0;
                currency = 0.0;
                card = 0;
                bank = 0;
                for(int i = 0;i<data[0].tl1.length;i++){
                  if(data[0].tl1[i].tip==1){
                    if(data[0].tl1[i].idAgent == widget.idAgent){
                      if (data[0].tl1[i].tp == 0) {
                        price += data[0].tl1[i].sm;
                      }if (data[0].tl1[i].tp == 1) {
                        currency +=  data[0].tl1[i].sm.toDouble();
                      }  if (data[0].tl1[i].tp == 2) {
                        card +=  data[0].tl1[i].sm;
                      }  if (data[0].tl1[i].tp == 3) {
                        bank +=  data[0].tl1[i].sm;
                      }
                    }
                    else if(widget.idAgent ==0){
                      if (data[0].tl1[i].tp == 0) {
                        price += data[0].tl1[i].sm;
                      }if (data[0].tl1[i].tp == 1) {
                        currency +=  data[0].tl1[i].sm.toDouble();
                      }  if (data[0].tl1[i].tp == 2) {
                        card +=  data[0].tl1[i].sm;
                      }  if (data[0].tl1[i].tp == 3) {
                        bank +=  data[0].tl1[i].sm;
                      }
                    }
                  }
                }
                if(data[0].tl1.isEmpty){
                  return const EmptyWidgetScreen();
                }
                return SnappingSheet(
                  grabbingHeight: 75,
                  // TODO: Add your grabbing widget here,
                  grabbing: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${priceFormat.format(price)} сўм | ",style: AppStyle.mediumBold(Colors.white)),
                        Text("${priceFormatUsd.format(currency)} \$  ",style: AppStyle.mediumBold(Colors.white))
                      ],
                    ),
                  ),
                  sheetBelow: SnappingSheetContent(
                    draggable: (details) => true,
                    // TODO: Add your sheet content here
                    child: Container(
                      width: width,
                      color: AppColors.white,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.money),
                            title: Text("Нақд пул",style: AppStyle.smallBold(Colors.black),),
                            trailing: Text(priceFormat.format(price),style: AppStyle.medium(AppColors.green),),
                          ),
                          ListTile(
                            leading: const Icon(Icons.monetization_on_outlined),
                            title: Text("Валюта",style: AppStyle.smallBold(Colors.black),),
                            trailing: Text(priceFormatUsd.format(currency),style: AppStyle.medium(AppColors.green),),
                          ),
                          ListTile(
                            leading: const Icon(Icons.credit_card_outlined),
                            title: Text("Пластик",style: AppStyle.smallBold(Colors.black),),
                            trailing: Text(priceFormatUsd.format(card),style: AppStyle.medium(AppColors.green),),
                          ),
                          ListTile(
                            leading: const Icon(Icons.account_balance_wallet_outlined),
                            title: Text("Банк",style: AppStyle.smallBold(Colors.black),),
                            trailing: Text(priceFormatUsd.format(bank),style: AppStyle.medium(AppColors.green),),
                          ),
                        ],
                      )
                    ),
                  ),
                  snappingPositions:  [
                    const SnappingPosition.factor(
                      positionFactor: 0.0,
                      snappingCurve: Curves.easeOutExpo,
                      snappingDuration: Duration(seconds: 1),
                      grabbingContentOffset: GrabbingContentOffset.top,
                    ),
                    SnappingPosition.pixels(
                      positionPixels: 300.h,
                      snappingCurve: Curves.elasticOut,
                      snappingDuration: const Duration(milliseconds: 1750),
                    ),
                  ],
                  child: ListView.builder(
                      itemCount: data[0].tl1.length,
                      itemBuilder: (ctx,index){
                        if(data[0].tl1[index].idAgent == widget.idAgent&&data[0].tl1[index].tip==1) {
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                CacheService.getPermissionPaymentIncome4()==0?const SizedBox():SlidableAction(
                                  backgroundColor: AppColors.red,
                                  icon: Icons.delete,
                                  label: "Ўчириш",
                                  onPressed: (i){
                                    CenterDialog.showDeleteDialog(context, ()async{
                                      HttpResult res = await repository.deleteIncomePayment(data[0].tl1[index].id, DateTime.now());
                                      if(res.result['status'] == true){
                                        incomePayBloc.getAllIncomePay(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                                        if(context.mounted)Navigator.pop(context);
                                      }
                                      else{
                                        if(context.mounted)Navigator.pop(context);
                                        if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                                      }
                                    });
                                  },
                                ),
                                CacheService.getPermissionPaymentIncome3()==0?const SizedBox():SlidableAction(
                                  backgroundColor: AppColors.green,
                                  icon: Icons.edit,
                                  label: "Таҳрирлаш",
                                  onPressed: (i){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return UpdateIncomePayScreen(data: data[0].tl1[index],);
                                    }));
                                  },
                                ),
                              ],
                            ),
                            child: Container(
                              width: width,
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade400
                                      )
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data[0].tl1[index].name,style: AppStyle.mediumBold(Colors.black),),
                                      data[0].tl1[index].idSklRs>0?const Text("📝",style: TextStyle(fontSize: 18),):const Text("👤",style: TextStyle(fontSize: 18))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Тўлов",style: AppStyle.small(Colors.black),),
                                      paymentCheck(data[0].tl1[index])
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Қабул қилинди",style: AppStyle.small(Colors.black),),
                                      paymentCheckSm0(data[0].tl1[index])
                                    ],
                                  ),
                                  data[0].tl1[index].izoh.isEmpty?const SizedBox():Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Изоҳи",style: AppStyle.small(Colors.black),),
                                      Text(data[0].tl1[index].izoh,style: AppStyle.medium(Colors.black),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else if(widget.idAgent == 0&&data[0].tl1[index].tip==1){
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                CacheService.getPermissionPaymentIncome4()==0?const SizedBox():SlidableAction(
                                  backgroundColor: AppColors.red,
                                  icon: Icons.delete,
                                  label: "Ўчириш",
                                  onPressed: (i){
                                    CenterDialog.showDeleteDialog(context, ()async{
                                      HttpResult res = await repository.deleteIncomePayment(data[0].tl1[index].id, DateTime.now());
                                      if(res.result['status'] == true){
                                        incomePayBloc.getAllIncomePay(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                                        if(context.mounted)Navigator.pop(context);
                                      }
                                      else{
                                        if(context.mounted)Navigator.pop(context);
                                        if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                                      }
                                    });
                                  },
                                ),
                                CacheService.getPermissionPaymentIncome3()==0?const SizedBox():SlidableAction(
                                  backgroundColor: AppColors.green,
                                  icon: Icons.edit,
                                  label: "Таҳрирлаш",
                                  onPressed: (i){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return UpdateIncomePayScreen(data: data[0].tl1[index],);
                                    }));
                                  },
                                ),
                              ],
                            ),
                            child: Container(
                              width: width,
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade400
                                      )
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data[0].tl1[index].name,style: AppStyle.mediumBold(Colors.black),),
                                      data[0].tl1[index].idSklRs>0?const Text("📝",style: TextStyle(fontSize: 18),):const Text("👤",style: TextStyle(fontSize: 18))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Тўлов",style: AppStyle.small(Colors.black),),
                                      paymentCheck(data[0].tl1[index])
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Қабул қилинди",style: AppStyle.small(Colors.black),),
                                      paymentCheckSm0(data[0].tl1[index])
                                    ],
                                  ),
                                  data[0].tl1[index].izoh.isEmpty?const SizedBox():Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Изоҳи",style: AppStyle.small(Colors.black),),
                                      Text(data[0].tl1[index].izoh,style: AppStyle.medium(Colors.black),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                );
              } return const EmptyWidgetScreen();
            }
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
  Widget paymentCheck(Tolov1 data){
    if(data.tp == 0){
      return Text("${priceFormatUsd.format(data.sm)} сўм",style: AppStyle.medium(AppColors.green),);
    }
    else if(data.tp == 1){
      return Text("${priceFormatUsd.format(data.sm)} \$",style: AppStyle.medium(AppColors.green),);
    }
    else if(data.tp == 2){
      return Text("${priceFormatUsd.format(data.sm)} Пластик",style: AppStyle.medium(AppColors.green),);
    }
    else if(data.tp == 3){
      return Text("${priceFormatUsd.format(data.sm)} банк",style: AppStyle.medium(AppColors.green),);
    }
    return Text("${priceFormatUsd.format(data.sm)} сўм",style: AppStyle.medium(AppColors.green),);
  }
  Widget paymentCheckSm0(Tolov1 data){
    if(data.idValuta == 0){
      return Text("${priceFormatUsd.format(data.sm0)} сўм",style: AppStyle.medium(AppColors.green),);
    }
    else if(data.idValuta == 1){
      return Text("${priceFormatUsd.format(data.sm0)} \$",style: AppStyle.medium(AppColors.green),);
    }
    return Text("${priceFormatUsd.format(data.sm0)} сўм",style: AppStyle.medium(AppColors.green),);
  }
}
