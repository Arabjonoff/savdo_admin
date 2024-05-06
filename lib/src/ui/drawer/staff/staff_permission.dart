import 'package:flutter/material.dart';
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
              return Text(data[index].p1.toString());
            });
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
