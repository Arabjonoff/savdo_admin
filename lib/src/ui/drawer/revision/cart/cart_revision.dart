import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/returned/returned_bloc.dart';
import 'package:savdo_admin/src/bloc/revision/cart/cart_revision_bloc.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

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
    Repository repository = Repository();
    return Scaffold(
      body: StreamBuilder<List<Map<String,Object>>>(
        stream: cartRevision.getRevisionStream,
        builder: (context, snapshot) {
         if(snapshot.hasData){
           var data = snapshot.data!;
           return Column(
             children: [
               Expanded(
                 child: ListView.builder(
                   itemCount: data.length,
                     itemBuilder: (ctx,index){
                       return Slidable(
                         endActionPane: ActionPane(
                           motion: const ScrollMotion(),
                           children: [
                             SlidableAction(
                               backgroundColor: Colors.red,
                               onPressed: (i)async{
                                 await repository.deleteRevisionBase(data[index]['ID']);
                                 await cartRevision.getAllRevisionCart();
                                 // await returnBloc.getReturnedAll(DateTime.now().year, DateTime.now().month, CacheService.getWareHouseId());
                               },
                               icon: Icons.delete,
                             )
                           ],
                         ),
                           child: ListTile(
                         trailing: Text(priceFormatUsd.format(data[index]['N_SONI']),style: AppStyle.medium(Colors.black)),
                         title: Text(data[index]['NAME'].toString(),style: AppStyle.medium(Colors.black),),));
                     }),
               ),
               ButtonWidget(onTap: (){
                 repository.postRevision(data);
               }, color: AppColors.green, text: "Сақлаш"),
               SizedBox(height: 34.r,)
             ],
           );
         }return const SizedBox();
        }
      ),
    );
  }
}
