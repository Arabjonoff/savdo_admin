
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/income/income_bloc.dart';
import 'package:savdo_admin/src/bloc/income/skl_pr_tov_bloc.dart';
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
  final _controller = ScrollController();
   late final AnimationController _controllerAnimation;
   late final Animation<double> _animation;
bool scrollTop = false;
  @override
  void initState() {
    incomeBloc.getAllIncome();
    super.initState();
    _controllerAnimation = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween(begin: 0.0, end: .5).animate(CurvedAnimation(
            parent: _controllerAnimation, curve: Curves.easeOut));
  }
  @override
  void dispose() {
    super.dispose();
    _controllerAnimation.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Киримлар"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await incomeBloc.getAllIncome();
        },
        child: StreamBuilder<IncomeModel>(
          stream: incomeBloc.getIncomeStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              var data = snapshot.data!.data;
              if(data.isEmpty){
                return const EmptyWidgetScreen();
              }
              else{
                return Column(
                  children: [
                    Expanded(child: NotificationListener<ScrollEndNotification>(
                      onNotification: (scrollEnd) {
                        final metrics = scrollEnd.metrics;
                        if (metrics.atEdge) {
                          bool isTop = metrics.pixels == 0;
                          if (isTop) {
                            _controllerAnimation.reverse();
                            scrollTop = false;
                          } else {
                            scrollTop = true;
                            _controllerAnimation.forward();
                          }
                          setState(() {});

                        }
                        return true;
                      },
                      child: ListView.builder(
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
                                                  incomeBloc.getAllIncome();
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
                                                incomeBloc.getAllIncome();
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
                                                  sklPrTovBloc.getAllSklPrTov(data[index].sklPrTov);
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
                                                  incomeBloc.getAllIncome();
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
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("№${data[index].ndoc}",style: AppStyle.medium(Colors.black),),
                                              Text(data[index].sana.toIso8601String().substring(0,10),style: AppStyle.small(Colors.black)),
                                            ],
                                          ),
                                          Text(data[index].name,style: AppStyle.medium(Colors.black),),
                                          SizedBox(height: 8.h,),
                                          Row(
                                            children: [
                                              Expanded(child: Text("Kирим:",style: AppStyle.medium(Colors.green),)),
                                              Expanded(child: Text("Cотув:",style: AppStyle.medium(Colors.green),)),
                                              Expanded(child: Text("Xаражат:",style: AppStyle.medium(Colors.red),)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(child: Text(priceFormat.format(data[index].sm),style: AppStyle.medium(Colors.green),)),
                                              Expanded(child: Text(priceFormat.format(data[index].sm),style: AppStyle.medium(Colors.green),)),
                                              Expanded(child: Text(priceFormat.format(data[index].har),style: AppStyle.medium(Colors.red),)),
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
                                      data[index].pr==1?Positioned(
                                          left: MediaQuery.of(context).size.width/2.5,
                                          top: 15.h,
                                          child: const CircleAvatar(child: Icon(Icons.lock,color: Colors.red,))):const SizedBox()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )),
                    ButtonWidget(onTap: (){
                      Navigator.pushNamed(context, AppRouteName.addDocumentIncome);
                    }, color: AppColors.green, text: "Янги ҳужжат очиш"),
                    SizedBox(height: 24.h,)
                  ],
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: kToolbarHeight),
      //   child: FloatingActionButton(
      //     backgroundColor: AppColors.green,
      //     onPressed: (){
      //       if (_controllerAnimation.isDismissed) {
      //         _controllerAnimation.forward();
      //       } else {
      //         _controllerAnimation.reverse();
      //       }
      //       if(scrollTop){
      //          _controller.animateTo(_controller.position.minScrollExtent, duration: const Duration(milliseconds: 900), curve: Curves.fastOutSlowIn).then((value) => true);
      //       }else{
      //         _controller.animateTo(_controller.position.maxScrollExtent, duration: const Duration(milliseconds: 900), curve: Curves.fastOutSlowIn).then((value) => true);
      //       }
      //     },
      //     child:RotationTransition(
      //         turns: _animation,
      //         child: const Icon(Icons.arrow_downward,color: Colors.white,)),
      //   ),
      // ),
    );
  }
}


