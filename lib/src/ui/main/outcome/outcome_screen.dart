// ignore_for_file: use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/outcome/outcome_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/ui/main/outcome/document_outcome_screen.dart';
import 'package:savdo_admin/src/ui/main/outcome/update_outcome/update_outcome_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

class OutcomeScreen extends StatefulWidget {
  const OutcomeScreen({super.key});

  @override
  State<OutcomeScreen> createState() => _OutcomeScreenState();
}

class _OutcomeScreenState extends State<OutcomeScreen> {
   TextEditingController _controllerDate = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final Repository _repository = Repository();
  @override
  void initState() {
  outcomeBloc.getAllOutcome(_controllerDate.text);
  super.initState();
  }
  @override
  void dispose() {
    _controllerDate = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Column(
          children: [
            const Text("Савдо-сотиқ"),
             Text(_controllerDate.text,style: AppStyle.smallBold(Colors.grey),),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            dateTimePickerWidget(context);
          }, icon: Icon(Icons.calendar_month,color: AppColors.green,))
        ],
      ),
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: ()async{
          await outcomeBloc.getAllOutcome(_controllerDate.text,);
        },
        child: Column(
          children: [
            Expanded(child: StreamBuilder<List<OutcomeResult>>(
              stream: outcomeBloc.getOutcomeStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  var data = snapshot.data!;
                  if(data.isEmpty){
                    return const EmptyWidgetScreen();
                  }
                  else{
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx,index){
                          return Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      SlidableAction(
                                          label: 'Қулфлаш',
                                          onPressed: (i) async {
                                            HttpResult res = await _repository.lockOutcome(data[index].id,1);
                                            if(res.result["status"] == true){
                                              outcomeBloc.getAllOutcome(_controllerDate.text);
                                            }else{
                                              if(context.mounted)CenterDialog.showErrorDialog(context, res.result["message"]);
                                            }
                                          },
                                          icon: Icons.lock),
                                      SlidableAction(
                                        label: 'Очиш',
                                        onPressed: (i) async {
                                          HttpResult res = await _repository.lockOutcome(data[index].id,0);
                                          if(res.result["status"] == true){
                                            outcomeBloc.getAllOutcome(_controllerDate.text);
                                          }else{
                                            if(context.mounted)CenterDialog.showErrorDialog(context, res.result["message"]);
                                          }
                                        }, icon: Icons.lock_open,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      SlidableAction(
                                          label: 'Таҳрирлаш',
                                          onPressed: (i){
                                            if(data[index].pr==1){
                                              CenterDialog.showErrorDialog(context, "Ҳужжат қулфланган");
                                            }else{
                                              data[index].sklRsTov.forEach((element) async{ await _repository.saveOutcomeCart(element);});
                                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                                return UpdateOutcomeScreen(ndocId: data[index].id,);
                                              }));
                                            }
                                          },
                                          icon: Icons.edit),
                                      SlidableAction(
                                        label: "Ўчириш",
                                        onPressed: (i){
                                          CenterDialog.showDeleteDialog(context, ()async{
                                            HttpResult res = await _repository.deleteOutcomeDoc(data[index].id);
                                            if(res.result['status'] == true){
                                              outcomeBloc.getAllOutcome(_controllerDate.text);
                                              Navigator.pop(context);
                                            }
                                            else{
                                              Navigator.pop(context);
                                              CenterDialog.showErrorDialog(context, res.result['message']);
                                            }
                                          });
                                        }, icon: Icons.delete,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                // Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                //   return DocumentOutComeScreen();
                                // }));
                                // var body = {
                                //   "NAME": data[index].name,
                                //   "ID_T": data[index].idT,
                                //   "NDOC": data[index].ndoc,
                                //   "SANA": data[index].sana.toString(),
                                //   "IZOH": data[index].izoh,
                                //   "ID_HODIM": data[index].idHodim,
                                //   "ID_AGENT": data[index].idAgent,
                                //   "ID_HARIDOR": data[index].idHaridor,
                                //   "KURS": data[index].kurs,
                                //   "ID_FAOL": data[index].idFaol,
                                //   "ID_KLASS": data[index].idKlass,
                                //   "ID_SKL": 1,
                                //   "YIL": DateTime.now().year,
                                //   "OY":  DateTime.now().month
                                // };
                                // HttpResult res = await _repository.updateDocOutcome(body);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.card,
                                    border:  Border(bottom: BorderSide(color: Colors.grey.shade400)
                                    )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.green,
                                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5))
                                      ),
                                      child: Text(data[index].idAgentName,style: AppStyle.smallBold(Colors.white),),
                                    ),
                                    SizedBox(height: 4.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: data[index].pr ==1?Colors.red:AppColors.green
                                          ),
                                            child: Text("№${data[index].ndoc}",style: AppStyle.medium(Colors.white),)),
                                      ],
                                    ),
                                    Text(data[index].izoh,style: AppStyle.small(Colors.grey),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Жами:",style: AppStyle.medium(Colors.black),),
                                        Text("${priceFormat.format(data[index].sm)} сўм | ${priceFormatUsd.format(data[index].smS)} \$",style: AppStyle.medium(Colors.black),),
                                      ],
                                    ),
                                    SizedBox(height: 4.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Тўлов:",style: AppStyle.small(Colors.black),),
                                        paymentCheck(data[index])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Вақти',style: AppStyle.small(Colors.black),),
                                        Text(data[index].vaqt.toString().substring(10,19),style: AppStyle.small(Colors.black),),
                                      ],
                                    ),
                                    SizedBox(height: 4.h,),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }
            )
            ),
            ButtonWidget(onTap: ()async{
              CenterDialog.showLoadingDialog(context, "Бироз кутинг!");
              HttpResult res = await _repository.setDoc(2);
              if(res.isSuccess){
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouteName.addDocumentOutcome,arguments: res.result['ndoc']);
              }else{
                Navigator.pop(context);
                CenterDialog.showErrorDialog(context, res.result['message']);
              }
            }, color: AppColors.green, text: "Янги ҳужжат очиш"),
            SizedBox(height: 24.h,)
          ],
        ),
      ),
    );
  }
  Widget paymentCheck(OutcomeResult data){
    if(data.tlNaqd != 0){
      return Text("${priceFormat.format(data.tlNaqd)} сўм | ${priceFormatUsd.format(data.tlVal)} \$",style: AppStyle.smallBold(AppColors.green),);
    }
    else if(data.tlKarta !=0){
      return Text("${priceFormat.format(data.tlKarta)} пластик | ${priceFormatUsd.format(data.tlVal)} \$",style: AppStyle.smallBold(AppColors.green),);
    }
    else if(data.tlBank !=0){
      return Text("${priceFormat.format(data.tlBank)} банк | ${priceFormatUsd.format(data.tlVal)} \$",style: AppStyle.smallBold(AppColors.green),);
    }
    return Text("${priceFormat.format(data.tlNaqd)} сўм | ${priceFormatUsd.format(data.tlVal)} \$",style: AppStyle.smallBold(AppColors.green),);

  }
  dateTimePickerWidget(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.parse(_controllerDate.text),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
          ),
          child: child!,
        );
      },
    ).then((selectedDate) {
      // After selecting the date, display the time picker.
      if (selectedDate != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        );
        _controllerDate.text = DateFormat('yyyy-MM-dd').format(selectedDateTime);
        setState(() {});
        outcomeBloc.getAllOutcome( _controllerDate.text);
      }
    });
  }
}
