import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/payments/income_pay_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/payments/payments_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/ui/main/payment/income_pay/update_inocme_pay.dart';

class OutcomePayListScreen extends StatefulWidget {
  final dynamic idSklRs;
  const OutcomePayListScreen({super.key, required this.idSklRs});

  @override
  State<OutcomePayListScreen> createState() => _OutcomePayListScreenState();
}

class _OutcomePayListScreenState extends State<OutcomePayListScreen> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    incomePayBloc.getAllIncomePay(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    final Repository repository = Repository();
    return  Scaffold(
      body: StreamBuilder<List<PaymentsResult>>(
          stream: incomePayBloc.getIncomePayStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var data = snapshot.data!;
              if(data[0].tl1.isEmpty){
                return const SizedBox();
              }
              return ListView.builder(
                  itemCount: data[0].tl1.length,
                  itemBuilder: (ctx,index){
                    if(widget.idSklRs.runtimeType == int){
                      if(data[0].tl1[index].idSklRs == widget.idSklRs) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
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
                              SlidableAction(
                                backgroundColor: AppColors.green,
                                icon: Icons.edit,
                                label: "Таҳрирлаш",
                                onPressed: (i){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                    return UpdateIncomePayScreen(data: data[0].tl1[index],idSklRs: widget.idSklRs,isIdSklRs: true,);
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
                                Text(data[0].tl1[index].name,style: AppStyle.mediumBold(Colors.black),),
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
                    }
                    if(widget.idSklRs.runtimeType == String){
                      if(data[0].tl1[index].idSklRs == int.parse(widget.idSklRs)) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
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
                              SlidableAction(
                                backgroundColor: AppColors.green,
                                icon: Icons.edit,
                                label: "Таҳрирлаш",
                                onPressed: (i){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                    return UpdateIncomePayScreen(data: data[0].tl1[index],idSklRs: widget.idSklRs,isIdSklRs: true,);
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
                                Text(data[0].tl1[index].name,style: AppStyle.mediumBold(Colors.black),),
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
                    }
                    return const SizedBox();
                  });
            } return const SizedBox();
          }
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
