import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/sklad/sklad_bloc.dart';
import 'package:savdo_admin/src/bloc/sklad/warehouse_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/income/documnet_income_screen.dart';
import 'package:savdo_admin/src/ui/main/warehouse/warehouse_transfer/warehouse_from_screen.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class WarehouseDocumentScreen extends StatefulWidget {
  const WarehouseDocumentScreen({super.key});

  @override
  State<WarehouseDocumentScreen> createState() => _WarehouseDocumentScreenState();
}

class _WarehouseDocumentScreenState extends State<WarehouseDocumentScreen> {
  final Repository _repository = Repository();
  final TextEditingController _controllerDate = TextEditingController(text: DateTime.now().toIso8601String().substring(0,10));
  final TextEditingController _controllerDocNumber = TextEditingController(text: "999");
  final TextEditingController _controllerClient = TextEditingController();
  final TextEditingController _controllerClientIdT = TextEditingController();
  final TextEditingController _controllerComment = TextEditingController();
  final TextEditingController _controllerWarehouseFrom = TextEditingController();
  final TextEditingController _controllerWarehouseFromId = TextEditingController();
  final TextEditingController _controllerWarehouseTo = TextEditingController();
  final TextEditingController _controllerWarehouseToId = TextEditingController();
  @override
  void initState() {
    _initBus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Омбор ҳужжати"),
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
                    TextFieldWidget(controller: _controllerClient, hintText: 'Мол етказиб берувчи',readOnly: true,suffixIcon: IconButton(onPressed: () =>CenterDialog.showProductTypeDialog(context, 'Мол етказиб берувчи', const DocumentClientScreen()), icon: const Icon(Icons.perm_contact_calendar_outlined),),),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text("Қайси омбордан:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerWarehouseFrom, hintText: 'Қайси омбордан',readOnly: true,suffixIcon: IconButton(onPressed: () =>CenterDialog.showWarehouseDialog(context, 1), icon: const Icon(Icons.arrow_drop_down_circle_outlined),)),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text("Қайси омборга:",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerWarehouseTo, hintText: 'Қайси омборга',readOnly: true,suffixIcon: IconButton(onPressed: () =>CenterDialog.showWarehouseDialog(context, 2), icon: const Icon(Icons.arrow_drop_down_circle_outlined),),),
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
              if(_controllerWarehouseFromId.text == _controllerWarehouseToId.text){
                CenterDialog.showErrorDialog(context, "Омборлар номи бир-хил бўлиши мумкин эмас");
              }
              else{
                skladBloc.getAllSklad(DateTime.now().year, DateTime.now().month,int.parse(_controllerWarehouseFromId.text));
                CenterDialog.showLoadingDialog(context, "Бир оз кутинг");
                HttpResult setDoc = await _repository.setDoc(5);
                Map data = {
                  "NDOC":setDoc.result['ndoc'],
                  "SANA":DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  "IZOH": _controllerComment.text,
                  "ID_HODIM":_controllerClientIdT.text,
                  "ID_SKL": _controllerWarehouseFromId.text,
                  "ID_SKL_TO":_controllerWarehouseToId.text,
                  "YIL": DateTime.now().year,
                  "OY":DateTime.now().month
                };
                HttpResult res = await _repository.warehouseTransfer(data);
                if(res.result["status"] == true && setDoc.result["status"] == true){
                  _repository.clearIncomeProductBase();
                  if(context.mounted)Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return WareHouseFromScreen(data: {
                      "NDOC":res.result["id"],
                      "warehouseFromName":_controllerWarehouseFrom.text,
                      "warehouseFromId":_controllerWarehouseFromId.text,
                      "warehouseToName":_controllerWarehouseTo.text,
                      "warehouseToId":_controllerWarehouseToId.text
                    },);
                  }));
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
    RxBus.register(tag: 'warehouseFromName').listen((event) {
      _controllerWarehouseFrom.text = event;
    });
    RxBus.register(tag: 'warehouseFromId').listen((event) async{
      await _repository.clearSkladBase();
      _controllerWarehouseFromId.text = event;
    });
    RxBus.register(tag: 'warehouseToName').listen((event) {
      _controllerWarehouseTo.text = event;
    });
    RxBus.register(tag: 'warehouseToId').listen((event) {
      _controllerWarehouseToId.text = event;
    });
  }
}
