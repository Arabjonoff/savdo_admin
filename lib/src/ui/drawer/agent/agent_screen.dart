import 'package:flutter/material.dart';
import 'package:savdo_admin/src/bloc/client/agents_bloc.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';

class AgentScreen extends StatefulWidget {
  const AgentScreen({super.key});

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<AgentsResult>>(
        stream: agentsBloc.getAgentsStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx,index){
              return SizedBox();
            });
          }return SizedBox();
        }
      ),
    );
  }
}
