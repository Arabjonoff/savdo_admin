import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/bloc/sklad/sklad_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/outcome/outcome_list_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class DocumentOutComeScreen extends StatefulWidget {
  const DocumentOutComeScreen({super.key});

  @override
  State<DocumentOutComeScreen> createState() => _DocumentOutComeScreenState();
}

class _DocumentOutComeScreenState extends State<DocumentOutComeScreen> {
  final Repository _repository = Repository();
  final TextEditingController _controllerDate = TextEditingController(text: DateTime.now().toIso8601String().substring(0,10));
  final TextEditingController _controllerDocNumber = TextEditingController(text: "999");
  final TextEditingController _controllerClient = TextEditingController();
  final TextEditingController _controllerClientIdT = TextEditingController();
  final TextEditingController _controllerClientHodim = TextEditingController();
  final TextEditingController _controllerClientIdAgent = TextEditingController();
  final TextEditingController _controllerClientIdHaridor = TextEditingController();
  final TextEditingController _controllerClientIdFaol = TextEditingController();
  final TextEditingController _controllerClientIdKlass = TextEditingController();
  final TextEditingController _controllerComment = TextEditingController();
  bool disable = true;
  @override
  void initState() {
    skladBloc.getAllSklad(DateTime.now().year, DateTime.now().month,1);
    _initBus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Чиқим ҳужжати"),
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
                      child: Text("Мол етказиб берувчи:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerClient, hintText: 'Мол етказиб берувчи',readOnly: true,suffixIcon: IconButton(onPressed: () {CenterDialog.showProductTypeDialog(context, 'Мол етказиб берувчи', const DocumentClientScreen());}, icon: const Icon(Icons.perm_contact_calendar_outlined),),),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text("Изох:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerComment, hintText: 'Изох'),
                  ],
                ),
              ),
            ),
            ButtonWidget(
              onTap: () async {
              CenterDialog.showLoadingDialog(context, "Бироз кутинг");
              HttpResult res = await _repository.setDoc(2);
              if(res.result["status"] == true){
                var body = {
                  "NAME": _controllerClient.text,
                  "ID_T": _controllerClientIdT.text,
                  "NDOC": res.result["ndoc"],
                  "SANA": DateTime.now().toString(),
                  "IZOH": _controllerComment.text,
                  "ID_HODIM": _controllerClientHodim.text,
                  "ID_AGENT": _controllerClientIdAgent.text,
                  "ID_HARIDOR": _controllerClientIdHaridor.text,
                  "KURS": 12450,
                  "ID_FAOL": _controllerClientIdFaol.text,
                  "ID_KLASS": _controllerClientIdKlass.text,
                  "ID_SKL": 1,
                  "YIL": DateTime.now().year,
                  "OY":  DateTime.now().month
                };
                HttpResult addDocOutcome = await _repository.addDocOutcome(body);
                if(addDocOutcome.result["status"] == true){
                  if(context.mounted)Navigator.pop(context);
                  if(context.mounted)Navigator.push(context, MaterialPageRoute(builder: (ctx) => OutcomeListScreen(ndocId: addDocOutcome.result["id"],)));
                }
                else{
                  if(context.mounted)CenterDialog.showErrorDialog(context, addDocOutcome.result["message"]);
                }
              }
              else{
                if(context.mounted)CenterDialog.showErrorDialog(context, res.result["message"]);
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
    RxBus.register(tag: 'idAgent').listen((event) {
      _controllerClientIdAgent.text = event;
    });
    RxBus.register(tag: 'idHodimlar').listen((event) {
      _controllerClientHodim.text = event;
    });
    RxBus.register(tag: 'idFaol').listen((event) {
      _controllerClientIdFaol.text = event;
    });
    RxBus.register(tag: 'idKlass').listen((event) {
      _controllerClientIdKlass.text = event;
    });
    RxBus.register(tag: 'idHaridor').listen((event) {
      _controllerClientIdHaridor.text = event;
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
                           if(CacheService.getIdAgent() == data[index].idAgent){
                             return ListTile(
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
                               title: Text("${data[index].idT} - ${data[index].name}",style: AppStyle.medium(Colors.black),),
                             );
                           }
                           else{
                             return const SizedBox();
                           }
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

