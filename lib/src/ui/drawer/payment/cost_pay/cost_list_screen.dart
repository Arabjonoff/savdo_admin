import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/expense/get_expense_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/expense/get_expense_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/ui/drawer/payment/cost_pay/update_cost_screen.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import '../../../../theme/icons/app_fonts.dart';

class CostListScreen extends StatefulWidget {
  const CostListScreen({super.key});

  @override
  State<CostListScreen> createState() => _CostListScreenState();
}

class _CostListScreenState extends State<CostListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final TextEditingController _controllerDate = TextEditingController();
  List<AgentsResult> agents = [];
  int idAgent = 0;
  num card = 0, bank = 0, price = 0;
  double currency = 0.0;
  @override
  void initState() {
    getExpenseBloc.getAllExpense(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Repository repository = Repository();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.black,
        title: Text("Харажатлар рўйхати",style: AppStyle.large(AppColors.black),),
        actions: [
          IconButton(onPressed: ()async{
            agents = await repository.getAgentsBase();
            setState(() {});
            _key.currentState!.openEndDrawer();
          }, icon: const Icon(Icons.filter_list_alt)),
        ],
      ),
      body: StreamBuilder<GetExpenseModel>(
          stream: getExpenseBloc.getExpenseStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              price = 0;
              currency = 0.0;
              card = 0;
              bank = 0;
              var data = snapshot.data!.data[0].tHar;
              for(int i = 0;i<data.length;i++){
                if (data[i].idValuta == 0) {
                  price += data[i].sm;
                }if (data[i].idValuta == 1) {
                  currency +=  data[i].sm.toDouble();
                }  if (data[i].idValuta == 2) {
                  card +=  data[i].sm;
                }  if (data[i].idValuta == 3) {
                  bank +=  data[i].sm;
                }
              }
              return data.isEmpty?const EmptyWidgetScreen():Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                CacheService.getPermissionPaymentExpense3() == 0?const SizedBox():SlidableAction(
                                  onPressed: (i){
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                      return UpdateCostScreen(data: data[index]);
                                    }));
                                  },
                                  backgroundColor: AppColors.green,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: ("Таҳрирлаш"),
                                ),
                                CacheService.getPermissionPaymentExpense4() == 0?const SizedBox():SlidableAction(
                                  onPressed: (i){
                                    CenterDialog.showDeleteDialog(context, ()async{
                                      HttpResult response = await repository.deleteExpense(data[index].id,CacheService.getDateId());
                                      if(response.result['status'] == true){
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:AppColors.green,content: Text("Ma'lumot ochirildi",style: AppStyle.medium(AppColors.white),)));
                                        // ignore: use_build_context_synchronously
                                        getExpenseBloc.getAllExpense(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                                        if(context.mounted)Navigator.pop(context);
                                      }
                                    });
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: ('Ўчириш'),
                                ),

                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 14.w),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.shade400
                                  )
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      data[index].idSklPr>0?Text("📝 ",style: TextStyle(fontSize: 18.h),):const SizedBox(),
                                      Text(
                                        data[index].idNimaName.toString(),
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        style: AppStyle.mediumBold(AppColors.black),
                                      ),
                                      const Spacer(),
                                      Text(
                                        priceFormat.format(data[index].sm),
                                        textAlign: TextAlign.start,
                                        style: AppStyle.mediumBold(AppColors.red),
                                      ),
                                      Text(data[index].idValuta == 0?" ${("сўм")}":data[index].idValuta==1?" \$":data[index].idValuta ==2?" ${("банк")}":" ${("пластик")}",   style: AppStyle.mediumBold(AppColors.red),)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                        textAlign: TextAlign.start,
                                        style: AppStyle.small(AppColors.black),
                                      ),
                                      SizedBox(
                                        width: 230.w,
                                        child: Text(
                                          data[index].izoh.isEmpty?"":data[index].izoh,
                                          textAlign: TextAlign.end,
                                          style: AppStyle.medium(AppColors.black),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  GestureDetector(
                    onTap: (){
                      // AllPaymentDialog.showAllPaymentDialog(context,price,card,bank,currency);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.card,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${priceFormat.format(price)} ${('сўм')} | ",
                            style: AppStyle.large(AppColors.green),
                          ),
                          Text(
                            "${priceFormatUsd.format(currency)} \$",
                            style: AppStyle.large(AppColors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          }),
      floatingActionButton: CacheService.getPermissionPaymentExpense2() == 0?const SizedBox():Padding(
        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin*3),
        child: FloatingActionButton(
          backgroundColor: AppColors.green,
          child: const Icon(Icons.add_circle_outline_sharp,color: Colors.white,size: 34,),
          onPressed: () {
            Navigator.pushNamed(context, AppRouteName.addCost);
        },),
      ),
      endDrawer: Drawer(
        backgroundColor: AppColors.background,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w,bottom: 8.h),
                child: Text("Сана бўйича",style: AppStyle.smallBold(Colors.black),),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                width: width,
                height: 50.h,
                child: TextField(
                  readOnly: true,
                  controller: _controllerDate,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(_controllerDate.text),
                            firstDate: DateTime(2000, 01,10),
                            lastDate: DateTime.now(),
                            builder: (context,picker){
                              return Theme(
                                //TODO: change colors
                                data: ThemeData.light().copyWith(),
                                child: picker!,);
                            })
                            .then((selectedDate) {
                          if(selectedDate!=null){
                            _controllerDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                            // incomePayBloc.getAllIncomePay(_controllerDate.text);
                            Navigator.pop(context);
                          }
                        });
                      },icon: const Icon(Icons.calendar_month),),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w,bottom: 8.h,top: 12.h),
                child: Text("Ходимлар бўйича",style: AppStyle.smallBold(Colors.black),),
              ),
              Expanded(child: ListView.builder(
                  itemCount: agents.length,
                  itemBuilder: (ctx,index){
                    return ListTile(
                      onTap: (){
                        idAgent = agents[index].id;
                        setState(() {});
                      },
                      leading: Text("${index+1}",style: AppStyle.smallBold(Colors.grey),),
                      trailing: Icon(Icons.radio_button_checked,color: agents[index].id == idAgent?AppColors.green:Colors.grey,),
                      title: Text(agents[index].name),
                    );
                  })),
              Align(
                  alignment: Alignment.center,
                  child: TextButton(onPressed: (){
                    idAgent = 0;
                    setState(() {});
                  }, child: Text("Тозалаш",style: AppStyle.medium(Colors.red),)))
            ],
          ),
        ),
      ),
    );
  }
}
