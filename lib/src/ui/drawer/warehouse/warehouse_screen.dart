// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/sklad/sklad_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/sklad/get_sklad_per_model.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/product/product_image/image_preview.dart';
import 'package:savdo_admin/src/ui/drawer/warehouse/warehouser_search.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class WareHouseScreen extends StatefulWidget {
  const WareHouseScreen({super.key});

  @override
  State<WareHouseScreen> createState() => _WareHouseScreenState();
}

class _WareHouseScreenState extends State<WareHouseScreen> {
  final Repository _repository = Repository();
  int wareHouseId = 1,filterId = -1,idPrice=3;
  String wareHouseName = '';
  double percent = 0;
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  List<ProductTypeAllResult>? filterProduct=[ProductTypeAllResult(id: 0, name: '', st: 0)];
  List sklad = [];
  List<Map> sendData = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    if(CacheService.getPermissionMainWarehouse5() ==1){
      idPrice=3;
    }else{
      idPrice=0;
    }
    wareHouseName = CacheService.getWareHouseName();
    wareHouseId = CacheService.getWareHouseId();
    skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
    super.initState();
  }
  @override
  void dispose() {
    dateTime = DateTime(DateTime.now().year,DateTime.now().month);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
        title: TextButton(
          onPressed: ()async{
            List<ProductTypeAllResult> wareHouse = await _repository.getWareHouseBase();
            showDialog(context: context, builder: (ctx){
              return Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  width: width,
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
                          onTap: () async {
                            wareHouseId = wareHouse[index].id;
                            wareHouseName = wareHouse[index].name;
                            CacheService.saveWareHouseId(wareHouse[index].id);
                            CacheService.saveWareHouseName(wareHouse[index].name);
                            await _repository.clearSkladBase();
                            skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
                            setState(() {});
                            Navigator.pop(context);
                          },
                          title: Text(wareHouse[index].name,style: AppStyle.medium(Colors.black),),
                          trailing: Icon(Icons.radio_button_checked,color: wareHouseId == wareHouse[index].id?AppColors.green:Colors.grey,),
                        );
                      }))
                    ],
                  ),
                ),
              );
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(wareHouseName,style: AppStyle.medium(Colors.black),),
              Text("Сана: ${DateFormat('yyyy-MMM').format(dateTime)}",style: AppStyle.small(Colors.black),),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: ()async{
                filterProduct = await _repository.getProductTypeBase();
                setState(() {
                });
                scaffoldKey.currentState!.openEndDrawer();
              }, icon: const Icon(Icons.filter_list_alt)),
          PopupMenuButton(
            color: AppColors.background,
            onSelected: (select) async{
              /// Mahsulotni qayta hisoblash
              if (select == 3) {
                CenterDialog.showLoadingDialog(context, "Қайта ҳисобланмоқда кутинг...");
                HttpResult result = await _repository.getSkladPer(dateTime.year, dateTime.month,wareHouseId);
                if(result.isSuccess){
                  var data = GetSkladPerModel.fromJson(result.result);
                  for(int i =0; i<data.data.length;i++){
                    sklad.add(data.data[i].idSkl2);
                  }
                }
                if(sklad.isNotEmpty){
                  int countLength = 0;
                  for(int i = 0; i<sklad.length;i++){
                    sendData.add({'ID_SKL2':sklad[i]});
                    if(sendData.length==20){
                      countLength+=20;
                      setState(() => percent = 100/(sklad.length/countLength));
                       await _repository.resetSkladPer(sendData, dateTime.year, dateTime.month, wareHouseId);
                      sendData.clear();
                    }
                  }
                  if(countLength==sklad.length){
                    setState(() {
                      if(context.mounted)Navigator.pop(context);
                      sendData.clear();
                      sklad.clear();
                      _repository.clearSkladBase();
                      skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
                    });
                  }else{
                    sendData.clear();
                    var resLength = sklad.length-countLength;
                    for(int i = countLength; i<countLength+resLength;i++){
                      sendData.add({'ID_SKL2':sklad[i]});
                    }
                    HttpResult result = await _repository.resetSkladPer(sendData, dateTime.year, dateTime.month, wareHouseId);
                    if(result.result["status"] == true){
                      setState(() {
                        if(context.mounted)Navigator.pop(context);
                        sendData.clear();
                        sklad.clear();
                        _repository.clearSkladBase();
                        skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
                        CenterDialog.showSuccessDialog(context,);
                      });
                    }
                  }
                }
              }
              /// Oydan oyga olib o'tish
              if (select == 1) {
                if(CacheService.getPermissionMainWarehouse3() ==1){
                  if(context.mounted)CenterDialog.showLoadingDialog(context, "Маҳсулотларни ойдан-ойга олиб ўтилмоқда");
                  HttpResult result = await _repository.getSkladSkl2(dateTime.year, dateTime.month,wareHouseId);
                  if(result.isSuccess){
                    var data = GetSkladPerModel.fromJson(result.result);
                    for(int i =0; i<data.data.length;i++){
                      sklad.add(data.data[i].idSkl2);
                    }
                  }
                  if(sklad.isNotEmpty){
                    int countLength = 0;
                    for(int i = 0; i<sklad.length;i++){
                      sendData.add({'ID_SKL2':sklad[i]});
                      if(sendData.length==20){
                        countLength+=20;
                        await _repository.resetSkladSkl2(sendData, dateTime.year, dateTime.month, wareHouseId);
                        sendData.clear();
                      }
                    }
                    if(countLength==sklad.length){
                      setState(() {
                        if(context.mounted)Navigator.pop(context);
                        sendData.clear();
                        sklad.clear();
                        _repository.clearSkladBase();
                        skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
                      });
                    }else{
                      sendData.clear();
                      var resLength = sklad.length-countLength;
                      for(int i = countLength; i<countLength+resLength;i++){
                        sendData.add({'ID_SKL2':sklad[i]});
                      }
                      HttpResult result = await _repository.resetSkladSkl2(sendData,dateTime.year, dateTime.month, wareHouseId);
                      if(result.result["status"] == true){
                        setState(() {
                          if(context.mounted)Navigator.pop(context);
                          sendData.clear();
                          sklad.clear();
                          _repository.clearSkladBase();
                          skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
                          CenterDialog.showSuccessDialog(context,);
                        });
                      }
                    }
                  }
                }
                else{
                  CenterDialog.showErrorDialog(context, "Рухсат берилмаган");
                }
              }
            },
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: ((context){
              return  [
                const PopupMenuItem(
                  value: 1,
                  child: Text("Ўтган ойдаги қолдиқларни янги ойга олиб ўтиш"),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text("Маҳсулотни қайта ҳиоблаш"),
                ),
              ];
            }),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: Padding(
            padding:EdgeInsets.only(left: 8.0.w,right: 8.0.w,bottom: 8.0.w,),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context, PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>   WareHouseSearch(idPrice: idPrice,),
                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c)
                ));
              },
              child: Container(
                padding: EdgeInsets.only(left: 16.w),
                alignment: Alignment.centerLeft,
                width: width,
                height: 34.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded),
                    SizedBox(width: 8.w,),
                    Text("Излаш",style: AppStyle.small(Colors.grey),),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          _repository.clearSkladBase();
          skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
        },
        child: SnappingSheet(
          snappingPositions:  [
            const SnappingPosition.factor(
              positionFactor: 0.0,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: Duration(seconds: 1),
              grabbingContentOffset: GrabbingContentOffset.top,
            ),
            SnappingPosition.pixels(
              positionPixels: 250.h,
              snappingCurve: Curves.elasticOut,
              snappingDuration: const Duration(milliseconds: 1750),
            ),
          ],
          grabbingHeight: 75,
          grabbing: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            width: width,
            decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Юқорига суринг",style: AppStyle.mediumBold(AppColors.white),),
                SizedBox(width: 8.w,),
                const Icon(Icons.swipe_up_sharp,color: Colors.white,)
              ],
            ),),
          sheetBelow: SnappingSheetContent(
            draggable: (details) => true,
            // TODO: Add your sheet content here
            child:StreamBuilder<List<SkladResult>>(
              stream: skladBloc.getSkladStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  int productCountType = 0;
                  double productCount = 0;
                  num productUzs = 0,productUsd = 0;
                  var data = snapshot.data!;
                  for(int i =0; i<data.length;i++){
                    if(idPrice==3){
                      if(data[i].idTip==filterId){
                        productCountType++;
                        productCount+=data[i].osoni;
                        productUzs+=data[i].osoni*data[i].narhi;
                        productUsd+=data[i].osoni*data[i].narhiS;
                      }
                      else{
                        productCountType++;
                        productCount+=data[i].osoni;
                        productUzs+=data[i].osoni*data[i].narhi;
                        productUsd+=data[i].osoni*data[i].narhiS;
                      }
                    }
                    else if(idPrice==0){
                      if(data[i].idTip==filterId){
                        productCountType++;
                        productCount+=data[i].osoni;
                        productUzs+=data[i].osoni*data[i].snarhi;
                        productUsd+=data[i].osoni*data[i].snarhiS;
                      }
                      else{
                        productCountType++;
                        productCount+=data[i].osoni;
                        productUzs+=data[i].osoni*data[i].snarhi;
                        productUsd+=data[i].osoni*data[i].snarhiS;
                      }
                    }
                    else if(idPrice==1){
                      if(data[i].idTip==filterId){
                        productCountType++;
                        productCount+=data[i].osoni;
                        productUzs+=data[i].osoni*data[i].snarhi1;
                        productUsd+=data[i].osoni*data[i].snarhi1S;
                      }
                      else{
                        productCountType++;
                        productCount+=data[i].osoni;
                        productUzs+=data[i].osoni*data[i].snarhi1;
                        productUsd+=data[i].osoni*data[i].snarhi1S;
                      }
                    }
                    else if(idPrice==2){
                      if(data[i].idTip==filterId){
                        productCountType++;
                        productCount+=data[i].osoni;
                        productUzs+=data[i].osoni*data[i].snarhi2;
                        productUsd+=data[i].osoni*data[i].snarhi2S;
                      }
                      else{
                        productCountType++;
                        productCount+=data[i].osoni;
                        productUzs+=data[i].osoni*data[i].snarhi2;
                        productUsd+=data[i].osoni*data[i].snarhi2S;
                      }
                    }
                  }
                  return Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      color: AppColors.white,
                      child: Column(
                        children: [
                          SizedBox(height: 16.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tовар тури:",style: AppStyle.medium(AppColors.black),),
                              Text("$productCountType Хил",style: AppStyle.mediumBold(AppColors.black),),
                            ],
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tовар миқдори:",style: AppStyle.medium(AppColors.black),),
                              Text(priceFormatUsd.format(productCount),style: AppStyle.mediumBold(AppColors.black),),
                            ],
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Товар сўм:",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormat.format(productUzs)} сўм",style: AppStyle.mediumBold(Colors.black),),
                            ],
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Товар валюта:",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormat.format(productUsd)} \$",style: AppStyle.mediumBold(Colors.black),),
                            ],
                          ),
                        ],
                      ));
                }return Container(color: AppColors.white,width: width,);
              }
            ),
          ),
          child: StreamBuilder<List<SkladResult>>(
            stream: skladBloc.getSkladStream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var data = snapshot.data!;
                if (data.isEmpty) {
                  return const EmptyWidgetScreen();
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx,index){
                        if(data[index].idTip==filterId){
                          return GestureDetector(
                            onTap: (){
                              // _repository.clearSkladBase();
                            },
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (i){},
                                    backgroundColor: Colors.red,
                                    label: "Ўчириш",
                                    icon: Icons.delete,)
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
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>  Icon(Icons.error_outline,size: 23.h,),
                                          imageUrl: 'https://naqshsoft.site/images/$db/${data[index].photo}',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w,),
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name,maxLines:1,style: AppStyle.mediumBold(Colors.black),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("нархи: ",style: AppStyle.smallBold(Colors.black38),),
                                            priceCheck(idPrice,data[index]),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("қолдиқ: ",style: AppStyle.smallBold(Colors.black38),),
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
                            ),
                          );
                        }else if(filterId == -1){
                          return GestureDetector(
                            onTap: (){
                              _repository.clearSkladBase();
                            },
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (i){},
                                    backgroundColor: Colors.red,
                                    label: "Ўчириш",
                                    icon: Icons.delete,)
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
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>  Icon(Icons.error_outline,size: 23.h,),
                                          imageUrl: 'https://naqshsoft.site/images/$db/${data[index].photo}',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w,),
                                    Expanded(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name,maxLines:1,style: AppStyle.mediumBold(Colors.black),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("нархи: ",style: AppStyle.smallBold(Colors.black38),),
                                            priceCheck(idPrice,data[index]),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("қолдиқ: ",style: AppStyle.smallBold(Colors.black38),),
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
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("Сана бўйича",style: AppStyle.mediumBold(Colors.black),),
              ),
              TextFieldWidget(controller: TextEditingController(text: DateFormat('yyyy-MMM').format(dateTime)), hintText: "",suffixIcon: IconButton( onPressed: (){
                showMonthPicker(
                    roundedCornersRadius: 25,
                    headerColor: AppColors.green,
                    selectedMonthBackgroundColor: AppColors.green.withOpacity(0.7),
                    context: context,
                    initialDate: dateTime,
                    lastDate: DateTime.now()
                ).then((date) {
                  if (date != null) {
                    setState(() {
                      dateTime = date;
                    });
                    _repository.clearSkladBase();
                    skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
                  }
                });
              },icon:  Icon(Icons.calendar_month,color: AppColors.green,),),),
              Container(
                padding: EdgeInsets.only(left: 16.w,bottom: 8.r,top: 8.r),
                width: width,
                color: Colors.white,
                child: Text("Нархи бўйича",style: AppStyle.mediumBold(Colors.black),),
              ),
              CacheService.getPermissionMainWarehouse5() ==0?const SizedBox():ListTile(
                onTap: (){
                  setState(() => idPrice = 3);
                },
                title: Text("Кирим нархи",style: AppStyle.medium(Colors.black),),
                trailing: Icon(Icons.radio_button_checked,color: idPrice ==3?AppColors.green:Colors.grey,),
              ),
              ListTile(
                onTap: (){
                  setState(() => idPrice = 0);
                },
                title: Text("Сотиш нархи -1",style: AppStyle.medium(Colors.black),),
                trailing: Icon(Icons.radio_button_checked,color: idPrice ==0?AppColors.green:Colors.grey,),
              ),
              ListTile(
                onTap: (){
                  setState(() => idPrice = 1);
                },
                title: Text("Сотиш нархи -2",style: AppStyle.medium(Colors.black),),
                trailing: Icon(Icons.radio_button_checked,color: idPrice ==1?AppColors.green:Colors.grey,),
              ),
              ListTile(
                onTap: (){
                  setState(() => idPrice = 2);
                },
                title: Text("Сотиш нархи -3",style: AppStyle.medium(Colors.black),),
                trailing: Icon(Icons.radio_button_checked,color: idPrice ==2?AppColors.green:Colors.grey,),
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(left: 16.w,bottom: 8.r,top: 8.r),
                color: Colors.white,
                child: Text("Маҳсулот тури бўйича",style: AppStyle.mediumBold(Colors.black),),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filterProduct!.length,
                    itemBuilder: (ctx,index){
                  return ListTile(
                    selectedColor: AppColors.white,
                    selectedTileColor: Colors.green.shade500,
                    title: Text(filterProduct![index].name),
                    onTap: (){
                      filterId=filterProduct![index].id;
                      setState(() {});
                    },
                    trailing: Icon(Icons.radio_button_checked,color: filterProduct![index].id==filterId?AppColors.green:Colors.grey,),
                  );
                }),
              ),
              Center(
                child: TextButton(onPressed: (){
                  filterId = -1;
                  setState(() {});
                }, child: Text("Tозалаш",style: AppStyle.medium(Colors.red),)),
              )
            ],
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
      case 3:
        return data.narhi != 0?Text("${priceFormat.format(data.narhi)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data.narhiS)} \$",style: AppStyle.medium(Colors.black),);
      default:
        return data.narhi != 0?Text("${priceFormat.format(data.narhi)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data.narhiS)} \$",style: AppStyle.medium(Colors.black),);
    }
  }
}

