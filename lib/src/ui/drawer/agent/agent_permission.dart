import 'package:flutter/material.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';

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
        backgroundColor: AppColors.background,
        title:  Text(widget.data.name),
      ),
    );
  }
}
