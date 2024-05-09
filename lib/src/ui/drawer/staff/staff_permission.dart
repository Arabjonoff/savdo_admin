import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/permission.dart';
import 'package:savdo_admin/src/model/client/agent_permission_model.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';

class StaffPermissionScreen extends StatefulWidget {
  final AgentsResult data;
  const StaffPermissionScreen({super.key, required this.data});

  @override
  State<StaffPermissionScreen> createState() => _StaffPermissionScreenState();
}

class _StaffPermissionScreenState extends State<StaffPermissionScreen> {
  bool product = false,productAdd = false,productEdit = false,productDelete = false;
  int productId = 0,productAddId = 0,productEditId = 0,productDeleteId = 0;
  @override
  void initState() {
    staffPermission.getAllStaffPermission(widget.data.id);
    super.initState();
  }
  List<Map> permissionList = [
  ];
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title:  Text(widget.data.name),
      ),
      body: StreamBuilder<List<StaffPermissionResult>>(
        stream: staffPermission.getStaffPermissionStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return Column(
            children: [
              Expanded(
                child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx,index){
                    return lisTile(data[index],data[index].tp);
                  }),
              ),
              ButtonWidget(onTap: ()async{
                for(int i=0;i<data.length;i++){
                  if(data[i].tp==1){
                    permissionList.add({
                      "TP":1,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==2){
                    permissionList.add({
                      "TP":2,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==3){
                    permissionList.add({
                      "TP":3,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==4){
                    permissionList.add({
                      "TP":4,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==5){
                    permissionList.add({
                      "TP":5,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==6){
                    permissionList.add({
                      "TP":6,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==7){
                    permissionList.add({
                      "TP":7,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==8){
                    permissionList.add({
                      "TP":8,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==9){
                    permissionList.add({
                      "TP":9,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==10){
                    permissionList.add({
                      "TP":10,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==11){
                    permissionList.add({
                      "TP":11,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==12){
                    permissionList.add({
                      "TP":12,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==13){
                    permissionList.add({
                      "TP":13,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==14){
                    permissionList.add({
                      "TP":14,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==15){
                    permissionList.add({
                      "TP":15,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==16){
                    permissionList.add({
                      "TP":16,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==17){
                    permissionList.add({
                      "TP":17,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==18){
                    permissionList.add({
                      "TP":18,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==19){
                    permissionList.add({
                      "TP":19,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==20){
                    permissionList.add({
                      "TP":20,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==21){
                    permissionList.add({
                      "TP":21,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                  else if(data[i].tp==22){
                    permissionList.add({
                      "TP":22,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,

                    });
                  }
                  else if(data[i].tp==23){
                    permissionList.add({
                      "TP":23,
                      "P1":data[i].p1,
                      "P2":data[i].p2,
                      "P3":data[i].p3,
                      "P4":data[i].p4,
                      "P5":data[i].p5,
                    });
                  }
                }
                await repository.postStaffPermission(permissionList,widget.data.id);
              }, color: AppColors.green, text: "Рухсатларни сақлаш"),
              SizedBox(height: 34.h,)
            ],
          );
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
  Widget lisTile(StaffPermissionResult data ,int tp){
    switch(tp){
      case 1:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Картатека',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                    permissionList.add({
                      "P1":0,
                    });
                  }else{
                    data.p1 = 1;
                    permissionList.add({
                      "ID":widget.data.id,
                      "P1":1,
                    });
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш ",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 2:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Омборга кирим',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш ",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Кирим Нархи",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p5 ==1){
                    data.p5 = 0;
                  }else{
                    data.p5 = 1;
                  }
                  setState(() {});
                },child: Text(data.p5==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p5==1?AppColors.green:Colors.red),),),
              ),
            ],

          ),
        );
      case 3:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Омбордан чиким',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш ",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Кирим Нархи",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p5 ==1){
                    data.p5 = 0;
                  }else{
                    data.p5 = 1;
                  }
                  setState(() {});
                },child: Text(data.p5==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p5==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 4:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Омбордан харажат',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш ",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Кирим Нархи",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p5 ==1){
                    data.p5 = 0;
                  }else{
                    data.p5 = 1;
                  }
                  setState(() {});
                },child: Text(data.p5==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p5==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 5:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Асосий омбор',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Фойда",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Кирим Нархи",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p5 ==1){
                    data.p5 = 0;
                  }else{
                    data.p5 = 1;
                  }
                  setState(() {});
                },child: Text(data.p5==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p5==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 6:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Харидорлар рўйхати',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],

          ),
        );
      case 7:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Мол етказиб берувчилар рўйхати',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],

          ),
        );
      case 8:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Харидорлар қарздорликлари',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 9:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Мол етказиб берувчилар карздорликлари',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],

          ),
        );
      case 10:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Тўловлар қабул қилиш',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 11:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Тўловлар чиқим килиш',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],

          ),
        );
      case 12:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Тўлов харажатлари ва конвертация',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],

          ),
        );
      case 13:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Ойликлар билан ишлаш',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],

          ),
        );
      case 14:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Дастур ишлатувчилар ойнаси',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 15:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Баланс ойнаси',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Кирим нархи",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p5 ==1){
                    data.p5 = 0;
                  }else{
                    data.p5 = 1;
                  }
                  setState(() {});
                },child: Text(data.p5==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p5==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 16:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Товарлар хақида қўшимча маълумот',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],

          ),
        );
      case 17:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Хисоб рақамлар қолдиғи',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 18:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Харакатлар тарихи',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 19:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Масофадаги касса',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Кирим нархи",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p5 ==1){
                    data.p5 = 0;
                  }else{
                    data.p5 = 1;
                  }
                  setState(() {});
                },child: Text(data.p5==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p5==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 20:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Омборга қайтариш',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Кирим нархи",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p5 ==1){
                    data.p5 = 0;
                  }else{
                    data.p5 = 1;
                  }
                  setState(() {});
                },child: Text(data.p5==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p5==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 21:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Омбор харакати',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 22:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Валюта курслари тарихи ',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
      case 23:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
          ),
          child: ExpansionTile(
            shape: const Border(),
            title: Text('Брон хужжатлари',style: AppStyle.mediumBold(Colors.black),),
            children: [
              ListTile(
                title: Text("Куриш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p1 ==1){
                    data.p1 = 0;
                  }else{
                    data.p1 = 1;
                  }
                  setState(() {});
                },child: Text(data.p1==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p1==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Янги киритиш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p2 ==1){
                    data.p2 = 0;
                  }else{
                    data.p2 = 1;
                  }
                  setState(() {});
                },child: Text(data.p2==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p2==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p3 ==1){
                    data.p3 = 0;
                  }else{
                    data.p3 = 1;
                  }
                  setState(() {});
                },child: Text(data.p3==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p3==1?AppColors.green:Colors.red),),),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: TextButton(onPressed: (){
                  if(data.p4 ==1){
                    data.p4 = 0;
                  }else{
                    data.p4 = 1;
                  }
                  setState(() {});
                },child: Text(data.p4==1?"Рухсат берилган":"Рухсат йўқ",style: AppStyle.small(data.p4==1?AppColors.green:Colors.red),),),
              ),
            ],
          ),
        );
    }
    return const SizedBox();
  }
}
