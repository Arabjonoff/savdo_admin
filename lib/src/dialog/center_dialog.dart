// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class CenterDialog{

  /// Barcode Dialog
  static void showBarcodeDialog(BuildContext context,Widget screen){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        content: SizedBox(
          height: 300.h,
          width: MediaQuery.of(context).size.width,
          child: screen
        ),
      );
    });
  }

  /// ProductType Dialog
  static void showProductTypeDialog(BuildContext context,String text,Widget screen){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        title: Text(text,style: AppStyle.medium(Colors.black),),
        content: SizedBox(
            height: 250.h,
            width: MediaQuery.of(context).size.width,
            child: screen
        ),
      );
    });
  }

  /// ShowImageDialog Dialog
  static void showImageDialog(BuildContext context,String text,Widget screen){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        title: Text('',style: AppStyle.medium(Colors.black),),
        content: SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: screen
        ),
      );
    });
  }

  static void showInternetDialog(BuildContext context,String text,Widget screen){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx){
      return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(child: screen),
                  // ButtonWidget(onTap: (){
                  //   Navigator.popUntil(context, (route) => route.isFirst);
                  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
                  //     return MainScreen();
                  //   }));
                  // }, color: AppColors.green, text: "text")
                ],
              ),
            ),
          ));
    });
  }

  /// Loading Dialog
  static void showLoadingDialog(BuildContext context,String text){
    showDialog(
      barrierDismissible: false,
        context: context, builder: (ctx){
      return Dialog(
        elevation: 0,
        child:  Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h,),
              Center(child: CircularProgressIndicator()),
              SizedBox(height: 20.h,),
              Text(text,style: AppStyle.mediumBold(Colors.black),textAlign: TextAlign.center,),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      );
    });
  }

  static void showDeleteDialog(BuildContext context,Function() onTap){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        content: SizedBox(
          height: 200.h,
          child: Column(
            children: [
              Text("🗑",style: TextStyle(fontSize: 60),),
              const Spacer(),
              Text("Маълумот ўчирилсинми ?",style: AppStyle.mediumBold(AppColors.textBoldLight),),
              const Spacer(),
              Row(
                children: [
                  Expanded(child: ButtonWidget(onTap: ()=>Navigator.pop(context), color: AppColors.red, text: "Йўқ")),
                  Expanded(child: ButtonWidget(onTap: onTap, color: AppColors.green, text: "Ҳа")),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  static void showErrorDialog(BuildContext context,text){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title:  Text("Хатолик юз берди!",style: AppStyle.medium(Colors.black),),
        content: SizedBox(
          height: 200.h,
          child: Column(
            children: [
              Text("❗️",style: TextStyle(fontSize: 60),),
              SizedBox(height: 12.h,),
              Center(child: Text(text,textAlign:TextAlign.center,style: AppStyle.mediumBold(AppColors.textBoldLight),)),
              const Spacer(),
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Тушунарли")),
            ],
          ),
        ),
      );
    });
  }

  static void showSuccessDialog(BuildContext context){
    showDialog(context: context, builder: (ctx){
      return GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: AlertDialog(
          title:  Text("Ҳаммаси яхши",style: AppStyle.medium(Colors.black),),
          content: SizedBox(
            height: 150.h,
            child: Column(
              children: [
                Text("😀",style: TextStyle(fontSize: 50),),
                SizedBox(height: 12.h,),
                Center(child: Text("Ҳаммаси яхши ишлашда давом этинг",textAlign:TextAlign.center,style: AppStyle.mediumBold(AppColors.textBoldLight),)),
              ],
            ),
          ),
        ),
      );
    });
  }


  static void showClientDetailDialog(BuildContext context,ClientResult data){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        title:  Text("${data.idT} ${data.name}",style: AppStyle.mediumBold(Colors.black),),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250.h,
          child: Column(
            children: [
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Телефон рақами:",style: AppStyle.medium(Colors.black),),
                  Text(data.tel,style: AppStyle.medium(Colors.black)),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Манзил:",style: AppStyle.medium(Colors.black),),
                  Text(data.manzil,style: AppStyle.medium(Colors.black)),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Мўлжал:",style: AppStyle.medium(Colors.black),),
                  Text(data.muljal,style: AppStyle.medium(Colors.black)),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Фаолият тури:",style: AppStyle.medium(Colors.black),),
                  Text(data.idFaolName,style: AppStyle.medium(Colors.black)),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ҳудуди:",style: AppStyle.medium(Colors.black),),
                  Text(data.idKlassName,style: AppStyle.medium(Colors.black)),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ҳолати:",style: AppStyle.medium(Colors.black),),
                  Text(data.st == 0?"Ишламаяпти":"Ишлаяпти",style: AppStyle.medium(Colors.black)),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  static void showWarehouseDialog(BuildContext context,int selectWarehouse)async{
    Repository repository = Repository();
    List<ProductTypeAllResult> wareHouse = await repository.getWareHouseBase();
    // ignore: use_build_context_synchronously
    showDialog(context: context, builder: (ctx){
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w,top: 16.w),
                child: Text("Омборлар рўйхати",style: AppStyle.mediumBold(Colors.black),),
              ),
              Expanded(child: ListView.builder(
                  itemCount: wareHouse.length,
                  itemBuilder: (ctx,index){
                    return ListTile(
                      onTap: (){
                        if(selectWarehouse == 2){
                          RxBus.post(wareHouse[index].id.toString(),tag: 'warehouseToId');
                          RxBus.post(wareHouse[index].name.toString(),tag: 'warehouseToName');
                          Navigator.pop(context);
                        }
                        if(selectWarehouse == 1){
                          RxBus.post(wareHouse[index].id.toString(),tag: 'warehouseFromId');
                          RxBus.post(wareHouse[index].name.toString(),tag: 'warehouseFromName');
                          Navigator.pop(context);
                        }
                      },
                      title: Text(wareHouse[index].name),
                    );
                  }))
            ],
          ),
        ),
      );
    });
  }



// static void showCountryDialog(BuildContext context,String text){
  //   showDialog(
  //       context: context, builder: (ctx){
  //     return Dialog(
  //       insetPadding: EdgeInsets.zero,
  //       elevation: 0,
  //       child:  Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           ListTile(
  //             onTap: (){},
  //             leading: Image.asset('assets/images/uzbekistan.png',width: 30.spMin,),
  //             title: Text("(+998) Uzbekistan"),
  //           ),
  //           ListTile(
  //             leading: Image.asset('assets/images/kyrgyzstan.png',width: 30.spMin,),
  //             title: Text("(+996) Kyrgyzstan"),
  //           ),
  //           ListTile(
  //             leading: Image.asset('assets/images/kazakhstan.png',width: 30.spMin,),
  //             title: Text("(+7) Kazakhstan"),
  //           ),
  //           ListTile(
  //             leading: Image.asset('assets/images/turkey.png',width: 30.spMin,),
  //             title: Text("(+90) Turkey"),
  //           ),
  //           ListTile(
  //             leading: Image.asset('assets/images/russia.png',width: 30.spMin,),
  //             title: Text("(+7) Russian"),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

}