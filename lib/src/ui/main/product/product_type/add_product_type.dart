import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/product/product_type_bloc.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';

class AddProductTypeScreen extends StatefulWidget {
  const AddProductTypeScreen({super.key});

  @override
  State<AddProductTypeScreen> createState() => _AddProductTypeScreenState();
}

class _AddProductTypeScreenState extends State<AddProductTypeScreen> {
  final TextEditingController _controllerProductType = TextEditingController();
  final Repository _repository = Repository();
  @override
  void initState() {
    productTypeBloc.getProductTypeAll();
    super.initState();
  }
  @override
  void dispose() {
    productTypeBloc.getProductTypeAll();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProductTypeAllResult>>(
        stream: productTypeBloc.getProductTypeStream,
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
                   controller: _controllerProductType,
                   decoration: InputDecoration(
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                     ),
                     hintText: "Маҳсулот тури киритинг",
                     suffixIcon: IconButton(onPressed: ()async{
                       await insertProduct(_controllerProductType.text);
                     },icon: const Icon(Icons.add_circle),),
                   ),
                 ),
               ),
               Expanded(child: ListView.builder(itemCount: data.length,itemBuilder: (ctx,index){
                 return ListTile(
                   contentPadding: EdgeInsets.zero,
                   onTap: (){
                     RxBus.post(data[index].name,tag: 'productType');
                     RxBus.post(data[index].id.toString(),tag: 'productTypeId');
                     Navigator.pop(context);
                   },
                   title: Text(data[index].name,style: AppStyle.medium(Colors.black),),
                   trailing: IconButton(icon: const Icon(Icons.delete,color: Colors.deepOrange,),
                     onPressed: ()async{
                       await deleteProduct(data[index].name,data[index].id);
                   },),
                 );
               }))
             ],
           );
           }
         }return Container(color: Colors.black,);
        }
      ),
    );
  }
  insertProduct(String name)async{
    HttpResult res = await _repository.postProductType(name);
    if(res.result["status"] == true){
      _controllerProductType.clear();
    }
    await _repository.clearProductTypeBase();
    await productTypeBloc.getProductTypeAll();
  }
  deleteProduct(String name,int id)async{
    HttpResult res = await _repository.deleteProductType(name,id);
    if(res.result["status"] == true){
    }
    await _repository.clearProductTypeBase();
    await productTypeBloc.getProductTypeAll();
  }
}
