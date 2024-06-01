import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/revision/cart/cart_revision_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class AddRevisionScreen extends StatefulWidget {
  final num price;
  final  int priceUsd;
  final dynamic data,ndocId;
  const AddRevisionScreen({super.key, required this.price, required this.priceUsd, this.data, this.ndocId});

  @override
  State<AddRevisionScreen> createState() => _AddRevisionScreenState();
}

class _AddRevisionScreenState extends State<AddRevisionScreen> {
  TextEditingController controllerNewCount = TextEditingController();
  TextEditingController controllerTotal = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250.h,
                    color: Colors.white,
                    child: Hero(
                      tag: widget.data.id.toString(),
                      child: CachedNetworkImage(
                        imageUrl: 'https://naqshsoft.site/images/$db/${widget.data.photo}',
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>  const Icon(Icons.image_not_supported_outlined,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w,top: 16.w),
                    child: Text(widget.data.name,style: AppStyle.mediumBold(Colors.black),),
                  ),
                  SizedBox(height: 12.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Row(
                      children: [
                        Expanded(child: Text("Қолдиқ",style: AppStyle.smallBold(Colors.black),)),
                        Expanded(child: Text("Миқдори",style: AppStyle.smallBold(Colors.black),)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      /// count the number
                      Expanded(child: TextFieldWidget(
                        hintText: "1",
                        keyboardType: true,
                        readOnly: true,
                        controller: TextEditingController(text: priceFormatUsd.format(widget.data.osoni)),
                      )),
                      /// price calculation
                      Expanded(child: TextFieldWidget(
                        autofocus: true,
                        controller: controllerNewCount,
                        hintText: "",
                        onChanged: (i){
                          if(widget.data.snarhi==0){
                            controllerTotal.text = priceFormatUsd.format(num.parse(i)*widget.data.snarhiS);
                          }else{
                            controllerTotal.text = priceFormat.format(num.parse(i)*widget.data.snarhi);
                          }
                        },
                      )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Text("Нархи",style: AppStyle.smallBold(Colors.black),),
                  ),
                  TextFieldWidget(
                    controller: TextEditingController(text: widget.data.snarhi != 0?priceFormat.format(widget.data.snarhi):priceFormatUsd.format(widget.data.snarhiS)), hintText: "",keyboardType: true,readOnly: true,suffixText: widget.data.snarhi!=0?"Сўм":"\$",
                  ),
                  SizedBox(height: 8.w,),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Text("Жами",style: AppStyle.smallBold(Colors.black),),
                  ),
                  TextFieldWidget(controller: controllerTotal, hintText: "",keyboardType: true,readOnly: true,suffixText: "Сўм",),
                ],
              ),
            ),
            ButtonWidget(onTap: ()async{
              Map<String,Object> data = {
              "ID": widget.data.id,
              "NAME": widget.data.name,
              "ID_SKL2": widget.data.idSkl2,
              "SONI": widget.data.osoni,
              "N_SONI": controllerNewCount.text,
              "F_SONI": num.parse(controllerNewCount.text)-widget.data.osoni,
              "NARHI": widget.data.narhi,
              "NARHI_S": widget.data.narhiS,
              "SNARHI": widget.data.snarhi,
              "SNARHI_S": widget.data.snarhiS,
              "SNARHI1": widget.data.snarhi1,
              "SNARHI1_S": widget.data.snarhi1S,
              "SNARHI2": widget.data.snarhi2,
              "SNARHI2_S": widget.data.snarhi2S,
            };
              var res = await repository.saveRevisionBase(data);
              if(res >=0 ){
                await cartRevision.getAllRevisionCart();
                if(context.mounted)Navigator.pop(context);
              }
          }, color: AppColors.green, text: "Саватга қўшиш"),
            SizedBox(height: 32.h,)
          ],
        ),
      ),
    );
  }
}
