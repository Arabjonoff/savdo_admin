
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/income_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_model.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';

import 'update_income/update_income_screen.dart';


class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> with SingleTickerProviderStateMixin{
  final Repository _repository = Repository();
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  TextEditingController _controllerDate = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final _controller = ScrollController();
bool scrollTop = false;
  @override
  void initState() {
    incomeBloc.getAllIncome(dateTime.year,dateTime.month);
    super.initState();
  }
  @override
  void dispose() {
    _controllerDate = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Column(
          children: [
            const Text("Киримлар"),
            Text(DateFormat('yyyy-MMM').format(dateTime),style: AppStyle.smallBold(Colors.grey),),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            showMonthPicker(
                roundedCornersRadius: 25,
                headerColor: AppColors.green,
                selectedMonthBackgroundColor: AppColors.green.withOpacity(0.7),
                context: context,
                initialDate: dateTime,
                lastDate: DateTime.now()
            ).then((date) {
              if (date != null) {
                setState(() {
                  dateTime = date;
                });
                _repository.clearSkladBase();
                incomeBloc.getAllIncome(dateTime.year,dateTime.month);
              }
            });
          }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await incomeBloc.getAllIncome(dateTime.year,dateTime.month);
        },
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<IncomeModel>(
                stream: incomeBloc.getIncomeStream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    var data = snapshot.data!.data;
                    if(data.isEmpty){
                      return const EmptyWidgetScreen();
                    }
                    else{
                      return ListView.builder(
                          controller: _controller,
                          itemCount: data.length,
                          itemBuilder: (ctx,index){
                            return GestureDetector(
                              onTap: (){},
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          SlidableAction(
                                              label: 'Қулфлаш',
                                              onPressed: (i) async {
                                                HttpResult res = await _repository.lockIncome(data[index].id,1);
                                                if(res.result['status'] == true){
                                                  incomeBloc.getAllIncome(dateTime.year,dateTime.month);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text(res.result['message']),backgroundColor: Colors.green,)
                                                  );
                                                }
                                                else{
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text(res.result['message']),backgroundColor: Colors.red,)
                                                  );
                                                }
                                              },
                                              icon: Icons.lock),
                                          SlidableAction(
                                            label: 'Очиш',
                                            onPressed: (i) async {
                                              HttpResult res = await _repository.lockIncome(data[index].id,0);
                                              if(res.result['status'] == true){
                                                incomeBloc.getAllIncome(dateTime.year,dateTime.month);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text(res.result['message']),backgroundColor: Colors.green,)
                                                );
                                              }
                                              else{
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text(res.result['message']),backgroundColor: Colors.red,)
                                                );
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
                                              onPressed: (i) async {
                                                if(data[index].pr ==1){
                                                  CenterDialog.showErrorDialog(context, "Ҳужжат қулфланган");
                                                }else{
                                                  // ignore: avoid_function_literals_in_foreach_calls
                                                  data[index].sklPrTov.forEach((element)async => await _repository.saveIncomeProductBase(element.toJson()));
                                                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                                    return UpdateIncomeScreen(data: data[index],);
                                                  }));
                                                }
                                              },
                                              icon: Icons.edit),
                                          SlidableAction(
                                            label: "Ўчириш",
                                            onPressed: (i){
                                              CenterDialog.showDeleteDialog(context, ()async{
                                                HttpResult res = await _repository.deleteIncome(data[index].id);
                                                if(res.result['status'] == true){
                                                  incomeBloc.getAllIncome(dateTime.year,dateTime.month);
                                                  Navigator.pop(context);
                                                }
                                                else{
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result['message']),backgroundColor: Colors.red,));
                                                  Navigator.pop(context);
                                                }
                                              });
                                            }, icon: Icons.delete,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: AppColors.card,
                                      border:  Border(bottom: BorderSide(color: Colors.grey.shade400)
                                      )
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: data[index].pr==1?AppColors.red:AppColors.green
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 1),
                                              child: Text("№${data[index].ndoc}",style: AppStyle.medium(Colors.white),),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        Text("Кирим нархи:",style: AppStyle.small(Colors.black),),
                                        Text("${priceFormat.format(data[index].smT)} сўм | ${priceFormatUsd.format(data[index].smTS)} \$",style: AppStyle.smallBold(Colors.black),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        Text("Сотиш нархи:",style: AppStyle.small(Colors.black),),
                                        Text("${priceFormat.format(data[index].sm)} сўм | ${priceFormat.format(data[index].smS)} \$",style: AppStyle.smallBold(AppColors.green),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        Text("Харажат:",style: AppStyle.small(Colors.black),),
                                        Text("${priceFormat.format(data[index].har)} сўм | ${priceFormat.format(data[index].harS)} \$",style: AppStyle.smallBold(Colors.red),),
                                        ],
                                      ),
                                      SizedBox(height: 4.h,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        Text("Вақти:",style: AppStyle.small(Colors.black),),
                                        Text(data[index].vaqt.toString().substring(0,19),style: AppStyle.small(Colors.black),),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 1,
                                      //   width: MediaQuery.of(context).size.width,
                                      //   child: DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                                      // ),
                                      ///
                                      // Text("Жами кирим сотув нархда:",style: AppStyle.medium(Colors.indigo),),
                                      // Row(
                                      //   children: [
                                      //     Text("320 323 сўм | ",style: AppStyle.medium(Colors.indigo),),
                                      //     Text("909 320 \$",style: AppStyle.medium(Colors.indigo),),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 1,
                                      //   width: MediaQuery.of(context).size.width,
                                      //   child: DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                                      // ),
                                      // Text("Кирим харажатлари:",style: AppStyle.medium(Colors.red),),
                                      // Row(
                                      //   children: [
                                      //     Text("909 323 сўм | ",style: AppStyle.medium(Colors.red),),
                                      //     Text("909 323 \$",style: AppStyle.medium(Colors.red),),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 1,
                                      //   width: MediaQuery.of(context).size.width,
                                      //   child: DashedRect(color: Colors.grey, strokeWidth: 2.0, gap: 3.0,),
                                      // ),
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
              ),
            ),
            ButtonWidget(onTap: () async {
              CenterDialog.showLoadingDialog(context, "Бироз кутинг");
              HttpResult setDoc = await _repository.setDoc(1);
              if(setDoc.result['status'] == true){
                if(context.mounted){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRouteName.addDocumentIncome,arguments: setDoc.result['ndoc']);
                }
              }else{
                if(context.mounted){
                  Navigator.pop(context);
                  CenterDialog.showErrorDialog(context, setDoc.result['message']);
                }
              }
            }, color: AppColors.green, text: "Янги ҳужжат очиш"),
            SizedBox(height: 24.h,)
          ],
        ),
      ),
    );
  }
  Widget priceCheckSm(data){
    if(data.sm != 0){
      return Text("${priceFormat.format(data.sm)} сўм",style: AppStyle.medium(Colors.black),);
  }
    else{
      return Text("${priceFormat.format(data.smS)} \$",style: AppStyle.medium(Colors.black),);
    }
  }
  Widget priceCheckSmT(data){
    if(data.smT != 0){
      return Text("${priceFormat.format(data.smT)} сўм",style: AppStyle.medium(Colors.black),);
  }
    else{
      return Text("${priceFormat.format(data.smTS)} \$",style: AppStyle.medium(Colors.black),);
    }
  }
}


