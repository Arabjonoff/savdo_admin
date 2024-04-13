import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/sklad/sklad_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/product/product_image/image_preview.dart';
import 'package:savdo_admin/src/ui/drawer/warehouse/warehouse_transfer/warehouse_to_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/bottom_menu/product_bottom_menu.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class WareHouseFromScreen extends StatefulWidget {
  final Map<String,dynamic> data;
  const WareHouseFromScreen({super.key, required this.data});

  @override
  State<WareHouseFromScreen> createState() => _WareHouseFromScreenState();
}

class _WareHouseFromScreenState extends State<WareHouseFromScreen> {
  final Repository _repository = Repository();
  int wareHouseId = 1,filterId = -1;
  num price = 0;
  num idPrice = 0;
  int priceUsd = 0;
  String wareHouseName = 'Асосий омбор';
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  List<ProductTypeAllResult> filterProduct=[ProductTypeAllResult(id: 0, name: '', st: 0)];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) =>skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,widget.data['warehouseFromId'],''));
    super.initState();
  }
  @override
  void dispose() {
    _repository.clearIncomeProductBase();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: ()async{
                filterProduct = await _repository.getProductTypeBase();
                scaffoldKey.currentState!.openEndDrawer();
                setState(() {});
              }, icon: const Icon(Icons.filter_list)),
        ],
        title: Text(widget.data['warehouseFromName']),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: Padding(
            padding:EdgeInsets.only(left: 8.0.w,right: 8.0.w,bottom: 8.0.w,),
            child: CupertinoSearchTextField(
              placeholder: "Излаш",
              onChanged: (i){
                skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,widget.data['warehouseFromId'],i);
              },
            ),
          ),
        ),
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
        grabbingHeight: 60.h,
        // TODO: Add your grabbing widget here,
        grabbing: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius:  const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
          ),
          child: Row(
            children: [
              SizedBox(width: 16.w,),
              Text(widget.data['warehouseFromName'].toUpperCase(),style: AppStyle.smallBold(Colors.white),),
              const Expanded(child: Icon(Icons.repeat_sharp,color: Colors.white,)),
              Text(widget.data['warehouseToName'].toUpperCase(),style: AppStyle.smallBold(Colors.white),),
              SizedBox(width: 16.w,),
            ],
          ),
        ),
        sheetBelow: SnappingSheetContent(
          draggable: (details) => true,
          // TODO: Add your sheet content here
          child: WareHouseToScreen(data: widget.data,),
        ),
        child: RefreshIndicator(
          onRefresh: ()async{
            _repository.clearSkladBase();
            skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,widget.data['warehouseFromId'],'');
          },
          child: StreamBuilder<List<SkladResult>>(
              stream: skladBloc.getSkladSearchStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  var data = snapshot.data!;
                  if (data.isEmpty) {
                    return const Center(child: EmptyWidgetScreen());
                  }
                  else {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx,index){
                        if(data[index].idTip==filterId){
                          return data[index].osoni<=0?const SizedBox():GestureDetector(
                            onTap: (){
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
                                showModalBottomSheet(
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (ctx){
                                      return ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: ProductBottomMenuDialog(data: data[index], price: price, priceUsd: priceUsd, doc: widget.data, priceType:data[index].snarhi != 0?0:1,));
                                    });
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
                        else if(filterId == -1){
                          return data[index].osoni<=0?const SizedBox():GestureDetector(
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
                                showModalBottomSheet(
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (ctx){
                                      return ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: ProductBottomMenuDialog(data: data[index], price: price, priceUsd: priceUsd, doc: widget.data,priceType:data[index].snarhi != 0?0:1));
                                    });
                              }
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
                          return const EmptyWidgetScreen();
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
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("Филтрлаш",style: AppStyle.large(Colors.grey),),
              ),
              Expanded(child: ListView.builder(
                  itemCount: filterProduct.length,
                  itemBuilder: (ctx,index){
                    return ListTile(
                      selected: filterProduct[index].id==filterId?true:false,
                      selectedColor: AppColors.white,
                      selectedTileColor: Colors.green.shade500,
                      title: Text(filterProduct[index].name),
                      onTap: (){
                        filterId=filterProduct[index].id;
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
    );
  }
}
