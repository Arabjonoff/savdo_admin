import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class AgentPermissionScreen extends StatefulWidget {
  final AgentsResult data;
  const AgentPermissionScreen({super.key, required this.data});

  @override
  State<AgentPermissionScreen> createState() => _AgentPermissionScreenState();
}

class _AgentPermissionScreenState extends State<AgentPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.data.name),
      ),
      body: Column(
        children: [
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
                  Text("data")
                ],
              ),),
        ],
      ),
    );
  }
}
