import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/agents_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/staff/agent_permission.dart';
import 'package:savdo_admin/src/ui/drawer/staff/staff_permission.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  @override
  void initState() {
    agentsBloc.getAllAgents();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Ходимлар"),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await repository.clearAgents();
          await agentsBloc.getAllAgents();
        },
        child: StreamBuilder<List<AgentsResult>>(
          stream: agentsBloc.getAgentsStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx,index){
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (i){},
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                      ),
                      SlidableAction(
                        onPressed: (i){},
                        icon: Icons.edit,
                        backgroundColor: AppColors.green,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: (){
                      if(data[index].tip ==1){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                          return AgentPermissionScreen(data: data[index],);
                        }));
                      }else if(data[index].name=='Admin'){
                        CenterDialog.showErrorDialog(context, "${data[index].name} нинг рухсатларни ўзгартириш мумкин эмас");
                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (ctx){
                          return StaffPermissionScreen(data: data[index],);
                        }));
                      }
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
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].name,style: AppStyle.medium(Colors.black),),
                              Text(data[index].tel,style: AppStyle.small(Colors.black),),
                            ],
                          )),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: data[index].tip==0?Colors.red:AppColors.green
                              ),
                              child: checkStaff(data[index].tip),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
            }return const EmptyWidgetScreen();
          }
        ),
      ),
    );
  }
  Widget checkStaff(tip){
    switch(tip){
      case 0:
        return Text("Админ",style: AppStyle.small(Colors.white),);
      case 1:
        return Text("Агент",style: AppStyle.small(Colors.white),);
      case 2:
        return Text("Омборчи",style: AppStyle.small(Colors.white),);
      case 3:
        return Text("Кассир",style: AppStyle.small(Colors.white),);
      case 4:
        return Text("Ҳисобчи",style: AppStyle.small(Colors.white),);
    }
    return Text('');
  }
}
