import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/sklad/sklad_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/drawer/income/documnet_income_screen.dart';
import 'package:savdo_admin/src/ui/drawer/outcome/outcome_list_screen.dart';
import 'package:savdo_admin/src/utils/cache.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class DocumentOutComeScreen extends StatefulWidget {
  final dynamic ndoc;
  final Map map;
  const DocumentOutComeScreen({super.key, this.ndoc, required this.map});

  @override
  State<DocumentOutComeScreen> createState() => _DocumentOutComeScreenState();
}

class _DocumentOutComeScreenState extends State<DocumentOutComeScreen> {
  final Repository _repository = Repository();
  final TextEditingController _controllerDate = TextEditingController(text: DateTime.now().toIso8601String().substring(0,10));
   TextEditingController _controllerDocNumber = TextEditingController();
  final TextEditingController _controllerClient = TextEditingController();
  final TextEditingController _controllerClientIdT = TextEditingController();
  final TextEditingController _controllerClientHodim = TextEditingController();
  final TextEditingController _controllerClientIdAgent = TextEditingController();
  final TextEditingController _controllerClientIdHaridor = TextEditingController();
  final TextEditingController _controllerClientIdFaol = TextEditingController();
  final TextEditingController _controllerClientIdKlass = TextEditingController();
  final TextEditingController _controllerComment = TextEditingController();
  bool disable = true;
  bool isUpdate=false;
  dynamic ndocId;
  @override
  void initState() {
    _controllerDocNumber = TextEditingController(text: widget.ndoc.toString());
    skladBloc.getAllSklad(DateTime.now().year, DateTime.now().month,CacheService.getWareHouseId());
    if(widget.map.isEmpty){}else{
      _controllerClient.text = widget.map["clientName"];
      _controllerClientIdT.text = widget.map["clientId"];
      _controllerClientIdAgent.text = widget.map["idAgent"];
      _controllerClientHodim.text = widget.map["idHodimlar"];
      _controllerClientIdFaol.text = widget.map["idFaol"];
      _controllerClientIdKlass.text =  widget.map["idKlass"];
      _controllerClientIdHaridor.text = widget.map["idHaridor"];
    }
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
                        Expanded(child: TextFieldWidget(controller: _controllerDocNumber, hintText: "№:",)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text("Харидорлар:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerClient, hintText: 'Харидорлар',readOnly: true,suffixIcon: IconButton(onPressed: () {CenterDialog.showProductTypeDialog(context, 'Харидорлар', const DocumentClientScreen());}, icon: const Icon(Icons.perm_contact_calendar_outlined),),),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text("Изох (ихтиёри):",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerComment, hintText: 'Ихтиёри'),
                  ],
                ),
              ),
            ),
            ButtonWidget(
              onTap: () async {
              CenterDialog.showLoadingDialog(context, "Бироз кутинг");
              var body = {
                "NAME": _controllerClient.text,
                "ID_T": _controllerClientIdT.text,
                "NDOC": _controllerDocNumber.text,
                "SANA": DateTime.now().toString(),
                "IZOH": _controllerComment.text.replaceAll("'", "`"),
                "ID_HODIM": _controllerClientHodim.text,
                "ID_AGENT": _controllerClientIdAgent.text,
                "ID_HARIDOR": _controllerClientIdHaridor.text,
                "KURS": CacheService.getCurrency(),
                "ID_FAOL": _controllerClientIdFaol.text,
                "ID_KLASS": _controllerClientIdKlass.text,
                "ID_SKL": CacheService.getidSkl(),
                "YIL": DateTime.now().year,
                "OY":  DateTime.now().month
              };
              if(isUpdate ==false){
                HttpResult addDocOutcome = await _repository.addDocOutcome(body);
                if(addDocOutcome.result["status"] == true){
                  isUpdate = true;
                  ndocId = addDocOutcome.result["id"];
                  CacheService.saveNdoc(addDocOutcome.result["id"]);
                  if(context.mounted)Navigator.pop(context);
                  if(context.mounted)Navigator.push(context, MaterialPageRoute(builder: (ctx) => OutcomeListScreen(ndocId: addDocOutcome.result["id"],)));
                }
                else{
                  if(context.mounted)CenterDialog.showErrorDialog(context, addDocOutcome.result["message"]);
                }
              }
              else{
                var bodyUpd = {
                  "NAME": _controllerClient.text,
                  "ID_T": _controllerClientIdT.text,
                  "NDOC": _controllerDocNumber.text,
                  "SANA": DateTime.now().toString(),
                  "IZOH": _controllerComment.text.replaceAll("'", "`"),
                  "ID_HODIM": _controllerClientHodim.text,
                  "ID_AGENT": _controllerClientIdAgent.text,
                  "ID_HARIDOR": _controllerClientIdHaridor.text,
                  "KURS": CacheService.getCurrency(),
                  "ID_FAOL": _controllerClientIdFaol.text,
                  "ID_KLASS": _controllerClientIdKlass.text,
                  "ID": CacheService.getNdoc(),
                };
                HttpResult addDocOutcome = await _repository.updateDocOutcome(bodyUpd);
                if(addDocOutcome.result["status"] == true){
                  if(context.mounted)Navigator.pop(context);
                  if(context.mounted)Navigator.push(context, MaterialPageRoute(builder: (ctx) => OutcomeListScreen(ndocId: ndocId,)));
                }
                else{
                  if(context.mounted)CenterDialog.showErrorDialog(context, addDocOutcome.result["message"]);
                }
              }
            }, color: AppColors.green, text: "Ҳужжатни сақлаш",),
          ],
        ),
      ),
    );
  }

  void _initBus() async{
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


