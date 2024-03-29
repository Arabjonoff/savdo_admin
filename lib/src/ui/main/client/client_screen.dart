import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/client/update_client_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientScreen extends StatefulWidget{
  final int clientType;
  const ClientScreen({super.key, required this.clientType});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen>{
  final Repository _repository = Repository();
  @override
  void initState() {
    clientBloc.getAllClientSearch('');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          await _repository.clearClient();
          await clientBloc.getAllClient('');
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w,vertical: 4),
              child: CupertinoSearchTextField(
                placeholder: "Излаш",
                onChanged: (i){
                  clientBloc.getAllClientSearch(i);
                },
              ),
            ),
            Expanded(child: StreamBuilder<List<ClientResult>>(
                stream: clientBloc.getClientSearchStream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    var data = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                        itemCount: data.length,
                        itemBuilder: (ctx,index){
                          return widget.clientType ==0?data[index].tp == 0?Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (i){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return UpdateClientScreen(data: data[index],);
                                    }));
                                  },icon: Icons.edit,
                                  backgroundColor: Colors.green,
                                ),
                                SlidableAction(
                                  onPressed: (i)async{
                                    CenterDialog.showDeleteDialog(context, ()async{
                                      CenterDialog.showLoadingDialog(context, "Бир оз кутинг");
                                      HttpResult res = await _repository.deleteClient(data[index].id, data[index].idT, data[index].name);
                                      if(res.result['status'] == true){
                                        if(context.mounted)Navigator.pop(context);
                                        await _repository.deleteClientBase(data[index].id);
                                        clientBloc.getAllClient('');
                                        if(context.mounted)Navigator.pop(context);
                                      }
                                      else{
                                        if(context.mounted)Navigator.pop(context);
                                        if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                                      }
                                    });
                                  },icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                )
                              ],
                            ),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (i){
                                    final Uri teleLaunchUri = Uri(
                                      scheme: 'tel',
                                      path: data[index].tel,
                                    );
                                    launchUrl(
                                        teleLaunchUri
                                    );
                                  },icon: Icons.call,
                                  backgroundColor: Colors.green,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: (){
                                CenterDialog.showClientDetailDialog(context, data[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 16.w,top: 10.h,bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300
                                        )
                                    )
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green.shade100,
                                      child: data[index].name.isEmpty?const Text(""):Text(data[index].name[0]),
                                    ),
                                    SizedBox(width: 8.w,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${data[index].idT} ${data[index].name}",style: AppStyle.medium(Colors.black),),
                                        Text("Тел: ${data[index].tel}",style: AppStyle.small(Colors.black),),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ):const SizedBox():data[index].tp == 1?Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (i){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return UpdateClientScreen(data: data[index],);
                                    }));
                                  },icon: Icons.edit,
                                  backgroundColor: Colors.green,
                                ),
                                SlidableAction(
                                  onPressed: (i)async{
                                    CenterDialog.showDeleteDialog(context, ()async{
                                      CenterDialog.showLoadingDialog(context, "Бир оз кутинг");
                                      HttpResult res = await _repository.deleteClient(data[index].id, data[index].idT, data[index].name);
                                      if(res.result['status'] == true){
                                        if(context.mounted)Navigator.pop(context);
                                        await _repository.deleteClientBase(data[index].id);
                                        clientBloc.getAllClient('');
                                        if(context.mounted)Navigator.pop(context);
                                        CenterDialog.showSuccessDialog(context,);
                                      }
                                      else{
                                        if(context.mounted)Navigator.pop(context);
                                        if(context.mounted)CenterDialog.showErrorDialog(context, res.result['message']);
                                      }
                                    });
                                  },icon: Icons.delete,
                                  backgroundColor: Colors.red,
                                )
                              ],
                            ),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (i){
                                    final Uri teleLaunchUri = Uri(
                                      scheme: 'tel',
                                      path: data[index].tel,
                                    );
                                    launchUrl(
                                        teleLaunchUri
                                    );
                                  },icon: Icons.call,
                                  backgroundColor: Colors.green,
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: (){
                                CenterDialog.showClientDetailDialog(context, data[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 16.w,top: 10.h,bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300
                                        )
                                    )
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.green.shade100,
                                      child: Text(data[index].name[0]),
                                    ),
                                    SizedBox(width: 8.w,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${data[index].idT} ${data[index].name}",style: AppStyle.medium(Colors.black),),
                                        Text("Тел: ${data[index].tel}",style: AppStyle.small(Colors.black),),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ):const SizedBox();
                        }
                    );}
                  return const Center(child: CircularProgressIndicator());
                }
            ),),
          ],
        ),
      ),
    );
  }
}
