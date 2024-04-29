// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/product/product_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/product/barcode_model.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/income/add_income_screen.dart';
import 'package:savdo_admin/src/ui/drawer/income/cart/cart_income.dart';
import 'package:savdo_admin/src/ui/drawer/product/product_image/image_preview.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class IncomeListScreen extends StatefulWidget {
  final dynamic id;
  const IncomeListScreen({super.key, required this.id});
  @override
  State<IncomeListScreen> createState() => _IncomeListScreenState();
}

class _IncomeListScreenState extends State<IncomeListScreen> {

  String db = CacheService.getDb();
  final Repository _repository = Repository();
  final TextEditingController _controllerBarCode = TextEditingController();
  @override
  void initState() {
     db = CacheService.getDb();
    productBloc.getAllProduct();
    super.initState();
  }
  @override
  void dispose() {
    productBloc.getAllProduct();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: _controllerBarCode,
          suffixIcon:const Icon(Icons.qr_code_scanner, size: 30,),
          suffixMode: OverlayVisibilityMode.always,
          onSuffixTap: ()async{
            List<Skl2Result> productBase = await _repository.searchProduct('');
            List<BarcodeResult> barcodeBase = await _repository.getBarcodeBase();
            var result = await BarcodeScanner.scan();
            result.rawContent;
            for(int i = 0; i<barcodeBase.length;i++){
              if(barcodeBase[i].shtr == result.rawContent){
                for(int j = 0; j<productBase.length;j++){
                  if(barcodeBase[i].idSkl2 == productBase[j].id){
                    productBloc.searchProduct(productBase[j].name);
                  }
                }
              }
            }
          },
          padding: EdgeInsets.only(left: 16.w, bottom: 10.w, top: 10.w),
          placeholder: "Излаш",
          onChanged: (i) {
            productBloc.searchProduct(i);
          },
        ),
        // actions: [
        //   IconButton(onPressed: ()async{
        //     productTypeBloc.getProductTypeAll();
        //     // _scaffoldKey.currentState!.openEndDrawer();
        //   }, icon: const Icon(Icons.filter_list))
        // ],
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
        grabbingHeight: 75.h,
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
              Text("Юқорига суринг",style: AppStyle.mediumBold(Colors.white),),
              const Icon(Icons.swipe_up_rounded,color: Colors.white,)
            ],
          ),
        ),
        sheetBelow: SnappingSheetContent(
          draggable: (details) => true,
          child: CartIncomeScreen(idSklPr: widget.id,),
        ),
        child: StreamBuilder<List<Skl2Result>>(
          stream: productBloc.getProductStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                  itemBuilder: (ctx,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return AddIncomeScreen(data: data[index], id: widget.id, isUpdate: false,);
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 4.h),
                    width: MediaQuery.of(context).size.width,
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
                          child: Hero(
                            tag: data[index].name,
                            child: Container(
                              width: 70.r,
                              height: 70.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: data[index].photo.isEmpty?const Icon(Icons.error_outline):CachedNetworkImage(imageUrl: 'https://naqshsoft.site/images/$db/${data[index].photo}',fit: BoxFit.cover, placeholder: (context, url) => const Center(child: CircularProgressIndicator()), errorWidget: (context, url, error) =>  const Icon(Icons.error_outline,),),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w,),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index].name,style: AppStyle.medium(Colors.black),),
                                SizedBox(height: 8.w,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Ишлаб чиқарувчи:",style: AppStyle.small(Colors.black),),
                                    Text(data[index].firmName,style: AppStyle.small(Colors.black),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Ўлчов бирлиги:",style: AppStyle.small(Colors.black),),
                                    Text(data[index].edizName,style: AppStyle.small(Colors.black),),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              });
            }return const SizedBox();
          }
        ),
      ),
      // endDrawer: Drawer(
      //   shape: const RoundedRectangleBorder(),
      //   backgroundColor: AppColors.background,
      //   child: SafeArea(
      //     child: StreamBuilder<List<ProductTypeAllResult>>(
      //       stream: productTypeBloc.getProductTypeStream,
      //       builder: (context, snapshot) {
      //         if(snapshot.hasData){
      //           var data = snapshot.data!;
      //           return ListView.builder(
      //             itemCount: data.length,
      //               itemBuilder: (ctx,index){
      //             return ListTile(
      //               title: Text(data[index].name),
      //             );
      //           });
      //         }return TextButton(onPressed: (){
      //           productTypeBloc.getProductTypeAll();
      //         }, child: Text("SS"));
      //       }
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.green,
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (ctx){
      //       return  CartIncomeScreen(idSklPr: widget.id,);
      //     }));
      //   },
      //   child: const Icon(Icons.add_shopping_cart,color: Colors.white,),
      // ),
    );
  }
}
