import 'package:flutter/material.dart';
import 'package:savdo_admin/src/bloc/client/agent_permission.dart';
import 'package:savdo_admin/src/model/client/agent_permission_model.dart';
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
            return Column(
              children: [
                ExpansionTile(
                  shape: const Border(),
                  title: Text("Картатека",style: AppStyle.mediumBold(Colors.black),),
                  children: [
                    ListTile(title: Text("salomat"),)
                  ],
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}
