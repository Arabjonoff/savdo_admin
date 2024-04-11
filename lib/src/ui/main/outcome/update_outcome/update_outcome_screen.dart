import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/outcome/cart/cart_outcome_bloc.dart';
import 'package:savdo_admin/src/bloc/sklad/sklad_bloc.dart';
import 'package:savdo_admin/src/dialog/bottom_dialog.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/ui/main/outcome/cart/cart_outcome.dart';
import 'package:savdo_admin/src/ui/main/product/product_image/image_preview.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:savdo_admin/src/widget/outcome/outcome_dialog_widget.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class UpdateOutcomeScreen extends StatefulWidget {
  final dynamic ndocId;
  const UpdateOutcomeScreen({super.key, this.ndocId});

  @override
  State<UpdateOutcomeScreen> createState() => _UpdateOutcomeScreenState();
}

class _UpdateOutcomeScreenState extends State<UpdateOutcomeScreen> {
  final Repository _repository = Repository();
  int wareHouseId = 1,filterId = -1;
  num price = 0;
  num idPrice = 0;
  int priceUsd = 0;
  String wareHouseName = 'Асосий омбор';
  double percent = 0;
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  List<ProductTypeAllResult>? filterProduct=[ProductTypeAllResult(id: 0, name: '', st: 0)];
  List sklad = [];
  List<Map> sendData = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
     skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,wareHouseId,'');
    super.initState();
  }
  @override
  void dispose() {
    _repository.clearOutcomeCart();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: true,
      onPopInvoked : (didPop){
        // logic
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: CupertinoSearchTextField(
            placeholder: "Излаш",
            suffixIcon:const Icon(Icons.qr_code_scanner, size: 25,),
            suffixMode: OverlayVisibilityMode.always,
            onChanged: (i){
              skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,wareHouseId,i);
            },
          ),
          actions: [
            IconButton(onPressed: ()async{
              filterProduct = await _repository.getProductTypeBase();
              setState(() {});
              scaffoldKey.currentState!.openEndDrawer();
            }, icon: const Icon(Icons.filter_list))
          ],
          backgroundColor: AppColors.background,
        ),
        body: SnappingSheet(
          snappingPositions: const [
            SnappingPosition.factor(
              positionFactor: 0.0,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: Duration(seconds: 1),
              grabbingContentOffset: GrabbingContentOffset.top,
            ),
            SnappingPosition.pixels(
              positionPixels: 400,
              snappingCurve: Curves.elasticOut,
              snappingDuration: Duration(milliseconds: 1750),
            ),
            SnappingPosition.factor(
              positionFactor: 1.0,
              snappingCurve: Curves.bounceOut,
              snappingDuration: Duration(seconds: 1),
              grabbingContentOffset: GrabbingContentOffset.bottom,
            ),
          ],
          grabbingHeight: 75,
          // TODO: Add your grabbing widget here,
          grabbing: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text("Юқорига суринг",style: AppStyle.mediumBold(Colors.white),),
                const Icon(Icons.swipe_up_rounded,color: Colors.white,),
                const Spacer(),
                StreamBuilder<List<SklRsTov>>(
                    stream: cartOutcomeBloc.getCartOutcomeStream,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return CircleAvatar(
                            backgroundColor: AppColors.background,
                            child: Text(snapshot.data!.length.toString(),style: AppStyle.mediumBold(Colors.green),));
                      }
                      return const SizedBox();
                    }
                ),
                SizedBox(width: 16.w,),
              ],
            ),
          ),
          sheetBelow: SnappingSheetContent(
            draggable: (details) => true,
            child: CartOutcomeScreen(data: widget.ndocId,isNavigate: false,),
          ),
          child: RefreshIndicator(
            onRefresh: ()async{
              await _repository.clearSkladBase();
              await skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
              await skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,wareHouseId,'');
            },
            child: StreamBuilder<List<SkladResult>>(
                stream: skladBloc.getSkladSearchStream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    int productCount = 0;
                    var data = snapshot.data!;
                    for(int i =0; i<data.length;i++){
                      if(data[i].idTip==filterId){
                        productCount++;
                      }
                      else{
                        productCount++;
                      }
                    }
                    if (data.isEmpty) {
                      return const EmptyWidgetScreen();
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx,index){
                            if(data[index].idTip==filterId){
                              return GestureDetector(
                                onTap: (){
                                  if(data[index].osoni<=0){

                                  }
                                  else{
                                    price = 0;
                                    priceUsd = 0;
                                    if (idPrice == 0) {
                                      if (data[index].snarhi != 0) {
                                        price = data[index].snarhi;
                                      } else {
                                        price = data[index].snarhiS;
                                        priceUsd = 1;
                                      }
                                    } else if (idPrice == 1) {
                                      if (data[index].snarhi1 != 0) {
                                        price = data[index].snarhi1;
                                      } else {
                                        price = data[index].snarhi1S;
                                        priceUsd = 1;
                                      }
                                    } else if (idPrice == 2) {
                                      if (data[index].snarhi2 != 0) {
                                        price = data[index].snarhi2;
                                      } else {
                                        price = data[index].snarhi2S;
                                        priceUsd = 1;
                                      }
                                    }
                                    BottomDialog.showScreenDialog(context, AddOutcomeWidgetDialog(data: data[index], price: price, priceUsd: priceUsd,ndocId: widget.ndocId, typeName: data[index].idEdizName,));
                                  }
                                },
                                child: SizedBox(
                                  width: width,
                                  height: 100.h,
                                  child: Stack(
                                    children: [
                                      Container(
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
                                                CenterDialog.showImageDialog(context, data[index].name, ImagePreview(photo: data[index].photo,));
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
                                                    imageUrl: 'https://naqshsoft.site/images/$db/${data[index].photo}',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w,),
                                            Expanded(child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].name,maxLines:1,style: AppStyle.mediumBold(Colors.black),),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    Text("Нархи: ",style: AppStyle.small(Colors.black54),),
                                                    const Spacer(),
                                                    priceCheck(idPrice, data[index]),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Қолдиқ: ",style: AppStyle.small(Colors.black54),),
                                                    Text(priceFormatUsd.format(data[index].osoni),style: AppStyle.medium(Colors.black54),),
                                                  ],
                                                ),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                      if (data[index].osoni<=0) Container(
                                        width: width,
                                        alignment: Alignment.center,
                                        height: double.infinity,
                                        decoration:  BoxDecoration(
                                            color: Colors.grey.shade300.withOpacity(0.6)
                                        ),
                                        child: Text(
                                            'Маҳсулот қолмаган !',
                                            style: AppStyle.mediumBold(Colors.red)
                                        ),) else const SizedBox()
                                    ],
                                  ),
                                ),
                              );
                            }else if(filterId == -1){
                              return GestureDetector(
                                onTap: (){
                                  if(data[index].osoni<=0){

                                  }
                                  else{
                                    price = 0;
                                    priceUsd = 0;
                                    if (idPrice == 0) {
                                      if (data[index].snarhi != 0) {
                                        price = data[index].snarhi;
                                        priceUsd = 0;
                                      } else {
                                        price = data[index].snarhiS;
                                        priceUsd = 1;
                                      }
                                    } else if (idPrice == 1) {
                                      if (data[index].snarhi1 != 0) {
                                        price = data[index].snarhi1;
                                        priceUsd = 0;
                                      } else {
                                        price = data[index].snarhi1S;
                                        priceUsd = 1;
                                      }
                                    } else if (idPrice == 2) {
                                      if (data[index].snarhi2 != 0) {
                                        price = data[index].snarhi2;
                                        priceUsd = 0;
                                      } else {
                                        price = data[index].snarhi2S;
                                        priceUsd = 1;
                                      }
                                    }
                                    BottomDialog.showScreenDialog(context, AddOutcomeWidgetDialog(data: data[index], price: price, priceUsd: priceUsd,ndocId: widget.ndocId, typeName: data[index].idEdizName,));
                                  }
                                },
                                child: SizedBox(
                                  width: width,
                                  height: 100.h,
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 4.h),
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
                                                CenterDialog.showImageDialog(context, data[index].name, ImagePreview(photo: data[index].photo,));
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
                                                    imageUrl: 'https://naqshsoft.site/images/$db/${data[index].photo}',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w,),
                                            Expanded(child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].name,maxLines:1,style: AppStyle.mediumBold(Colors.black),),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    Text("Нархи: ",style: AppStyle.small(Colors.black54),),
                                                    const Spacer(),
                                                    priceCheck(idPrice, data[index]),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Қолдиқ: ",style: AppStyle.small(Colors.black54),),
                                                    const Spacer(),
                                                    Text(priceFormatUsd.format(data[index].osoni),style: AppStyle.medium(Colors.black),),
                                                    SizedBox(width: 4.w,),
                                                    Text(data[index].idEdizName.toLowerCase(),style: AppStyle.medium(Colors.black),),
                                                  ],
                                                ),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                      if (data[index].osoni<=0) Container(
                                        width: width,
                                        alignment: Alignment.center,
                                        height: double.infinity,
                                        decoration:  BoxDecoration(
                                            color: Colors.grey.shade300.withOpacity(0.6)
                                        ),
                                        child: Text(
                                            'Маҳсулот қолмаган !',
                                            style: AppStyle.mediumBold(Colors.red)
                                        ),) else const SizedBox()
                                    ],
                                  ),
                                ),
                              );
                            }
                            else{
                              return const SizedBox();
                            }
                          });
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                }
            ),
          ),
        ),
        backgroundColor: AppColors.background,
        endDrawer: Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: width,
                      padding: EdgeInsets.only(left: 16.w,top: 10,bottom: 10,right: 16.w),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Сотиш нархи",style: AppStyle.mediumBold(Colors.black),),
                          const Icon(Icons.money,color: Colors.grey,)
                        ],
                      ),
                    ),
                    ListTile(
                      selected: idPrice==0?true:false,
                      selectedColor: AppColors.green,
                      onTap: (){
                        setState(() {idPrice=0;});
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("1 - Нархи",),
                          Icon(Icons.radio_button_checked,color: idPrice==0?Colors.green:Colors.grey.shade300,)
                        ],
                      ),
                    ),
                    ListTile(
                      selected: idPrice==1?true:false,
                      selectedColor: AppColors.green,
                      onTap: (){
                        setState(() {idPrice=1;});
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("2 - Нархи"),
                          Icon(Icons.radio_button_checked,color: idPrice==1?Colors.green:Colors.grey.shade300,)
                        ],
                      ),
                    ),
                    ListTile(
                      selected: idPrice==2?true:false,
                      selectedColor: AppColors.green,
                      onTap: (){
                        setState(() {idPrice=2;});
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("3 - Нархи"),
                          Icon(Icons.radio_button_checked,color: idPrice==2?Colors.green:Colors.grey.shade300,)
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.only(left: 16.w,top: 10,bottom: 10,right: 16.w),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Филтрлаш",style: AppStyle.mediumBold(Colors.black),),
                          const Icon(Icons.filter_list_alt,color: Colors.grey,)
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(child: ListView.builder(
                    itemCount: filterProduct!.length,
                    itemBuilder: (ctx,index){
                      return ListTile(
                        selected: filterProduct![index].id==filterId?true:false,
                        selectedColor: AppColors.green,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(filterProduct![index].name),
                            Icon(Icons.radio_button_checked,color: filterProduct![index].id==filterId?Colors.green:Colors.grey.shade300,)
                          ],
                        ),
                        onTap: (){
                          filterId=filterProduct![index].id;
                          setState(() {});
                        },
                      );
                    })),
                Container(
                  width: width,
                  color: Colors.white,
                  child: TextButton(onPressed: (){
                    filterId = -1;
                    setState(() {});
                  }, child: Text("Фильтрни тозалаш",style: AppStyle.medium(Colors.red),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget priceCheck(idPrice,data){
    switch(idPrice){
      case 0:
        return data.snarhi != 0?Text("${priceFormat.format(data.snarhi)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data.snarhiS)} \$",style: AppStyle.medium(Colors.black),);
      case 1:
        return data.snarhi1 != 0?Text("${priceFormat.format(data.snarhi1)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data.snarhi1S)} \$",style: AppStyle.medium(Colors.black),);
      case 2:
        return data.snarhi2 != 0?Text("${priceFormat.format(data.snarhi2)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data.snarhi2S)} \$",style: AppStyle.medium(Colors.black),);
    }
    return data.snarhi != 0?Text("${priceFormat.format(data.snarhi)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data.snarhiS)} \$",style: AppStyle.medium(Colors.black),);
  }
}
