import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/client/debt_client_bloc.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/client/debtbook/debtbook_detail.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

class DebtBookScreen extends StatefulWidget {
  const DebtBookScreen({super.key});

  @override
  State<DebtBookScreen> createState() => _DebtBookScreenState();
}

class _DebtBookScreenState extends State<DebtBookScreen> {
  @override
  void initState() {
    clientDebtBloc.getAllClientDebt();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
        elevation: 0,
        title: const Text("Қарздорлик китоби")
      ),
      body: StreamBuilder<List<DebtClientModel>>(
        stream: clientDebtBloc.getClientDebtStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return DebtBookDetail();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.r,horizontal: 16.w),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.shade300
                          )
                      ),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        child: Text(data[index].name[0]),
                      ),
                      SizedBox(width: 8.w,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                          Row(
                            children: [
                              Text("${priceFormat.format(data[index].osK)} сўм",style: AppStyle.medium(data[index].osK.toString()[0] =='-'?Colors.red:Colors.green),),
                              Text(" | ",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormatUsd.format(data[index].osKS)} \$",style: AppStyle.medium(data[index].osKS.toString()[0] =='-'?Colors.red:Colors.green),),
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              );
            });
          }return const EmptyWidgetScreen();
        }
      )
    );
  }
}
