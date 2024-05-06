import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/client/agent_permission.dart';
import 'package:savdo_admin/src/model/client/agent_permission_model.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class StaffPermissionScreen extends StatefulWidget {
  final AgentsResult data;
  const StaffPermissionScreen({super.key, required this.data});

  @override
  State<StaffPermissionScreen> createState() => _StaffPermissionScreenState();
}

class _StaffPermissionScreenState extends State<StaffPermissionScreen> {
  bool product = false,productAdd = false,productEdit = false,productDelete = false;
  bool wareHouseIncome = false,wareHouseIncomeAdd = false,wareHouseIncomeEdit = false,wareHouseIncomeDelete = false,wareHouseIncomePrice = false;
  bool wareHouseOutcome = false,wareHouseOutcomeAdd = false,wareHouseOutcomeEdit = false,wareHouseOutcomeDelete = false,wareHouseOutcomePrice = false;
  @override
  void initState() {
    agentPermission.getAllPermission(widget.data.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title:  Text(widget.data.name),
      ),
      body: StreamBuilder<List<AgentPermissionResult>>(
        stream: agentPermission.getPermissionStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx,index){
              return lisTile(data[index],data[index].tp);
            });
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
  Widget lisTile(AgentPermissionResult data ,int tp){
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
                trailing: CupertinoSwitch(value: product, onChanged: (bool value) {
                  product = value;
                  setState(() {});
                },),
              ),
              ListTile(
                title: Text("Янги киритиш ",style: AppStyle.medium(Colors.black),),
                trailing: CupertinoSwitch(value: data.p2==1?true:false, onChanged: (bool value) {  },),

              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: CupertinoSwitch(value: data.p3==1?true:false, onChanged: (bool value) {  },),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: CupertinoSwitch(value: data.p4==1?true:false, onChanged: (bool value) {  },),
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
                trailing: CupertinoSwitch(value: data.p1==1?true:false, onChanged: (bool value) {
                  print(value);
                  setState(() {});
                },),
              ),
              ListTile(
                title: Text("Янги киритиш ",style: AppStyle.medium(Colors.black),),
                trailing: CupertinoSwitch(value: data.p2==1?true:false, onChanged: (bool value) {  },),

              ),
              ListTile(
                title: Text("Тахрирлаш",style: AppStyle.medium(Colors.black),),
                trailing: CupertinoSwitch(value: data.p3==1?true:false, onChanged: (bool value) {  },),
              ),
              ListTile(
                title: Text("Ўчириш",style: AppStyle.medium(Colors.black),),
                trailing: CupertinoSwitch(value: data.p4==1?true:false, onChanged: (bool value) {  },),
              ),
              ListTile(
                title: Text("Кирим Нархи",style: AppStyle.medium(Colors.black),),
                trailing: CupertinoSwitch(value: data.p5==1?true:false, onChanged: (bool value) {  },),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
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
                title: Text(data.p1.toString()),
              ),
              ListTile(
                title: Text(data.p2.toString()),
              ),
              ListTile(
                title: Text(data.p3.toString()),
              ),
              ListTile(
                title: Text(data.p4.toString()),
              ),
              ListTile(
                title: Text(data.p5.toString()),
              ),
            ],
          ),
        );
    }
    return ListTile();
  }
}
