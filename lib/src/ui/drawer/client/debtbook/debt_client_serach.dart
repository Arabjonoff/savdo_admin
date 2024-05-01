import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/client/debt_client_bloc.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/client/debtbook/debtbook_detail.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

class SearchDebtClient extends StatefulWidget {
  const SearchDebtClient({super.key});

  @override
  State<SearchDebtClient> createState() => _SearchDebtClientState();
}

class _SearchDebtClientState extends State<SearchDebtClient> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    clientDebtBloc.getAllClientDebtSearch('');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          autofocus: true,
          controller: _controller,
          placeholder: "Излаш",
          onChanged: (i){
            clientDebtBloc.getAllClientDebtSearch(i);
          },
        ),
      ),
      body: StreamBuilder<List<DebtClientModel>>(
        stream: clientDebtBloc.getClientDebtSearchStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return DebtBookDetail(data: data[index], idT: data[index].idToch, name: data[index].name,);
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade300
                              )
                          ),
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                                color: AppColors.green,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5)
                                )
                            ),
                            child: Text(data[index].agentName,style: AppStyle.small(Colors.white),),
                          ),
                          SizedBox(height: 8.h,),
                          Row(
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
                          SizedBox(height: 12.h,),
                        ],
                      ),
                    ),
                  );
                });
          }else{
            return const EmptyWidgetScreen();
          }
        }
      ),
    );
  }
}
