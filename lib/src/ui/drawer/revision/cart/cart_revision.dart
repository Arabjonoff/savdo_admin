import 'package:flutter/material.dart';
import 'package:savdo_admin/src/bloc/revision/cart/cart_revision_bloc.dart';

class CartRevisionScreen extends StatefulWidget {
  const CartRevisionScreen({super.key});

  @override
  State<CartRevisionScreen> createState() => _CartRevisionScreenState();
}

class _CartRevisionScreenState extends State<CartRevisionScreen> {
  @override
  void initState() {
    cartRevision.getAllRevisionCart();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String,Object>>>(
        stream: cartRevision.getRevisionStream,
        builder: (context, snapshot) {
         if(snapshot.hasData){
           var data = snapshot.data!;
           return ListView.builder(
             itemCount: data.length,
               itemBuilder: (ctx,index){
                 return ListTile(title: Text(data[index].values.toString()),);
               });
         }return const SizedBox();
        }
      ),
    );
  }
}
