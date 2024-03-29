import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/product/product_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_firma_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_quantity_bloc.dart';
import 'package:savdo_admin/src/bloc/product/product_type_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/ui/main/product/product_firma/add_product_firma.dart';
import 'package:savdo_admin/src/ui/main/product/product_type/add_product_type.dart';
import 'package:savdo_admin/src/ui/main/product/quantity_type/add_quantity_type.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerProductName = TextEditingController();
  final TextEditingController _controllerProductId = TextEditingController();
  final TextEditingController _controllerQuantityName = TextEditingController();
  final TextEditingController _controllerQuantityId = TextEditingController();
  final TextEditingController _controllerFirmaName = TextEditingController();
  final TextEditingController _controllerFirmaId = TextEditingController();
  final TextEditingController _controllerSize =
      TextEditingController(text: '0.00');
  final TextEditingController _controllerMinCount =
      TextEditingController(text: '0.00');
  final Repository _repository = Repository();
  AnimationController? controller;
  bool isStatus = true;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _initBus();
    super.initState();
  }

  @override
  void dispose() {
    productTypeBloc.getProductTypeAll();
    productFirmaTypeBloc.getFirmaBaseTypeAll();
    productQuantityTypeBloc.getQuantityBaseTypeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 4.0.w)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller!.reverse();
        }
      });
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text("Картотека киритиш"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Номи*",
                      style: AppStyle.small(Colors.black),
                    ),
                  ),
                  TextFieldWidget(
                      controller: _controllerName, hintText: 'Номи'),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Text(
                      "Маҳсулот тури*",
                      style: AppStyle.small(Colors.black),
                    ),
                  ),
                  TextFieldWidget(
                    controller: _controllerProductName,
                    hintText: 'Маҳсулот тури',
                    readOnly: true,
                    suffixIcon: IconButton(onPressed: ()=>CenterDialog.showProductTypeDialog(context, "Маҳсулот тури", const AddProductTypeScreen()), icon: const Icon(Icons.arrow_drop_down_circle_outlined),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Text(
                      "Ўлчов бирлиги*",
                      style: AppStyle.small(Colors.black),
                    ),
                  ),
                  TextFieldWidget(
                    controller: _controllerQuantityName,
                    hintText: 'Ўлчов бирлиги',
                    readOnly: true,
                    suffixIcon: IconButton(onPressed: ()=>CenterDialog.showProductTypeDialog(context, "Маҳсулот тури", const AddQuantityScreen()), icon: const Icon(Icons.arrow_drop_down_circle_outlined),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0.w),
                    child: Text(
                      "Ишлаб чиқарилган фирма*",
                      style: AppStyle.small(Colors.black),
                    ),
                  ),
                  TextFieldWidget(
                    controller: _controllerFirmaName,
                    hintText: 'Ишлаб чиқарилган фирма',
                    readOnly: true,
                    suffixIcon: IconButton(onPressed: ()=>CenterDialog.showProductTypeDialog(context, "Маҳсулот тури", const AddProductFirmaScreen()), icon: const Icon(Icons.arrow_drop_down_circle_outlined),),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0.w),
                          child: Text(
                            "Вазни(ихтиёрий)",
                            style: AppStyle.small(Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0.w),
                          child: Text(
                            "Мин Сони(ихтиёрий)",
                            style: AppStyle.small(Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                            controller: _controllerSize, hintText: 'Вазни'),
                      ),
                      Expanded(
                        child: TextFieldWidget(
                            controller: _controllerMinCount,
                            hintText: 'Мин Сони'),
                      )
                    ],
                  ),
                  ListTile(
                    title: Text(
                      "Ишлатилмоқда",
                      style: AppStyle.medium(Colors.black),
                    ),
                    trailing: CupertinoSwitch(
                      onChanged: (i) {
                        isStatus = i;
                        setState(() {});
                      },
                      activeColor: AppColors.green,
                      value: isStatus,
                    ),
                  ),
                  SizedBox(
                    height: 24.w,
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: offsetAnimation,
              builder: (buildContext, child) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: offsetAnimation.value + 4.0.w,
                      right: 4.0.w - offsetAnimation.value),
                  child: ButtonWidget(
                      onTap: () async {
                        if (_controllerName.value.text.isEmpty ||
                            _controllerProductName.value.text.isEmpty ||
                            _controllerQuantityName.value.text.isEmpty ||
                            _controllerFirmaName.value.text.isEmpty) {
                          controller!.forward(from: 0.0);
                        }
                        try {
                          CenterDialog.showLoadingDialog(context, 'Илтимос бир оз кутинг');
                          HttpResult res = await _repository.postProduct(_controllerName.text, int.parse(_controllerProductId.text), int.parse(_controllerQuantityId.text), int.parse(_controllerFirmaId.text), double.parse(_controllerSize.text), double.parse(_controllerMinCount.text), isStatus ? 1 : 0);
                          if (res.result["status"] == true) {
                            await _repository.saveProductBase(Skl2Result.fromJson({"id": res.result["id"], "NAME": _controllerName.text, "ID_TIP": int.parse(_controllerProductId.text), "ID_FIRMA": int.parse(_controllerFirmaId.text), "ID_EDIZ": int.parse(_controllerQuantityId.text), "PHOTO": '', "VZ": double.parse(_controllerSize.text), "MSONI": double.parse(_controllerMinCount.text), "ST": isStatus?1:0, "tipName": _controllerProductName.text, "firmName": _controllerFirmaName.text, "edizName": _controllerQuantityName.text,}));
                            productBloc.getAllProduct();
                            _controllerName.clear();
                          if (context.mounted) Navigator.of(context).pop();
                            CenterDialog.showSuccessDialog(context,);
                          } else {
                            if (context.mounted) Navigator.of(context).pop();
                            if(context.mounted)CenterDialog.showErrorDialog(context, res.result["message"]);
                          }
                        } catch (_) {
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                      color: AppColors.green,
                      text: "Сақлаш"),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _initBus() {
    RxBus.register(tag: "productType").listen((event) {
      _controllerProductName.text = event;
    });
    RxBus.register(tag: "productTypeId").listen((event) {
      _controllerProductId.text = event;
    });
    RxBus.register(tag: "productQuantityName").listen((event) {
      _controllerQuantityName.text = event;
    });
    RxBus.register(tag: "productQuantityId").listen((event) {
      _controllerQuantityId.text = event;
    });
    RxBus.register(tag: "productFirmaName").listen((event) {
      _controllerFirmaName.text = event;
    });
    RxBus.register(tag: "productFirmaId").listen((event) {
      _controllerFirmaId.text = event;
    });
  }
}
