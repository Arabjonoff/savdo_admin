// ignore_for_file: use_build_context_synchronously

// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/product/product_barcode.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/barcode_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class AddBarcodeScreen extends StatefulWidget {
  final int idSkl2;
  final String name;
  const AddBarcodeScreen({super.key, required this.idSkl2, required this.name});

  @override
  State<AddBarcodeScreen> createState() => _AddBarcodeScreenState();
}

class _AddBarcodeScreenState extends State<AddBarcodeScreen> {
  @override
  void initState() {
  barcodeProductBloc.getBarcodeDetail(widget.idSkl2);
  super.initState();
  }
  final Repository _repository = Repository();
  final TextEditingController _controllerBarCode = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ШТРИХ рақам киритинг",style: AppStyle.medium(Colors.black),),
                SizedBox(height: 12.h,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 54.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _controllerBarCode,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "ШТРИХ рақам киритинг",
                      suffixIcon:IconButton(onPressed: ()async{
                        var result = await BarcodeScanner.scan();
                        _controllerBarCode.text = result.rawContent;
                        setState(() {});
                      },icon: const Icon(Icons.qr_code_scanner),),
                    ),
                  ),
                ),
                Expanded(child: StreamBuilder<List<BarcodeResult>>(
                  stream: barcodeProductBloc.getBarcodeDetailStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var data = snapshot.data!;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx,index){
                            return ListTile(
                              title: Text(data[index].shtr),
                              trailing: IconButton(onPressed: ()async{
                                HttpResult res = await _repository.deleteBarcode(widget.name, data[index].id);
                                if(res.result['status'] == true){
                                  barcodeProductBloc.getBarcodeDetail(widget.idSkl2);
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result['message'])));
                                }
                              },icon: const Icon(Icons.delete),color: Colors.red,),
                            );
                          });
                    }
                    return const SizedBox();
                  }
                ))
              ],
            ),
          ),
          ButtonWidget(onTap: ()async{
            List<BarcodeResult> barcodeBase = await _repository.getBarcodeBase();
            HttpResult res = await _repository.postBarcode(widget.name, _controllerBarCode.text, widget.idSkl2);
            if(res.result["status"]==true){
              var data = {
                "ID": barcodeBase.last.id+1,
                "NAME": widget.name,
                "SHTR":  _controllerBarCode.text,
                "ID_SKL2": widget.idSkl2,
                "VAQT": DateFormat('yyyy-MM-dd').format(DateTime.now()),
          };
              await _repository.saveBarcodeBase(BarcodeResult.fromJson(data));
              _controllerBarCode.clear();
              barcodeProductBloc.getBarcodeDetail(widget.idSkl2);
              await barcodeProductBloc.getBarcodeAll();
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result['message'])));
            }
          }, color: AppColors.green, text: "Сақалш")
        ],
      ),
    );
  }
}
