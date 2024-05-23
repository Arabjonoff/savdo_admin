import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/debt_client_bloc.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/client/debtbook/debt_client_serach.dart';
import 'package:savdo_admin/src/ui/drawer/client/debtbook/debtbook_detail.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/utils/utils.dart';
import 'package:savdo_admin/src/widget/empty/empty_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';

class DebtBookScreen extends StatefulWidget {
  const DebtBookScreen({super.key});

  @override
  State<DebtBookScreen> createState() => _DebtBookScreenState();
}

class _DebtBookScreenState extends State<DebtBookScreen> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<AgentsResult> agents = [];
  int idAgent = -1;
  num allDebtUsd = 0,
      allDebtUzs =0,
      allPaymentUzs = 0,
      allPaymentUsd = 0,
      allPaymentOutUzs = 0,
      allPaymentMonthUzs = 0,
      allPaymentMonthUsd = 0,
      allProductUzs = 0,
      allProductUsd = 0,
      allPaymentOutUsd =0;
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  @override
  void initState() {
    clientDebtBloc.getAllClientDebt(dateTime.year,dateTime.month);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return  Scaffold(
        key: _key,
        backgroundColor: AppColors.background,
        appBar: AppBar(
        elevation: 0,
        title: CupertinoSearchTextField(
          autofocus: false,
          onTap: (){
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const SearchDebtClient(),
                transitionDuration: const Duration(milliseconds: 500),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              ),
            );
          },
          placeholder: "Излаш",
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            onSelected: (i){
              if(i ==1){
                clientDebtBloc.debtMonth(dateTime.year, dateTime.month,context);
              }
            },
            itemBuilder: (BuildContext context) {
            return  [
              const PopupMenuItem(
                value: 1,
                child: Text("Ўтган ойдаги қарздорликларни янги ойга олиб ўтиш"),
              ),
            ];
          },),
          IconButton(onPressed: ()async {
            agents = await repository.getAgentsBase();
            setState(() {});
            _key.currentState!.openEndDrawer();
          }, icon: const Icon(Icons.filter_list_alt,)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await repository.clearClientDebtBase();
          clientDebtBloc.getAllClientDebt(dateTime.year,dateTime.month);
        },
        child: StreamBuilder<List<DebtClientModel>>(
          stream: clientDebtBloc.getClientDebtStream,
          builder: (context, snapshot) {
            allDebtUzs =0;
            allDebtUsd =0;
            allPaymentUzs = 0;
            allPaymentUsd = 0;
            allPaymentOutUsd = 0;
            allPaymentOutUzs = 0;
            allPaymentMonthUsd = 0;
            allPaymentMonthUzs = 0;
            allProductUsd = 0;
            allProductUzs = 0;
            if(snapshot.hasData){
              var data = snapshot.data!;
              for(int i =0; i<data.length;i++){
                allDebtUsd += data[i].osKS;
                allDebtUzs += data[i].osK;
                allPaymentUzs += data[i].tlK;
                allPaymentUsd += data[i].tlKS;
                allPaymentOutUzs += data[i].tlC;
                allPaymentOutUsd += data[i].tlCS;
                allPaymentMonthUzs += data[i].klK;
                allPaymentMonthUsd += data[i].klKS;
                allProductUzs += data[i].st;
                allProductUsd += data[i].stS;
              }
              return SnappingSheet(
                  snappingPositions: const [
                    SnappingPosition.factor(
                      positionFactor: 0.0,
                      snappingCurve: Curves.easeOutExpo,
                      snappingDuration: Duration(seconds: 1),
                      grabbingContentOffset: GrabbingContentOffset.top,
                    ),
                    SnappingPosition.pixels(
                      positionPixels: 400,
                      snappingCurve: Curves.elasticOut,
                      snappingDuration: Duration(milliseconds: 1750),
                    ),
                  ],
                  grabbingHeight: 75,
                  // TODO: Add your grabbing widget here,
                  grabbing: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: AppColors.green,
                    ),
                    child: Text("${priceFormat.format(allDebtUzs)} сўм | ${priceFormatUsd.format(allDebtUsd)} \$",style: AppStyle.smallBold(Colors.white),),
                  ),
                  sheetBelow: SnappingSheetContent(
                    draggable: (details) => true,
                    // TODO: Add your sheet content here
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: 16.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ой бошига қолдиқ",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormat.format(allPaymentMonthUzs)} сўм",style: AppStyle.medium(Colors.black)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ой бошига қолдиқ",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormatUsd.format(allPaymentMonthUsd)} \$",style: AppStyle.medium(Colors.black)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Товар чиқим",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormat.format(allProductUzs)} сўм",style: AppStyle.medium(Colors.black)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Товар чиқим",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormatUsd.format(allProductUsd)} \$",style: AppStyle.medium(Colors.black)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Тўлов кирим",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormat.format(allPaymentUzs)} сўм",style: AppStyle.medium(Colors.black)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Тўлов кирим",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormatUsd.format(allPaymentUsd)} \$",style: AppStyle.medium(Colors.black)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Тўлов чиқим",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormat.format(allPaymentOutUzs)} сўм",style: AppStyle.medium(Colors.black)),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          const Row(
                            children: [
                              Expanded(child: DashedRect(color: Colors.grey,gap: 4,)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Тўлов чиқим",style: AppStyle.medium(Colors.black),),
                              Text("${priceFormatUsd.format(allPaymentOutUsd)} \$",style: AppStyle.medium(Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx,index){
                        if(idAgent == data[index].idAgent){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                return DebtBookDetail(data: data[index], idT: data[index].idToch, name: data[index].name,);
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300
                                      )
                                  ),
                                  color: Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.green,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)
                                        )
                                    ),
                                    child: Text(data[index].agentName,style: AppStyle.small(Colors.white),),
                                  ),
                                  SizedBox(height: 8.h,),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.green.shade100,
                                        child: Text(data[index].name[0]),
                                      ),
                                      SizedBox(width: 8.w,),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("${data[index].idToch} - ",style: AppStyle.mediumBold(Colors.black),),
                                              Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("${priceFormat.format(data[index].osK)} сўм",style: AppStyle.medium(data[index].osK.toString()[0] =='-'?Colors.red:Colors.green),),
                                              Text(" | ",style: AppStyle.medium(Colors.black),),
                                              Text("${priceFormatUsd.format(data[index].osKS)} \$",style: AppStyle.medium(data[index].osKS.toString()[0] =='-'?Colors.red:Colors.green),),
                                            ],
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 12.h,),
                                ],
                              ),
                            ),
                          );
                        }else if(idAgent == -1){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                return DebtBookDetail(data: data[index], idT: data[index].idToch, name: data[index].name,);
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300
                                      )
                                  ),
                                  color: Colors.white
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.green,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)
                                        )
                                    ),
                                    child: Text(data[index].agentName,style: AppStyle.small(Colors.white),),
                                  ),
                                  SizedBox(height: 8.h,),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.green.shade100,
                                        child: Text(data[index].name[0]),
                                      ),
                                      SizedBox(width: 8.w,),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("${data[index].idToch} - ",style: AppStyle.mediumBold(Colors.black),),
                                              Text(data[index].name,style: AppStyle.mediumBold(Colors.black),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("${priceFormat.format(data[index].osK)} сўм",style: AppStyle.medium(data[index].osK.toString()[0] =='-'?Colors.red:Colors.green),),
                                              Text(" | ",style: AppStyle.medium(Colors.black),),
                                              Text("${priceFormatUsd.format(data[index].osKS)} \$",style: AppStyle.medium(data[index].osKS.toString()[0] =='-'?Colors.red:Colors.green),),
                                            ],
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                  SizedBox(height: 12.h,),
                                ],
                              ),
                            ),
                          );
                        }else{
                          return const SizedBox();
                        }
                      })
              );
            }
            return const EmptyWidgetScreen();
          }
        ),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: Text("Сана бўйича",style: AppStyle.smallBold(Colors.black),),
              ),
              TextFieldWidget(
                suffixIcon: IconButton(onPressed: ()async{
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
                       repository.clearClientDebtBase();
                      clientDebtBloc.getAllClientDebt(dateTime.year,dateTime.month);
                    }
                  });
                }, icon: Icon(Icons.calendar_month_sharp,color: AppColors.green,)),
                controller: TextEditingController(text: DateFormat('yyyy-MMM').format(dateTime)), hintText: "$dateTime",readOnly: true,),
              Padding(
                padding: EdgeInsets.only(left: 16.w,bottom: 8.h,top: 0.h),
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
                    idAgent = -1;
                    setState(() {});
                  }, child: Text("Тозалаш",style: AppStyle.medium(Colors.red),)))
            ],
          ),
        ),
      ),
    );
  }
}
