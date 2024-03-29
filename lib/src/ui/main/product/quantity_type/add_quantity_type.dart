import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/product/product_quantity_bloc.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';

class AddQuantityScreen extends StatefulWidget {
  const AddQuantityScreen({super.key});

  @override
  State<AddQuantityScreen> createState() => _AddQuantityScreenState();
}

class _AddQuantityScreenState extends State<AddQuantityScreen> {
  final Repository _repository = Repository();
  final TextEditingController _controllerQuantityType = TextEditingController();
  @override
  void initState() {
    productQuantityTypeBloc.getQuantityBaseTypeAll();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProductTypeAllResult>>(
          stream: productQuantityTypeBloc.getQuantityTypeStream,
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
                        controller: _controllerQuantityType,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Ўлчов бирлиги киритинг",
                          suffixIcon: IconButton(onPressed: ()async{
                            await insertProductQuantity(_controllerQuantityType.text);
                          },icon: const Icon(Icons.add_circle),),
                        ),
                      ),
                    ),
                    Expanded(child: ListView.builder(itemCount: data.length,itemBuilder: (ctx,index){
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: (){
                          RxBus.post(data[index].name,tag: 'productQuantityName');
                          RxBus.post(data[index].id.toString(),tag: 'productQuantityId');
                          Navigator.pop(context);
                        },
                        title: Text(data[index].name,style: AppStyle.medium(Colors.black),),
                        trailing: IconButton(icon: const Icon(Icons.delete,color: Colors.deepOrange,),
                          onPressed: ()async{
                            await deleteProductQuantity(data[index].name,data[index].id);
                          },),
                      );
                    }))
                  ],
                );
              }
            }return Container();
          }
      ),
    );
  }
  insertProductQuantity(String name)async{
    HttpResult res = await _repository.postQuantityType(name);
    if(res.result["status"] == true){
      _controllerQuantityType.clear();
    }
    await _repository.clearQuantityTypeBase();
    await productQuantityTypeBloc.getQuantityBaseTypeAll();
  }
  deleteProductQuantity(String name,int id)async{
    HttpResult res = await _repository.deleteQuantityType(name,id);
    if(res.result["status"] == true){
    }
    await _repository.clearQuantityTypeBase();
    await productQuantityTypeBloc.getQuantityBaseTypeAll();
  }
}
