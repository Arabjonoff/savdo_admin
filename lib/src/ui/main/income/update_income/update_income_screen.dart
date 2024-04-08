import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/skl_pr_tov_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/income/income_model.dart';
import 'package:savdo_admin/src/model/product/barcode_model.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/income/add_income_screen.dart';
import 'package:savdo_admin/src/ui/main/income/update_income/cart_update_income.dart';
import 'package:savdo_admin/src/ui/main/product/product_image/image_preview.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class UpdateIncomeScreen extends StatefulWidget {
  final IncomeResult data;
  const UpdateIncomeScreen({super.key, required this.data});

  @override
  State<UpdateIncomeScreen> createState() => _UpdateIncomeScreenState();
}

class _UpdateIncomeScreenState extends State<UpdateIncomeScreen> {
  final TextEditingController _controllerBarCode = TextEditingController();
  final Repository _repository = Repository();
  @override
  void initState() {
    productBloc.getAllProduct();
    super.initState();
  }
  @override
  void dispose() {
    _repository.clearIncomeProductBase();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("№ ${widget.data.ndoc}"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.spMax),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 4.h),
            child: CupertinoSearchTextField(
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
        grabbingHeight: 75.h,
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
              Text("Юқорига суринг",style: AppStyle.mediumBold(Colors.white),),
              const Icon(Icons.swipe_up_rounded,color: Colors.white,)
            ],
          ),
        ),
        sheetBelow: SnappingSheetContent(
          draggable: (details) => true,
          // TODO: Add your sheet content here
          child: CartUpdateIncomeScreen(data: widget.data),
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
                            return AddIncomeScreen(data: data[index], id: widget.data.id, isUpdate: true,);
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 4.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.shade400
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
                                          Text("Ишлаб чиқарувчи:",style: AppStyle.small(Colors.black54),),
                                          Text(data[index].firmName,style: AppStyle.small(Colors.black54),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Ўлчов бирлиги:",style: AppStyle.small(Colors.black54),),
                                          Text(data[index].edizName,style: AppStyle.small(Colors.black54),),
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
    );
  }
}
