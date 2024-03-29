import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/product/product_firma_bloc.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';

class AddProductFirmaScreen extends StatefulWidget {
  const AddProductFirmaScreen({super.key});

  @override
  State<AddProductFirmaScreen> createState() => _AddProductFirmaScreenState();
}

class _AddProductFirmaScreenState extends State<AddProductFirmaScreen> {
  final TextEditingController _controllerFirmaType = TextEditingController();
  final Repository _repository = Repository();
  @override
  void initState() {
    productFirmaTypeBloc.getFirmaBaseTypeAll();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProductTypeAllResult>>(
          stream: productFirmaTypeBloc.getFirmaTypeStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var data = snapshot.data!;
              if (data.isEmpty) {
                return Center(child: Text("Маълумотлар йўқ",style: AppStyle.medium(Colors.black),));
              } else {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 54.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _controllerFirmaType,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "фирма киритинг",
                          suffixIcon: IconButton(onPressed: ()async{
                            await insertProductFirma(_controllerFirmaType.text);
                          },icon: const Icon(Icons.add_circle),),
                        ),
                      ),
                    ),
                    Expanded(child: ListView.builder(itemCount: data.length,itemBuilder: (ctx,index){
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: (){
                          RxBus.post(data[index].name,tag: 'productFirmaName');
                          RxBus.post(data[index].id.toString(),tag: 'productFirmaId');
                          Navigator.pop(context);
                        },
                        title: Text(data[index].name,style: AppStyle.medium(Colors.black),),
                        trailing: IconButton(icon: const Icon(Icons.delete,color: Colors.deepOrange,),
                          onPressed: ()async{
                            await deleteProductFirma(data[index].name,data[index].id);
                          },),
                      );
                    }))
                  ],
                );
              }
            }return const SizedBox();
          }
      ),
    );
  }
  insertProductFirma(String name)async{
    HttpResult res = await _repository.postFirmaType(name);
    if(res.result["status"] == true){
      _controllerFirmaType.clear();
    }
    await _repository.clearFirmaTypeBase();
    await productFirmaTypeBloc.getFirmaBaseTypeAll();
  }
  deleteProductFirma(String name,int id)async{
    HttpResult res = await _repository.deleteFirmaType(name,id);
    if(res.result["status"] == true){
    }
    await _repository.clearFirmaTypeBase();
    await productFirmaTypeBloc.getFirmaBaseTypeAll();
  }
}
