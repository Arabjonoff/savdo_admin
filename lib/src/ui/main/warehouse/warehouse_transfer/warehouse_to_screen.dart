import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/add_income/add_income_product_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

import '../../../../theme/icons/app_fonts.dart';

class WareHouseToScreen extends StatefulWidget {
  final Map data;
  const WareHouseToScreen({super.key, required this.data,});

  @override
  State<WareHouseToScreen> createState() => _WareHouseToScreenState();
}

class _WareHouseToScreenState extends State<WareHouseToScreen> {
  @override
  void initState() {
    incomeProductBloc.getAllIncomeProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<List<IncomeAddModel>>(
        stream: incomeProductBloc.getIncomeProductStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            double allPriceUzs = 0;
            double allPriceUsd = 0;
            var data = snapshot.data!;
            for(int i=0; i<data.length;i++){
              allPriceUzs += data[i].ssm;
              allPriceUsd += data[i].ssmS;
            }
            return Column(
              children: [
                Expanded(child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                    itemBuilder: (ctx,index){
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                            onPressed: (i)async{
                              HttpResult res = await repository.warehouseTransferItemDelete(data[index].id,widget.data["NDOC"],data[index].idSkl2);
                              if(res.result['status'] == true){
                                await repository.deleteIncomeProduct(data[index]);
                                await incomeProductBloc.getAllIncomeProduct();
                              }
                              else{
                                if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                              }
                            },
                          backgroundColor: AppColors.red,
                          label: "Ўчириш",
                          icon: Icons.delete,
                        )
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                      height: 100.h,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade300
                              )
                          )
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80.r,
                            height: 80.r,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>  Icon(Icons.error_outline,size: 23.h,),
                              imageUrl: 'https://naqshsoft.site/images/$db/${data[index].shtr}',
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].name,maxLines:2,style: AppStyle.mediumBold(Colors.black),),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data[index].snarhi != 0?Text("${priceFormat.format(data[index].snarhi)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data[index].snarhiS)} \$",style: AppStyle.medium(Colors.black),),
                                  Text(priceFormatUsd.format(data[index].soni),style: AppStyle.medium(Colors.black),),
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                })),
                Text("${priceFormat.format(allPriceUzs)} сўм | ${priceFormatUsd.format(allPriceUsd)} \$",style: AppStyle.large(AppColors.green),),
                SizedBox(height: 10.h,),
                ButtonWidget(onTap: (){}, color: AppColors.green, text: "Сақлаш"),
                SizedBox(height: 34.h,)
              ],
            );
          }
          return const EmptyWidgetScreen();
        }
      ),
    );
  }
}
