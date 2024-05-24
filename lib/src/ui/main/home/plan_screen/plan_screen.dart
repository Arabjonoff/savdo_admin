import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  int weekday = DateTime.now().weekday;
  List<AgentsResult> agents = [];
  int idAgent = -1;
  @override
  void initState() {
    clientBloc.getAllClient();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return Scaffold(
      body: StreamBuilder<List<ClientResult>>(
          stream: clientBloc.getClientStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 8.w,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Agentlar bo'yicha filter",style: AppStyle.smallBold(Colors.black),),
                        IconButton(onPressed: ()async{
                          agents = await repository.getAgentsBase();
                          showDialog(context: context, builder: (builder){
                            return SizedBox(
                              height: 300.w,
                              width: MediaQuery.of(context).size.width,
                              child: AlertDialog(
                                insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
                                title: const Text("Agentlar bo'yicha filter"),
                                content: SizedBox(
                                  height: 300.w,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: agents.length,
                                            itemBuilder: (ctx,index){
                                              return ListTile(
                                                onTap: (){
                                                  idAgent = agents[index].id;
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                title: Text(agents[index].name,style: AppStyle.smallBold(Colors.black),),
                                                trailing: Icon(Icons.radio_button_checked,color: idAgent == agents[index].id?Colors.green:Colors.grey,),
                                              );
                                            }),
                                      ),
                                      TextButton(onPressed: (){
                                        idAgent =-1;
                                        setState(() {});
                                        Navigator.pop(context);
                                      }, child: Text('Tozalash'))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                          setState(() {});
                        }, icon: const Icon(Icons.filter_list_alt,color: Colors.grey,)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx,index){
                          if(idAgent == data[index].idAgent){
                            return ListTile(
                              leading: CircleAvatar(backgroundColor: AppColors.green,child: Text(data[index].name[0].toUpperCase(),style: AppStyle.smallBold(Colors.white),),),
                              title: Text(data[index].name),
                              trailing: DateTime.now().weekday == weekday?Icon(Icons.check_box_rounded,color: data[index].st==4?AppColors.green:Colors.grey,):const Icon(Icons.check_box_rounded),
                            );
                          }
                          else if(idAgent ==-1){
                            return ListTile(
                              leading: CircleAvatar(backgroundColor: AppColors.green,child: Text(data[index].name[0].toUpperCase(),style: AppStyle.smallBold(Colors.white),),),
                              title: Text(data[index].name),
                              trailing: DateTime.now().weekday == weekday?Icon(Icons.check_box_rounded,color: data[index].st==4?AppColors.green:Colors.grey,):const Icon(Icons.check_box_rounded),
                            );
                          }
                          else{
                            return const SizedBox();
                          }
                        }),
                  ),
                ],
              );
            } return SizedBox();
          }
      ),
    );
  }
  Widget weekDay(weekday){
    switch(weekday){
      case 1:
        return Text("Dushanba",style: AppStyle.smallBold(Colors.black),);
      case 2:
        return Text("Seshanba",style: AppStyle.smallBold(Colors.black),);
      case 3:
        return Text("Chorshanba",style: AppStyle.smallBold(Colors.black),);
      case 4:
        return Text("Payshanba",style: AppStyle.smallBold(Colors.black),);
      case 5:
        return Text("Juma",style: AppStyle.smallBold(Colors.black),);
      case 6:
        return Text("Shanba",style: AppStyle.smallBold(Colors.black),);
      case 7:
        return Text("Yakshanba",style: AppStyle.smallBold(Colors.black),);
    }
    return Text("");
  }
}
