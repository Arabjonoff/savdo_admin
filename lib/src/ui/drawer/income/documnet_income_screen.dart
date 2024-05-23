import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/bloc/income/income_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/route/app_route.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class DocumentIncomeScreen extends StatefulWidget {
  final Map map;
  final dynamic ndoc;
  const DocumentIncomeScreen({super.key, this.ndoc, required this.map});

  @override
  State<DocumentIncomeScreen> createState() => _DocumentIncomeScreenState();
}

class _DocumentIncomeScreenState extends State<DocumentIncomeScreen> {
  final Repository _repository = Repository();
  final TextEditingController _controllerDate = TextEditingController(text: DateTime.now().toIso8601String().substring(0,10));
  final TextEditingController _controllerDocNumber = TextEditingController(text: "999");
  final TextEditingController _controllerClient = TextEditingController();
  final TextEditingController _controllerClientIdT = TextEditingController();
  final TextEditingController _controllerComment = TextEditingController();
  final TextEditingController _controllerHodimID = TextEditingController();
  bool isUpdate=false;
  dynamic ndocId;
  @override
  void initState() {
    _controllerDocNumber.text = widget.ndoc.toString();
    if(widget.map.isEmpty){}else{
      _controllerClient.text = widget.map["clientName"];
      _controllerClientIdT.text = widget.map["clientId"];
      _controllerHodimID.text = widget.map["idHodimlar"];
    }
    _initBus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Кирим ҳужжати"),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 14.0.w,top: 14.h),
                      child: Row(
                        children: [
                          Expanded(child: Text("Сана:",style: AppStyle.small(Colors.black),)),
                          Expanded(child: Text("№:",style: AppStyle.small(Colors.black),)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: TextFieldWidget(controller: _controllerDate, hintText: "Сана",readOnly: true,)),
                        Expanded(child: TextFieldWidget(controller: _controllerDocNumber, hintText: "№:",readOnly: true,)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text("Харидорлар:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerClient, hintText: 'Харидорлар',readOnly: true,suffixIcon: IconButton(onPressed: () =>CenterDialog.showProductTypeDialog(context, 'Мол етказиб берувчи', const DocumentClientScreen()), icon: const Icon(Icons.perm_contact_calendar_outlined),),),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text("Изох:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerComment, hintText: 'Изох'),
                  ],
                ),
              ),
            ),
            ButtonWidget(onTap: () async {
              CenterDialog.showLoadingDialog(context, "Бир оз кутинг");
              var body = {
                "NAME": _controllerClient.text,
                "ID_T": _controllerClientIdT.text,
                "NDOC": widget.ndoc,
                "SANA": _controllerDate.text,
                "IZOH": _controllerComment.text,
                "ID_HODIM": _controllerHodimID.text,
                "ID_SKL": CacheService.getWareHouseId(),
                "YIL": DateTime.now().year,
                "OY": DateTime.now().month
              };
              if(isUpdate == false){
                HttpResult res = await _repository.addIncome(body);
                if(res.result["status"] == true){
                  isUpdate = true;
                  if(context.mounted)Navigator.pop(context);
                  if(context.mounted)Navigator.pushNamed(context, AppRouteName.addIncome,arguments: res.result["id"]);
                  incomeBloc.getAllIncome(DateTime.now().year,DateTime.now().month,CacheService.getWareHouseId());
                }
              }else{
                var bodyUpd = {
                  "ID":CacheService.getNdoc(),
                  "NAME": _controllerClient.text,
                  "ID_T": _controllerClientIdT.text,
                  "NDOC": widget.ndoc,
                  "SANA": _controllerDate.text,
                  "IZOH": _controllerComment.text,
                  "ID_HODIM": _controllerHodimID.text,
                  "ID_SKL": CacheService.getWareHouseId(),
                  "YIL": DateTime.now().year,
                  "OY": DateTime.now().month
                };
                HttpResult res = await _repository.updateIncome(bodyUpd);
                if(res.result["status"] == true){
                  isUpdate = true;
                  if(context.mounted)Navigator.pop(context);
                  if(context.mounted)Navigator.pushNamed(context, AppRouteName.addIncome,arguments: res.result["id"]);
                  incomeBloc.getAllIncome(DateTime.now().year,DateTime.now().month,CacheService.getWareHouseId());
                }
              }
            }, color: AppColors.green, text: "Ҳужжатни сақлаш"),
          ],
        ),
      ),
    );
  }

  void _initBus() {
    RxBus.register(tag: 'clientName').listen((event) {
      _controllerClient.text = event;
    });
    RxBus.register(tag: 'clientId').listen((event) {
      _controllerClientIdT.text = event;
    });
    RxBus.register(tag: 'idHodimlar').listen((event) {
      _controllerHodimID.text = event;
    });
  }
}

class DocumentClientScreen extends StatefulWidget {
  const DocumentClientScreen({super.key});

  @override
  State<DocumentClientScreen> createState() => _DocumentClientScreenState();
}

class _DocumentClientScreenState extends State<DocumentClientScreen> {
  final TextEditingController _controllerSearch = TextEditingController();

  @override
  void initState() {
    clientBloc.getAllClientSearch('');
    clientBloc.getAllClient('');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:StreamBuilder<List<ClientResult>>(
            stream: clientBloc.getClientSearchStream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var data = snapshot.data!;
                return Column(
                  children: [
                    CupertinoSearchTextField(
                      placeholder: "Излаш",
                      controller: _controllerSearch,
                      onChanged: (i){
                        clientBloc.getAllClientSearch(i);
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx,index){
                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                onTap: (){
                                  CacheService.saveClientIdT(data[index].idT);
                                  CacheService.saveIdHodim(data[index].idHodimlar);
                                  CacheService.saveClientName(data[index].name);
                                  RxBus.post(data[index].name,tag: 'clientName');
                                  RxBus.post(data[index].idT.toString(),tag: 'clientId');
                                  RxBus.post(data[index].idAgent.toString(),tag: 'idAgent');
                                  RxBus.post(data[index].idHodimlar.toString(),tag: 'idHodimlar');
                                  RxBus.post(data[index].idFaol.toString(),tag: 'idFaol');
                                  RxBus.post(data[index].idKlass.toString(),tag: 'idKlass');
                                  RxBus.post(data[index].id.toString(),tag: 'idHaridor');
                                  RxBus.post(data[index].osK.toString(),tag: 'clientDebtUsd');
                                  RxBus.post(data[index].osKS.toString(),tag: 'clientDebtUzs');
                                  Navigator.pop(context);
                                },
                                title: Text("${data[index].idT}-${data[index].name}",style: AppStyle.medium(Colors.black),),
                                trailing: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                        color: data[index].tp==0?Colors.green:Colors.red,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text(data[index].tp==1?"Мол етказувчи":"Харидор",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              );
                          }
                      ),
                    ),
                  ],
                );}
              return const SizedBox();
            }
        ),
      ),
    );
  }
}

