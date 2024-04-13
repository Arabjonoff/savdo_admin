import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/payments/income_pay_bloc.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/payment/outcome_pay/add_outcome_pay.dart';
import 'package:savdo_admin/src/ui/drawer/payment/outcome_pay/outcome_pay_screen.dart';

class OutcomeTabBarScreen extends StatefulWidget {
  const OutcomeTabBarScreen({super.key});

  @override
  State<OutcomeTabBarScreen> createState() => _OutcomeTabBarScreenState();
}

class _OutcomeTabBarScreenState extends State<OutcomeTabBarScreen> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final TextEditingController _controllerDate = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  List<AgentsResult> agents = [];
  int idAgent = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Repository repository = Repository();
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _key,
          backgroundColor: AppColors.background,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.background,
            title: Column(
              children: [
                const Text("Чиқимлар"),
                SizedBox(height: 4.h,),
                Text(_controllerDate.text,style: AppStyle.smallBold(Colors.grey),),
              ],
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: TabBar(
                  indicatorColor: AppColors.green,
                  labelColor: AppColors.green,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      child:Text("Барча чиқимлар"),
                    ),
                    Tab(
                      child:Text("Чиқим қўшиш",),
                    ),
                  ],
                )
            ),
            actions: [
              IconButton(onPressed: ()async{
                agents = await repository.getAgentsBase();
                setState(() {});
                _key.currentState!.openEndDrawer();
              }, icon: const Icon(Icons.filter_list_alt)),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              OutcomePayScreen(idAgent: idAgent,),
              const AddOutcomePayScreen(),
            ],
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
                                setState(() {});
                                _controllerDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                                incomePayBloc.getAllIncomePay(_controllerDate.text);
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
        ));
  }
}
