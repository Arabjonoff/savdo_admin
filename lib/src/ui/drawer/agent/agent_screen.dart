import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/bloc/client/agents_bloc.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/agent/agent_permission.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({super.key});

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  @override
  void initState() {
    agentsBloc.getAllAgents();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Ходимлар"),
      ),
      body: StreamBuilder<List<AgentsResult>>(
        stream: agentsBloc.getAgentsStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return AgentPermissionScreen(data: data[index],);
                  }));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade400
                      )
                    )
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green.shade200,
                        child: Text(data[index].name[0]),),
                      SizedBox(width: 12.w,),
                      Expanded(child: Text(data[index].name,style: AppStyle.medium(Colors.black),))
                    ],
                  ),
                ),
              );
            });
          }return const EmptyWidgetScreen();
        }
      ),
    );
  }
}
