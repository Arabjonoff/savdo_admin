import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  void initState() {
    clientBloc.getAllClient('');
    super.initState();
  }
  int weekday = DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            width: 100,
            height: 4.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ClientResult>>(
              stream: clientBloc.getClientStream,
              builder: (context, snapshot) {
               if(snapshot.hasData){
                 var data = snapshot.data!;
                 return ListView.builder(
                   itemCount: data.length,
                     itemBuilder: (ctx,index){
                     if(weekday==1&&data[index].h1==1){
                       return Container(
                         margin: EdgeInsets.symmetric(vertical: 8.h),
                         height: 50.r,
                         width: width,
                         child: ListTile(
                           title: Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                         ),
                       );
                     }
                     if(weekday==2&&data[index].h2==1){
                       return Container(
                         margin: EdgeInsets.symmetric(vertical: 8.h),
                         height: 50.r,
                         width: width,
                         child: ListTile(
                           title: Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                         ),
                       );
                     }
                     if(weekday==3&&data[index].h3==1){
                       return Container(
                         margin: EdgeInsets.symmetric(vertical: 8.h),
                         height: 50.r,
                         width: width,
                         child: ListTile(
                           title: Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                         ),
                       );
                     }
                     if(weekday==4&&data[index].h4==1){
                       return Container(
                         margin: EdgeInsets.symmetric(vertical: 8.h),
                         height: 50.r,
                         width: width,
                         child: ListTile(
                           title: Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                         ),
                       );
                     }
                     if(weekday==5&&data[index].h5==1){
                       return Container(
                         margin: EdgeInsets.symmetric(vertical: 8.h),
                         height: 50.r,
                         width: width,
                         child: ListTile(
                           title: Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                         ),
                       );
                     }
                     if(weekday==6&&data[index].h6==1){
                       return Container(
                         margin: EdgeInsets.symmetric(vertical: 8.h),
                         height: 50.r,
                         width: width,
                         child: ListTile(
                           title: Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                         ),
                       );
                     }
                     else{
                       return Container(
                         margin: EdgeInsets.symmetric(vertical: 8.h),
                         height: 50.r,
                         width: width,
                         child: ListTile(
                           title: Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                         ),
                       );
                     }
                     });
               }
               return SizedBox();
              }
            ),
          ),
        ],
      )
    );
  }
}
