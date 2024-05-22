import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/permission.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/agent_permission_model.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class AgentPermissionScreen extends StatefulWidget {
  final AgentsResult data;
  const AgentPermissionScreen({super.key, required this.data});

  @override
  State<AgentPermissionScreen> createState() => _AgentPermissionScreenState();
}

class _AgentPermissionScreenState extends State<AgentPermissionScreen> {
  @override
  void initState() {
    agentPermission.getAllAgentPermission(widget.data.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.data.name),
      ),
      body: StreamBuilder<AgentPermissionModel>(
        stream: agentPermission.getAgentPermissionStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: ListTile(
                            title:Text("Харидорга боғланмасин",style: AppStyle.medium(Colors.black),),
                            onTap: (){
                              if(data.harid ==0){
                                data.harid=1;
                              }
                              else{
                                data.harid=0;
                              }
                              setState(() {});
                            },
                            trailing:Icon(Icons.radio_button_checked,color: data.harid ==1?Colors.green:Colors.grey,),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: ListTile(
                            title:Text("Валюта курсни кўриш",style: AppStyle.medium(Colors.black),),
                            onTap: (){
                              if(data.kurs == 0){
                                data.kurs=1;
                              }
                              else{
                                data.kurs = 0;
                              }
                              setState(() {});
                            },
                            trailing:Icon(Icons.radio_button_checked,color: data.kurs ==1?Colors.green:Colors.grey,),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()async{
                            List<ProductTypeAllResult> wareHouse = await repository.getWareHouseBase();
                            // ignore: use_build_context_synchronously
                            showDialog(context: context, builder: (ctx){
                              return Dialog(
                                insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250.h,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 16.w,top: 16.w),
                                        child: Text("Омборлар рўйхати",style: AppStyle.mediumBold(Colors.black),),
                                      ),
                                      Expanded(
                                          child: ListView.builder(
                                          itemCount: wareHouse.length,
                                          itemBuilder: (ctx,index){
                                            return ListTile(
                                              onTap: () async {
                                                data.idSkl = wareHouse[index].id;
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                              title: Text(wareHouse[index].name,style: AppStyle.medium(Colors.black),),
                                              trailing:Icon(Icons.radio_button_checked,color: wareHouse[index].id == data.idSkl?Colors.green:Colors.grey,),
                                            );
                                          })),
                                      TextButton(onPressed: (){
                                        data.skl = 0;
                                        data.idSkl = -1;
                                        setState(() {});
                                        Navigator.pop(context);
                                      }, child: Text("Барча омборларни кўриш"))
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: ListTile(
                              trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                              title: Text("Омборга боғлаш",style: AppStyle.medium(Colors.black)),)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: ExpansionTile(
                            shape: const Border(),
                            title: Text("Сотиш нархига боғлаш",style: AppStyle.medium(Colors.black),),
                            children: [
                              ListTile(
                                title:Text("1 - Сотиш нархи",style: AppStyle.smallBold(Colors.black),),
                                onTap: (){
                                  data.snarhi = 1;
                                  setState(() {});
                                },
                                trailing:Icon(Icons.radio_button_checked,color: data.snarhi ==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                title:Text("2 - Сотиш нархи",style: AppStyle.smallBold(Colors.black),),
                                onTap: (){
                                  data.snarhi = 2;
                                  setState(() {});
                                },
                                trailing:Icon(Icons.radio_button_checked,color: data.snarhi ==2?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                title:Text("3 - Сотиш нархи",style: AppStyle.smallBold(Colors.black),),
                                onTap: (){
                                  data.snarhi = 3;
                                  setState(() {});
                                },
                                trailing:Icon(Icons.radio_button_checked,color: data.snarhi ==3?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                title:Text("Ҳеч қайси",style: AppStyle.smallBold(Colors.black),),
                                onTap: (){
                                  data.snarhi = 0;
                                  setState(() {});
                                },
                                trailing:Icon(Icons.radio_button_checked,color: data.snarhi ==0?Colors.green:Colors.grey,),
                              ),
                            ],
                          ),),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: ExpansionTile(
                            shape: const Border(),
                            title: Text("Харидорлар",style: AppStyle.medium(Colors.black),),
                            children: [
                              ListTile(
                                onTap: (){
                                  if(data.hrdD1 ==0){
                                    data.hrdD1 =1;
                                  }
                                  else{
                                    data.hrdD1 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Кўриш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.hrdD1==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.hrdD2 ==0){
                                    data.hrdD2 =1;
                                  }
                                  else{
                                    data.hrdD2 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Янги киритиш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.hrdD2==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.hrdD3 ==0){
                                    data.hrdD3 =1;
                                  }
                                  else{
                                    data.hrdD3 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Таҳрирлаш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.hrdD3==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.hrdD4 ==0){
                                    data.hrdD4 =1;
                                  }
                                  else{
                                    data.hrdD4 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Ўчириш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.hrdD4==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.hrdD5 ==0){
                                    data.hrdD5 =1;
                                  }
                                  else{
                                    data.hrdD5 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Қарздорлик маълумотлари",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.hrdD5==1?Colors.green:Colors.grey,),
                              ),
                            ],
                          ),),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: ExpansionTile(
                            shape: const Border(),
                            title: Text("Чиқимлар (ҳисоб-фактура)",style: AppStyle.medium(Colors.black),),
                            children: [
                              ListTile(
                                onTap: (){
                                  if(data.chkD1 ==0){
                                    data.chkD1 =1;
                                  }
                                  else{
                                    data.chkD1 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Кўриш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.chkD1==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.chkD2 ==0){
                                    data.chkD2 =1;
                                  }
                                  else{
                                    data.chkD2 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Янги киритиш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.chkD2==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.chkD3 ==0){
                                    data.chkD3 =1;
                                  }
                                  else{
                                    data.chkD3 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Таҳрирлаш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.chkD3==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.chkD4 ==0){
                                    data.chkD4 =1;
                                  }
                                  else{
                                    data.chkD4 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Ўчириш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.chkD4==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.chkD5 ==0){
                                    data.chkD5 =1;
                                  }
                                  else{
                                    data.chkD5 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Қулфлаш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.chkD5==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.chkD6 ==0){
                                    data.chkD6 =1;
                                  }
                                  else{
                                    data.chkD6 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Сотиш нархини ўзгартириш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.chkD6==1?Colors.green:Colors.grey,),
                              ),
                            ],
                          ),),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: ExpansionTile(
                            shape: const Border(),
                            title: Text("Қайтарилди",style: AppStyle.medium(Colors.black),),
                            children: [
                              ListTile(
                                onTap: (){
                                  if(data.vozD1 ==0){
                                    data.vozD1 =1;
                                  }
                                  else{
                                    data.vozD1 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Кўриш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.vozD1==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.vozD2 ==0){
                                    data.vozD2 =1;
                                  }
                                  else{
                                    data.vozD2 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Янги киритиш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.vozD2==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.vozD3 ==0){
                                    data.vozD3 =1;
                                  }
                                  else{
                                    data.vozD3 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Таҳрирлаш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.vozD3==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.vozD4 ==0){
                                    data.vozD4 =1;
                                  }
                                  else{
                                    data.vozD4 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Ўчириш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.vozD4==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.vozD5 ==0){
                                    data.vozD5 =1;
                                  }
                                  else{
                                    data.vozD5 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Қулфлаш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.vozD5==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.vozD6 ==0){
                                    data.vozD6 =1;
                                  }
                                  else{
                                    data.vozD6 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Сотиш нархини ўзгартириш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.vozD6==1?Colors.green:Colors.grey,),
                              ),
                            ],
                          ),),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: ExpansionTile(
                            shape: const Border(),
                            title: Text("Тўловлар",style: AppStyle.medium(Colors.black),),
                            children: [
                              ListTile(
                                onTap: (){
                                  if(data.tlD1 ==0){
                                    data.tlD1 =1;
                                  }
                                  else{
                                    data.tlD1 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Кўриш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.tlD1==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.tlD2 ==0){
                                    data.tlD2 =1;
                                  }
                                  else{
                                    data.tlD2 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Янги киритиш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.tlD2==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.tlD3 ==0){
                                    data.tlD3 =1;
                                  }
                                  else{
                                    data.tlD3 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Таҳрирлаш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.tlD3==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.tlD4 ==0){
                                    data.tlD4 =1;
                                  }
                                  else{
                                    data.tlD4 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Ўчириш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.tlD4==1?Colors.green:Colors.grey,),
                              ),
                              ListTile(
                                onTap: (){
                                  if(data.tlD5 ==0){
                                    data.tlD5 =1;
                                  }
                                  else{
                                    data.tlD5 =0;
                                  }
                                  setState(() {});
                                },
                                title:Text("Қулфлаш",style: AppStyle.smallBold(Colors.black),),
                                trailing: Icon(Icons.radio_button_checked,color: data.tlD5==1?Colors.green:Colors.grey,),
                              ),
                            ],
                          ),),
                      ],
                    ),
                  ),
                ),
                ButtonWidget(onTap: ()async{
                  CenterDialog.showLoadingDialog(context, '');
                  Map map = {
                    "SNARHI": data.snarhi,
                    "ID_NARH": data.idNarh,
                    "SKL": data.skl,
                    "ID_SKL": data.idSkl,
                    "KURS": data.kurs,
                    "SMS": data.sms,
                    "HRD_D1": data.hrdD1,
                    "HRD_D2": data.hrdD2,
                    "HRD_D3": data.hrdD3,
                    "HRD_D4": data.hrdD4,
                    "HRD_D5": data.hrdD5,
                    "CHK_D1": data.chkD1,
                    "CHK_D2": data.chkD2,
                    "CHK_D3": data.chkD3,
                    "CHK_D4": data.chkD4,
                    "CHK_D5": data.chkD5,
                    "CHK_D6": data.chkD6,
                    "CHK_D7": data.chkD7,
                    "CHK_D8": data.chkD8,
                    "VOZ_D1": data.vozD1,
                    "VOZ_D2": data.vozD2,
                    "VOZ_D3": data.vozD3,
                    "VOZ_D4": data.vozD4,
                    "VOZ_D5": data.vozD5,
                    "VOZ_D6": data.vozD6,
                    "VOZ_D7": data.vozD7,
                    "TL_D1": data.tlD1,
                    "TL_D2": data.tlD2,
                    "TL_D3": data.tlD3,
                    "TL_D4": data.tlD4,
                    "TL_D5": data.tlD5,
                    "TL_D6": data.tlD6,
                    "HARID": data.harid,
                  };
                  HttpResult res = await repository.postAgentPermission(map, widget.data.id);
                  if(res.result['status']){
                    if(context.mounted)Navigator.pop(context);
                    CenterDialog.showSuccessDialog(context);
                  }else{
                    if(context.mounted)Navigator.pop(context);
                    CenterDialog.showErrorDialog(context, res.result['message']);
                  }
                }, color: AppColors.green, text: "Рухсатларни сақлаш"),
                SizedBox(height: 34.h,),
              ],
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}
