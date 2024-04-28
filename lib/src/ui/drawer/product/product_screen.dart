// ignore_for_file: use_build_context_synchronously
// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/product/product_barcode.dart';
import 'package:savdo_admin/src/bloc/product/product_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/barcode_model.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/product/product_image/image_preview.dart';
import 'package:savdo_admin/src/ui/drawer/product/product_image/product_image.dart';
import 'package:savdo_admin/src/ui/drawer/product/product_update.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

import 'prdoct_barcode/add_barcode.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final Repository _repository = Repository();
  bool isFindBarcode = false;

  @override
  void initState() {
    productBloc.getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: CupertinoSearchTextField(
          padding: EdgeInsets.only(left: 16.w, bottom: 10.w, top: 10.w),
          suffixIcon:const Icon(Icons.qr_code, size: 30,),
          suffixMode: OverlayVisibilityMode.always,
          onSuffixTap: ()async{
            productBloc.searchProduct('');
            List<Skl2Result> productBase = await _repository.searchProduct('');
            List<BarcodeResult> barcodeBase = await _repository.getBarcodeBase();
            var result = await BarcodeScanner.scan();
            result.rawContent;
            for(int i = 0; i<barcodeBase.length;i++){
              if(barcodeBase[i].shtr == result.rawContent){
                for(int j = 0; j<productBase.length;j++){
                  if(barcodeBase[i].idSkl2 == productBase[j].id){
                    isFindBarcode = true;
                    productBloc.searchProduct(productBase[j].name);
                  }
                }
              }
            }
            if(isFindBarcode==false){
              CenterDialog.showErrorDialog(context, "Топилмади!");
              isFindBarcode = false;
            }
            // productBloc.searchProduct(_controllerBarCode.text);
          },
          placeholder: "Излаш",
          onChanged: (i) {
            productBloc.searchProduct(i);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await _repository.clearProduct();
          await _repository.clearBarcodeBase();
          await productBloc.getAllProduct();
          await barcodeProductBloc.getBarcodeAll();
        },
        child: Column(
          children: [
            Expanded(child: StreamBuilder<List<Skl2Result>>(
                stream: productBloc.getProductStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    if(data.isEmpty){
                      return const EmptyWidgetScreen();
                    }
                    else{
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx, index) {
                            return Slidable(
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SlidableAction(onPressed: (i) async {
                                            CenterDialog.showDeleteDialog(context, ()async{
                                              HttpResult res = await _repository.deleteProduct(data[index].name, data[index].id);
                                              if (res.result["status"] == true) {
                                                await _repository.deleteProductBase(data[index].id);
                                                await productBloc.getAllProduct();
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result["message"])));
                                              }
                                              else {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result["message"]), backgroundColor: Colors.red,));
                                              }
                                            });
                                          }, icon: Icons.delete, label: "Ўчириш",),
                                          SlidableAction(
                                            onPressed: (i) {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (ctx) {
                                                    return UpdateProductScreen(
                                                      id: data[index].id,
                                                      photo: data[index].photo,
                                                      name: data[index].name,
                                                      quantityName: data[index].edizName,
                                                      firmName: data[index].firmName,
                                                      size: data[index].vz,
                                                      minCount: data[index].msoni,
                                                      status: data[index].st,
                                                      productName:data[index].tipName,
                                                      productId: data[index].idTip,
                                                      quantityId: data[index].idEdiz,
                                                      firmId: data[index].idFirma,);
                                                  }));
                                            },
                                            icon: Icons.edit,
                                            label: "Таҳрирлаш",),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SlidableAction(onPressed: (i) {
                                            CenterDialog.showBarcodeDialog(context,
                                                AddBarcodeScreen(idSkl2: data[index].id, name: data[index].name,));
                                          },
                                            icon: Icons.qr_code_scanner,
                                            label: "SHTRIX рақам",),
                                          SlidableAction(
                                            onPressed: (i) {
                                              CenterDialog.showProductTypeDialog(
                                                  context, "Маҳсулот расми",
                                                  ProductImageScreen(idSkl2: data[index].id.toString()));
                                            },
                                            icon: Icons.add_photo_alternate_outlined,
                                            label: "Расим қўшиш",),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    CenterDialog.showImageDialog(context, data[index].name, ImagePreview(photo: data[index].photo,));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: AppColors.card,
                                        border: const Border(bottom: BorderSide(color: Colors.grey)
                                        )
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name.toString(), style: AppStyle.mediumBold(Colors.black),),
                                        SizedBox(height: 8.w,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Ўлчов бирлиги:", style: AppStyle.small(Colors.black),),
                                            Text(data[index].edizName, style: AppStyle.small(Colors.black),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Маҳсулот тури:", style: AppStyle.small(Colors.black),),
                                            Text(data[index].tipName, style: AppStyle.small(Colors.black),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Ишлаб чиқарувчи:", style: AppStyle.small(Colors.black),),
                                            Text(data[index].firmName, style: AppStyle.small(Colors.black),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Мин сони:", style: AppStyle.small(Colors.black),),
                                            Text(data[index].msoni.toString(), style: AppStyle.small(Colors.black),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Вазни:", style: AppStyle.small(Colors.black),),
                                            Text(data[index].vz.toString(), style: AppStyle.small(Colors.black),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          });
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                }
            )),
            ButtonWidget(onTap: (){
              Navigator.pushNamed(context, '/addProduct');
            }, color: AppColors.green, text: "Янги киритиш"),
            SizedBox(height: 34.h,)
          ],
        ),
      ),
    );
  }

}
