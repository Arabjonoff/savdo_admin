import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/add_income/add_income_product_bloc.dart';
import 'package:savdo_admin/src/bloc/income/income_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';
import 'package:savdo_admin/src/model/income/income_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/income/update_income/updateIncome_item.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/utils.dart';

class CartUpdateIncomeScreen extends StatefulWidget {
  final IncomeResult data;
  const CartUpdateIncomeScreen({super.key, required this.data,});

  @override
  State<CartUpdateIncomeScreen> createState() => _CartUpdateIncomeScreenState();
}

class _CartUpdateIncomeScreenState extends State<CartUpdateIncomeScreen> {
  @override
  void initState() {
    incomeProductBloc.getAllIncomeProduct();
    super.initState();
  }
  final Repository _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<IncomeAddModel>>(
        stream: incomeProductBloc.getIncomeProductStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx,index){
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        Expanded(child: Column(
                          children: [
                            // SlidableAction(
                            //   onPressed: (i){
                            //     Navigator.push(context, MaterialPageRoute(builder: (ctx){
                            //       return UpdateIncomeItem(data: data[index],id: widget.data,);
                            //     }));
                            //   },
                            //   icon: Icons.edit,
                            //   label: "Таҳрирлаш",
                            // ),
                            SlidableAction(
                              onPressed: (i){
                                Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                  return UpdateIncomeItem(id: widget.data.id, data: data[index],);
                                }));
                              },
                              icon: Icons.edit,
                              label: "Таҳрирлаш",
                            ),
                            SlidableAction(
                              onPressed: (i){
                                CenterDialog.showDeleteDialog(context, () async{
                                  HttpResult res = await _repository.deleteIncomeSklPr(data[index].id, widget.data.id, data[index].idSkl2);
                                  if(res.result["status"] == true){
                                    await _repository.deleteIncomeProduct(data[index]);
                                    await incomeProductBloc.getAllIncomeProduct();
                                    await incomeBloc.getAllIncome(DateTime.now().year,DateTime.now().month,CacheService.getWareHouseId());
                                    if(context.mounted)Navigator.pop(context);
                                  }
                                  else{
                                    if(context.mounted)Navigator.pop(context);
                                    if(context.mounted)CenterDialog.showErrorDialog(context, res.result["message"]);
                                  }
                                });
                              },
                              icon: Icons.delete,
                              label: "Ўчириш",
                            ),
                          ],
                        ))
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 4.h),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey
                              )
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Миқдори:',style: AppStyle.small(Colors.grey),),
                              Text(priceFormatUsd.format(data[index].soni),style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Нархи:',style: AppStyle.small(Colors.grey),),
                              data[index].narhi!=0?Text("${priceFormat.format(data[index].narhi)} сўм",style: AppStyle.smallBold(Colors.black),):Text("${priceFormatUsd.format(data[index].narhiS)} \$",style: AppStyle.smallBold(Colors.black),),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8,bottom: 2),
                            width: MediaQuery.of(context).size.width,
                            child: DashedRect(
                              gap: 8.w,
                              strokeWidth: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('Сотиш нархи 1',style: AppStyle.small(AppColors.green),)),
                              Expanded(child: Text('Сотиш нархи 2',style: AppStyle.small(AppColors.green),)),
                              Expanded(child: Text('Сотиш нархи 3',style: AppStyle.small(AppColors.green),)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text(data[index].snarhi != 0?"${priceFormat.format(data[index].snarhi)} сўм":"${priceFormatUsd.format(data[index].snarhiS)} \$",style: AppStyle.small(AppColors.green),)),
                              Expanded(child: Text(data[index].snarhi1 != 0?"${priceFormat.format(data[index].snarhi1)} сўм":"${priceFormatUsd.format(data[index].snarhi1S)} \$",style: AppStyle.small(AppColors.green),)),
                              Expanded(child: Text(data[index].snarhi2 != 0?"${priceFormat.format(data[index].snarhi2)} сўм":"${priceFormatUsd.format(data[index].snarhi2S)} \$",style: AppStyle.small(AppColors.green),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          return Container();
        }
      ),
    );
  }
}
