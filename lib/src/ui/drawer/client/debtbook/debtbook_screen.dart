import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/client/update_client_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DebtBookScreen extends StatefulWidget {
  const DebtBookScreen({super.key});

  @override
  State<DebtBookScreen> createState() => _DebtBookScreenState();
}

class _DebtBookScreenState extends State<DebtBookScreen> {
  final Repository _repository = Repository();
  @override
  void initState() {
    clientBloc.getAllClientSearch('');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: CupertinoSearchTextField(
          placeholder: "Излаш",
          onChanged: (i){
            clientBloc.getAllClientSearch(i);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await _repository.clearClient();
          await clientBloc.getAllClient('');
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: StreamBuilder<List<ClientResult>>(
                  stream: clientBloc.getClientStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var data = snapshot.data!;
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (ctx,index){
                                  return 0 ==0?data[index].tp == 0?Slidable(
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
                                              child: Text(data[index].name[0]),
                                            ),
                                            SizedBox(width: 8.w,),
                                            Expanded(child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${data[index].idT} ${data[index].name}",style: AppStyle.medium(Colors.black),),
                                                Text("Қолдиқ: ${data[index].tel}",style: AppStyle.small(Colors.black),),
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
                                                Text("Қолдиқ: ${data[index].tel}",style: AppStyle.small(Colors.black),),
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ):const SizedBox();
                                }
                            ),
                          ),
                          TextButton(onPressed: (){}, child: Text("Барча маълумотлар"))
                        ],
                      );}
                    return const Center(child: CircularProgressIndicator());
                  }
              ),),
              ButtonWidget(
                  onTap: (){
                    Navigator.pushNamed(context, AppRouteName.addClient);
                  }, color: AppColors.green, text: "Харидор қўшиш"),
              SizedBox(height: 8.h,),
            ],
          ),
        ),
      ),
    );
  }
}
