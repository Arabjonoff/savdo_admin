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
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/ui/main/product/product_image/image_preview.dart';
import 'package:savdo_admin/src/ui/main/warehouse/warehouser_search.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

class WareHouseScreen extends StatefulWidget {
  const WareHouseScreen({super.key});

  @override
  State<WareHouseScreen> createState() => _WareHouseScreenState();
}

class _WareHouseScreenState extends State<WareHouseScreen> {
  final Repository _repository = Repository();
  int wareHouseId = 1,filterId = -1;
  String wareHouseName = 'Асосий омбор';
  double percent = 0;
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  List<ProductTypeAllResult>? filterProduct=[ProductTypeAllResult(id: 0, name: '', st: 0)];
  List sklad = [];
  List<Map> sendData = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
    super.initState();
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
                child: SizedBox(
                  width: width,
                  height: 250.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w,top: 16.w),
                        child: Text("Омборлар рўйхати",style: AppStyle.medium(Colors.black),),
                      ),
                      Expanded(child: ListView.builder(
                        itemCount: wareHouse.length,
                          itemBuilder: (ctx,index){
                        return ListTile(
                          onTap: (){
                            wareHouseId = wareHouse[index].id;
                            wareHouseName = wareHouse[index].name;
                            _repository.clearSkladBase();
                            skladBloc.getAllSklad(dateTime.year, dateTime.month,wareHouseId);
                            setState(() {});
                            Navigator.pop(context);
                          },
                          title: Text(wareHouse[index].name),
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
              }, icon: const Icon(Icons.filter_list)),
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
                    pageBuilder: (_, __, ___) =>  const WareHouseSearch(),
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
        child: StreamBuilder<List<SkladResult>>(
          stream: skladBloc.getSkladStream,
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
              return data.isEmpty?const EmptyWidgetScreen():
              Column(
                children: [
                  Expanded(child: ListView.builder(
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name,maxLines:2,style: AppStyle.mediumBold(Colors.black),),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            data[index].snarhi != 0?Text("${priceFormat.format(data[index].snarhi)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data[index].snarhiS)} \$",style: AppStyle.medium(Colors.black),),
                                            Text(priceFormatUsd.format(data[index].osoni),style: AppStyle.medium(Colors.black),),
                                          ],
                                        )
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name,maxLines:2,style: AppStyle.mediumBold(Colors.black),),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            data[index].snarhi != 0?Text("${priceFormat.format(data[index].snarhi)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data[index].snarhiS)} \$",style: AppStyle.medium(Colors.black),),
                                            Text(priceFormatUsd.format(data[index].osoni),style: AppStyle.medium(Colors.black),),
                                          ],
                                        )
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
                      })),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    width: width,
                    height: 60.h,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: Colors.grey
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Жами товар:",style: AppStyle.medium(Colors.black),),
                        Text("$productCount дона",style: AppStyle.medium(Colors.black),)
                      ],
                    ),
                  )
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("Филтрлаш",style: AppStyle.large(Colors.grey),),
              ),
              Expanded(child: ListView.builder(
                itemCount: filterProduct!.length,
                  itemBuilder: (ctx,index){
                return ListTile(
                  selected: filterProduct![index].id==filterId?true:false,
                  selectedColor: AppColors.white,
                  selectedTileColor: Colors.green.shade500,
                  title: Text(filterProduct![index].name),
                  onTap: (){
                    filterId=filterProduct![index].id;
                    setState(() {});
                  },
                );
              })),
              TextButton(onPressed: (){
                filterId = -1;
                setState(() {});
              }, child: Text("Фильтрни тозалаш",style: AppStyle.medium(Colors.red),))
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin),
        child: FloatingActionButton(
          onPressed: (){
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
          },
          backgroundColor: AppColors.green,
          child: const Icon(Icons.calendar_month,color: Colors.white,),
        ),
      ),
    );
  }
}

