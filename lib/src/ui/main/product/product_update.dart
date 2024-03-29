// ignore_for_file: use_build_context_synchronously

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

class UpdateProductScreen extends StatefulWidget {
  final String name,productName,quantityName,firmName,photo;
  final int productId,quantityId,firmId;
  final num size,minCount;
  final int status;
  final int id;
  const UpdateProductScreen({super.key, required this.name, required this.productName, required this.quantityName, required this.firmName, required this.size, required this.minCount, required this.status, required this.productId, required this.quantityId, required this.firmId, required this.id, required this.photo});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen>
    with SingleTickerProviderStateMixin {
   TextEditingController _controllerName = TextEditingController();
   TextEditingController _controllerProductName = TextEditingController();
   TextEditingController _controllerProductId = TextEditingController();
   TextEditingController _controllerQuantityName = TextEditingController();
   TextEditingController _controllerQuantityId = TextEditingController();
   TextEditingController _controllerFirmaName = TextEditingController();
   TextEditingController _controllerFirmaId = TextEditingController();
   TextEditingController _controllerSize = TextEditingController(text: '0.00');
   TextEditingController _controllerMinCount = TextEditingController(text: '0.00');
  final Repository _repository = Repository();
  AnimationController? controller;
  bool isStatus = true;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _initBus();
    _controllerName = TextEditingController(text: widget.name);
     _controllerProductName = TextEditingController(text: widget.productName);
     _controllerProductId = TextEditingController(text: widget.productId.toString());
     _controllerQuantityName = TextEditingController(text: widget.quantityName);
     _controllerQuantityId = TextEditingController(text: widget.quantityId.toString());
     _controllerFirmaName = TextEditingController(text: widget.firmName);
     _controllerFirmaId = TextEditingController(text: widget.firmId.toString());
     _controllerSize = TextEditingController(text: widget.size.toString());
     _controllerMinCount = TextEditingController(text: widget.minCount.toString());
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
        title: Text(widget.name),
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
                          CenterDialog.showLoadingDialog(
                              context, 'Илтимос бир оз кутинг');
                          HttpResult res = await _repository.updateProduct(
                              widget.id,
                              _controllerName.text,
                              int.parse(_controllerProductId.text),
                              int.parse(_controllerQuantityId.text),
                              int.parse(_controllerFirmaId.text),
                              num.parse(_controllerSize.text),
                              num.parse(_controllerMinCount.text),
                              isStatus ? 1 : 0);
                          if (res.result["status"] == true) {
                            var body = {
                              "ID": widget.id,
                              "NAME":_controllerName.text,
                              "ID_TIP":int.parse(_controllerProductId.text),
                              "ID_EDIZ":int.parse(_controllerQuantityId.text),
                              "ID_FIRMA":int.parse(_controllerFirmaId.text),
                              "VZ":num.parse(_controllerSize.text),
                              "MSONI":num.parse(_controllerMinCount.text),
                              "ST":isStatus ? 1 : 0,
                            };
                            await _repository.updateProductBase(Skl2Result.fromJson(body));
                            await productBloc.getAllProduct();
                            if (context.mounted) Navigator.of(context).pop();
                            if (context.mounted) Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result["message"]), backgroundColor: AppColors.green,));
                          } else {
                            if (context.mounted) Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.result["message"]), backgroundColor: Colors.red,));
                          }
                        } catch (e) {
                          if (context.mounted) Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.toString()), backgroundColor: Colors.red,));
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
