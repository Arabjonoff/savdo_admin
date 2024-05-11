import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/outcome/cart/cart_outcome_bloc.dart';
import 'package:savdo_admin/src/bloc/outcome/outcome_bloc.dart';
import 'package:savdo_admin/src/dialog/bottom_dialog.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/outcome/payment/outcome_payment_screen.dart';
import 'package:savdo_admin/src/ui/drawer/product/product_image/image_preview.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:savdo_admin/src/widget/outcome/outcome_update_dialog.dart';

class CartOutcomeScreen extends StatefulWidget {
   final bool isNavigate;
  final dynamic data;
  const CartOutcomeScreen({super.key, this.data,this.isNavigate=true});

  @override
  State<CartOutcomeScreen> createState() => _CartOutcomeScreenState();
}

class _CartOutcomeScreenState extends State<CartOutcomeScreen> {
  @override
  void initState() {
    cartOutcomeBloc.getAllCartOutcome();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: StreamBuilder<List<SklRsTov>>(
        stream: cartOutcomeBloc.getCartOutcomeStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            double totalUzs = 0;
            double totalUsd = 0;
            for(int i = 0; i<data.length;i++){
              totalUzs+=data[i].ssm;
              totalUsd+=data[i].ssmS;
            }
            if(data.isNotEmpty){
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx,index){
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (i){
                                    cartOutcomeBloc.deleteCartOutcome(data[index].id,5224,data[index].idSkl2,widget.data,context);
                                  },
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  label: "Ўчириш",
                                )
                              ],
                            ),
                            child: GestureDetector(
                              onTap: (){
                                BottomDialog.showScreenDialog(context,UpdateOutcomeWidgetDialog(data: data[index], price: data[index].snarhi!=0?data[index].snarhi:data[index].snarhiS, priceUsd: data[index].frS.toInt(), typeName: data[index].vz,ndocId: widget.data, id: data[index].id,));
                              },
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
                                    GestureDetector(
                                      onTap:(){
                                        CenterDialog.showImageDialog(context, data[index].name, ImagePreview(photo: data[index].shtr,));
                                      },
                                      child: Container(
                                        width: 80.r,
                                        height: 80.r,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white
                                        ),
                                        child: Hero(
                                          tag: data[index].id.toString(),
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>  Icon(Icons.error_outline,size: 23.h,),
                                            imageUrl: 'https://naqshsoft.site/images/$db/${data[index].shtr}',
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name,maxLines:1,style: AppStyle.smallBold(Colors.black),),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text("миқдори:",style: AppStyle.smallBold(Colors.grey),),
                                            const Spacer(),
                                            Text(priceFormatUsd.format(data[index].soni),style: AppStyle.smallBold(Colors.black),),
                                            SizedBox(width: 4.w,),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("нархи:",style: AppStyle.smallBold(Colors.grey),),
                                            data[index].snarhi!=0?
                                            Text("${priceFormatUsd.format(data[index].snarhi)} сўм",style: AppStyle.smallBold(Colors.black),):
                                            Text("${priceFormatUsd.format(data[index].snarhiS)} \$",style: AppStyle.smallBold(Colors.black),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("жами:",style: AppStyle.smallBold(Colors.grey),),
                                            data[index].ssm != 0?Text("${priceFormatUsd.format(data[index].ssm)} сўм",style: AppStyle.smallBold(Colors.black),):
                                            Text("${priceFormatUsd.format(data[index].ssmS)} \$",style: AppStyle.smallBold(Colors.black),),
                                          ],
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Жами: ",style: AppStyle.mediumBold(AppColors.green),),
                        Text("${priceFormat.format(totalUzs)} сўм | ${priceFormatUsd.format(totalUsd)} \$",style: AppStyle.mediumBold(AppColors.green),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    children: [
                      Expanded(child: ButtonWidget(onTap: ()  async{
                        await repository.lockOutcome(widget.data,1);
                        if(widget.isNavigate){
                          if(context.mounted)Navigator.pop(context);
                          if(context.mounted)Navigator.pop(context);
                        }
                        else{
                          if(context.mounted)Navigator.pop(context);
                        }
                        await outcomeBloc.getAllOutcome(DateFormat('yyyy-MM-dd').format(DateTime.now()),CacheService.getWareHouseId());
                        repository.clearOutcomeCart();
                      }, color: AppColors.green, text: "Сақлаш")),
                      FloatingActionButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppColors.green,
                        child: const Icon(Icons.monetization_on_outlined,color: Colors.white,),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx){
                            return OutcomePaymentScreen(ndocId: widget.data, summaUzs: priceFormat.format(totalUzs), summaUsd: priceFormatUsd.format(totalUsd),);
                          }));
                        },),
                      SizedBox(width: 16.w,)
                    ],
                  ),
                  SizedBox(height: 32.h,)
                ],
              );
            }
            return  const EmptyWidgetScreen();
          }
          return const EmptyWidgetScreen();
        }
      ),
    );
  }
}
