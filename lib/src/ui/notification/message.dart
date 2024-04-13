import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Map payload = {};
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage) {
      payload = data.data;
    }
    if (data is NotificationResponse) {
      payload = json.decode(data.payload!);
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text("Хабарномалар")),
      body: ListView.builder(
        itemCount: 12,
          itemBuilder: (ctx,index){
        return Container(
          width: width,
          margin: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notifications',style: AppStyle.smallBold(Colors.black),),
              Text('body lorem ipsum dolor amout helper and is momno db isload an but poteto',style: AppStyle.small(Colors.black),),
              SizedBox(height: 8.h,),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('2024-10-10 09:20',style: TextStyle(fontSize: 12.h))),
            ],
          ),
        );
      }),
    );
  }
}