import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/client/client_bloc.dart';
import 'package:savdo_admin/src/bloc/client/client_class_bloc.dart';
import 'package:savdo_admin/src/bloc/client/client_type_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/theme/icons/app_fonts.dart';
import 'package:savdo_admin/src/utils/rx_bus.dart';
import 'package:savdo_admin/src/widget/button/button_widget.dart';
import 'package:savdo_admin/src/widget/textfield/textfield_widget.dart';

class UpdateClientScreen extends StatefulWidget {
  final ClientResult data;
  const UpdateClientScreen({super.key, required this.data});

  @override
  State<UpdateClientScreen> createState() => _UpdateClientScreenState();
}

class _UpdateClientScreenState extends State<UpdateClientScreen> {
  bool isd1 = true,isd2 = true,isd3 = true,isd4 = true;
  int d1 = 1,d2 = 1,d3 = 1,d4 = 1;
  int clientType = 0;
  int monday = 0;
  int tuesday = 0;
  int wednesday = 0;
  int thursday = 0;
  int friday = 0;
  int saturday = 0;
  int sunday = 0;
  int idPrice = 1;
   TextEditingController _controllerCode = TextEditingController();
   TextEditingController _controllerName = TextEditingController();
   TextEditingController _controllerPhone = TextEditingController();
   TextEditingController _controllerPassword = TextEditingController();
   TextEditingController _controllerAddress = TextEditingController();
   TextEditingController _controllerTarget = TextEditingController();
   TextEditingController _controllerActivity = TextEditingController();
   TextEditingController _controllerActivityName = TextEditingController();
   TextEditingController _controllerTerritory = TextEditingController();
   TextEditingController _controllerTerritoryName = TextEditingController();
   TextEditingController _controllerComment = TextEditingController();
   final Repository _repository = Repository();
  @override
  void initState() {
    isd1 = widget.data.d1 ==1?true:false;
    isd2 = widget.data.d2 ==1?true:false;
    isd3 = widget.data.d3 ==1?true:false;
    isd4 = widget.data.d4 ==1?true:false;
    monday = widget.data.h1;
    tuesday = widget.data.h2;
    wednesday = widget.data.h3;
    thursday = widget.data.h4;
    friday = widget.data.h5;
    saturday = widget.data.h6;
    sunday = widget.data.h7;
    idPrice = widget.data.idNarh;
    clientType = widget.data.tp;
    _controllerCode = TextEditingController(text: widget.data.idT.toString());
    _controllerName = TextEditingController(text: widget.data.name.toString());
    _controllerPhone = TextEditingController(text: widget.data.tel);
    _controllerPassword = TextEditingController(text: widget.data.pas);
    _controllerAddress = TextEditingController(text: widget.data.manzil);
    _controllerTarget = TextEditingController(text: widget.data.muljal);
    _controllerActivity = TextEditingController(text: widget.data.idFaol.toString());
    _controllerActivityName = TextEditingController(text: widget.data.idFaolName);
    _controllerTerritory = TextEditingController(text: widget.data.idKlass.toString());
    _controllerTerritoryName = TextEditingController(text: widget.data.idKlassName);
    _controllerComment = TextEditingController(text: widget.data.izoh);
    _initBus();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.data.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w,bottom: 8.h,top: 12.h),
                child: Text("Харидор тури",style: AppStyle.small(Colors.black),),
              ),
              Row(
                children: [
                  SizedBox(width: 16.w,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          clientType = 0;
                        });
                      },
                      child: Container(
                        height: 120.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            color: clientType ==0?AppColors.green:Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(child: Icon(Icons.person)),
                            SizedBox(height: 8.h,),
                            Text("Харидор",style: AppStyle.medium(clientType ==0?AppColors.white:Colors.black),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          clientType = 1;
                        });
                      },
                      child: Container(
                        height: 120.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                            color: clientType ==1?AppColors.green:Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(child: Icon(Icons.person)),
                            SizedBox(height: 8.h,),
                            Text("Мол етказиб берувчи",style: AppStyle.medium(clientType ==1?AppColors.white:Colors.black),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                ],
              ),
              Padding(
                padding:EdgeInsets.only(left: 16.0.w,top: 12.h),
                child: Text("Коди*",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerCode, hintText: 'Коди'),
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w),
                child: Text("Исми*",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerName, hintText: 'Исми'),
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w),
                child: Text("Телефон рақами*",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerPhone, hintText: 'Телефон рақами',keyboardType: true,),
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w),
                child: Text("Манзили (ихтиёри)",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerAddress, hintText: 'Манзили'),
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w),
                child: Text("Мўлжал (ихтиёри)",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerTarget, hintText: 'Мўлжал'),
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w),
                child: Text("Фаолият тури*",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerActivityName, hintText: 'Фаолият тури',readOnly: false,suffixIcon: IconButton(onPressed: (){
                CenterDialog.showProductTypeDialog(context, 'Фаолият тури', const AddClientTypeScreen());
              },icon: const Icon(Icons.arrow_drop_down_circle_outlined),),),
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w),
                child: Text("Ҳудуди*",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerTerritoryName, hintText: 'Ҳудуди',readOnly: false,suffixIcon: IconButton(onPressed: (){
                CenterDialog.showProductTypeDialog(context, 'Ҳудуди', const AddClientClassScreen());
              },icon: const Icon(Icons.arrow_drop_down_circle_outlined),),),
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w,top: 8.h),
                child: Text("Изоҳи",style: AppStyle.small(Colors.black),),
              ),
              TextFieldWidget(controller: _controllerComment, hintText: 'Изоҳи'),
              Padding(
                padding:  EdgeInsets.only(left: 16.0.w,top: 8.h,bottom: 8.h),
                child: Text("Ташриф кунлари",style: AppStyle.small(Colors.black),),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 16.w,),
                    GestureDetector(
                      onTap: () {
                        if (monday == 1) {
                          setState(() => monday = 0);
                        } else {
                          setState(() => monday = 1);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: monday==1?AppColors.green:Colors.white
                        ),
                        child: Text("Du",style: AppStyle.mediumBold(monday==1?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: () {
                        if (tuesday == 1) {
                          setState(() => tuesday = 0);
                        } else {
                          setState(() => tuesday = 1);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: tuesday==1?AppColors.green:Colors.white
                        ),
                        child: Text("Se",style: AppStyle.mediumBold(tuesday==1?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: () {
                        if (wednesday == 1) {
                          setState(() => wednesday = 0);
                        } else {
                          setState(() => wednesday = 1);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: wednesday==1?AppColors.green:Colors.white
                        ),
                        child: Text("Chor",style: AppStyle.mediumBold(wednesday==1?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: () {
                        if (thursday == 1) {
                          setState(() => thursday = 0);
                        } else {
                          setState(() => thursday = 1);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: thursday==1?AppColors.green:Colors.white
                        ),
                        child: Text("Pay",style: AppStyle.mediumBold(thursday==1?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: () {
                        if (friday == 1) {
                          setState(() => friday = 0);
                        } else {
                          setState(() => friday = 1);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: friday==1?AppColors.green:Colors.white
                        ),
                        child: Text("Juma",style: AppStyle.mediumBold(friday==1?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: () {
                        if (saturday == 1) {
                          setState(() => saturday = 0);
                        } else {
                          setState(() => saturday = 1);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: saturday==1?AppColors.green:Colors.white
                        ),
                        child: Text("Shan",style: AppStyle.mediumBold(saturday==1?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: () {
                        if (sunday == 1) {
                          setState(() => sunday = 0);
                        } else {
                          setState(() => sunday = 1);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: sunday==1?AppColors.green:Colors.white
                        ),
                        child: Text("Yak",style: AppStyle.mediumBold(sunday==1?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 16.w,),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w,top: 8.h,bottom: 8.h),
                child: Text("Сотиш нархи",style: AppStyle.small(Colors.black),),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 16.w,),
                    GestureDetector(
                      onTap: (){
                        idPrice = 1;
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.h,
                        padding: EdgeInsets.symmetric(horizontal: 24.w,),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            color: idPrice==1?AppColors.green:Colors.white
                        ),
                        child: Text('1-Нарх',style: AppStyle.mediumBold(idPrice ==1?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: (){
                        idPrice = 2;
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.h,
                        padding: EdgeInsets.symmetric(horizontal: 24.w,),                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: idPrice==2?AppColors.green:Colors.white
                      ),
                        child: Text('2-Нарх',style: AppStyle.mediumBold(idPrice ==2?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: (){
                        idPrice = 3;
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.h,
                        padding: EdgeInsets.symmetric(horizontal: 24.w,),                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          color: idPrice==3?AppColors.green:Colors.white
                      ),
                        child: Text('3-Нарх',style: AppStyle.mediumBold(idPrice ==3?Colors.white:Colors.black),),
                      ),
                    ),
                    SizedBox(width: 16.w,),
                  ],
                ),
              ),
              clientType==0?Padding(
                padding:  EdgeInsets.only(left: 16.0.w,top: 8.h,bottom: 8.h),
                child: Text("Рухсатлар",style: AppStyle.small(Colors.black),),
              ):const SizedBox(),
              clientType==0?Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color:Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.card
                ),
                child: ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  title: Text("Телефондан рухсат"),
                  children: [
                    ListTile(
                      title: Text("Телефондан киришга рухсат"),
                      trailing: CupertinoSwitch(value: isd1, onChanged: (bool value) { setState(() => isd1 = value);isd1==false?d1=0:d1=1;},),
                    ),
                    ListTile(
                      title: Text("Буюртма жўнатиш"),
                      trailing: CupertinoSwitch(value: isd2, onChanged: (bool value) {  setState(() => isd2 = value);isd2==false?d2=0:d2=1; },),
                    ),
                    ListTile(
                      title: Text("Қарздорлик кўриш"),
                      trailing: CupertinoSwitch(value: isd3, onChanged: (bool value) {  setState(() => isd3 = value);isd3==false?d3=0:d3=1; },),
                    ),
                    ListTile(
                      title: Text("Маҳсулот қолдиғини кўриш"),
                      trailing: CupertinoSwitch(value: isd4, onChanged: (bool value) {  setState(() => isd4 = value);isd4==false?d4=0:d4=1; },),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 16.0.w,top: 12.h),
                      child: Text("Пароль*",style: AppStyle.small(Colors.black),),
                    ),
                    TextFieldWidget(controller: _controllerPassword, hintText: 'Пароль'),
                  ],
                ),
              ):const SizedBox(),
              SizedBox(height: 32.h,),
              ButtonWidget(onTap: () async {
                if(context.mounted)CenterDialog.showLoadingDialog(context, "Бир оз кутинг");
                Map<String,dynamic> addClient = {
                  "ID": widget.data.id,
                  "NAME": _controllerName.text,
                  "ID_T": _controllerCode.text,
                  "IZOH": _controllerComment.text,
                  "MANZIL": _controllerAddress.text,
                  "TEL": _controllerPhone.text,
                  "TP": clientType,
                  "ID_NARH": idPrice,
                  "ID_FAOL": _controllerActivity.text,
                  "ID_KLASS": _controllerTerritory.text,
                  "ID_AGENT": 'idAgent',
                  "SMS": 0,
                  "VAQT": DateTime.now().toString(),
                  "ID_HODIMLAR": '',
                  "NAQD": 0,
                  "PAS": _controllerPassword.text,
                  "D1": d1,
                  "D2": d2,
                  "D3": d3,
                  "D4": d4,
                  "H1": monday,
                  "H2": tuesday,
                  "H3": wednesday,
                  "H4": thursday,
                  "H5": friday,
                  "H6": saturday,
                  "H7": sunday,
                  "MULJAL": _controllerTarget.text,
                  "ST": 1,
                };
                HttpResult res = await _repository.updateClient(addClient);
                if(res.result["status"] == true){
                  Map<String,dynamic> saveBaseClient = {
                    "ID": widget.data.id,
                    "NAME": _controllerName.text,
                    "ID_T": _controllerCode.text,
                    "IZOH": _controllerComment.text,
                    "MANZIL": _controllerAddress.text,
                    "TEL": _controllerPhone.text,
                    "TP": clientType,
                    "ID_NARH": idPrice,
                    "ID_FAOL": int.parse(_controllerActivity.text),
                    "ID_KLASS": int.parse(_controllerTerritory.text),
                    "ID_AGENT": 0,
                    "SMS": 0,
                    "VAQT": DateTime.now().toString(),
                    "ID_HODIMLAR": 0,
                    "NAQD": 0,
                    "PAS": _controllerPassword.text,
                    "D1": d1,
                    "D2": d2,
                    "D3": d3,
                    "D4": d4,
                    "H1": monday,
                    "H2": tuesday,
                    "H3": wednesday,
                    "H4": thursday,
                    "H5": friday,
                    "H6": saturday,
                    "H7": sunday,
                    "MULJAL": _controllerTarget.text,
                    "ST": 1,
                  };
                  _repository.updateClientBase(ClientResult.fromJson(saveBaseClient));
                  if(context.mounted)Navigator.pop(context);
                  if(context.mounted)Navigator.pop(context);
                  CenterDialog.showSuccessDialog(context,);
                  await clientBloc.getAllClient('');
                  clientBloc.getAllClient('');
                }else{
                  if(context.mounted)Navigator.pop(context);
                  if(context.mounted)CenterDialog.showErrorDialog(context, res.result["message"]);
                }
              }, color: AppColors.green, text: "Янгилаш"),
              SizedBox(height: 12.h,),
            ],
          ),
        ),
      ),
    );
  }

  void _initBus() {
    RxBus.register(tag: "clientTypeId").listen((event) {
      _controllerActivity.text = event;
    });
    RxBus.register(tag: "clientTypeName").listen((event) {
      _controllerActivityName.text = event;
    });
    RxBus.register(tag: "clientClassId").listen((event) {
      _controllerTerritory.text = event;
    });
    RxBus.register(tag: "clientClassName").listen((event) {
      _controllerTerritoryName.text = event;
    });
  }
}

class AddClientTypeScreen extends StatefulWidget {
  const AddClientTypeScreen({super.key});

  @override
  State<AddClientTypeScreen> createState() => _AddClientTypeScreenState();
}
class _AddClientTypeScreenState extends State<AddClientTypeScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    clientTypeBloc.getAllClientType();
    super.initState();
  }

  final Repository _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 8.h),
            height: 50.h,
            decoration: BoxDecoration(
                border: Border.all(color:Colors.grey.shade600),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.card
            ),
            child: TextField(
              controller: _controller,
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: "Фаолият тури",
                  suffixIcon: IconButton(onPressed: () async {
                    HttpResult res = await _repository.addClientType(_controller.text);
                    if(res.result["status"] == true){
                      await _repository.saveClientTypeBase(ProductTypeAllResult(id: res.result['id'], name: _controller.text, st: 1));
                      await clientTypeBloc.getAllClientType();
                      _controller.clear();
                    }
                  }, icon: const Icon(Icons.add_circle,))
              ),
            ),
          ),
          Expanded(
              child:
              StreamBuilder<List<ProductTypeAllResult>>(
                  stream: clientTypeBloc.getClientTypeStream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var data = snapshot.data!;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (ctx,index){
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (i)async{
                                      HttpResult res = await _repository.deleteClientType(data[index].name,data[index].id);
                                      if(res.result["status"] == true){
                                        await _repository.deleteClientTypeBase(data[index].id);
                                        clientTypeBloc.getAllClientType();
                                      }
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                  )
                                ],
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                onTap: (){
                                  RxBus.post(data[index].id.toString(),tag: "clientTypeId");
                                  RxBus.post(data[index].name,tag: "clientTypeName");
                                  Navigator.pop(context);
                                },
                                title: Text(data[index].name,style: AppStyle.medium(Colors.black),),
                              ),
                            );
                          });
                    }
                    return const SizedBox();
                  }
              ))
        ],
      ),
    );
  }
}

class AddClientClassScreen extends StatefulWidget {
  const AddClientClassScreen({super.key});

  @override
  State<AddClientClassScreen> createState() => _AddClientClassScreenState();
}
class _AddClientClassScreenState extends State<AddClientClassScreen> {
  final Repository _repository = Repository();
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    clientClassBloc.getAllClientClass();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 8.h),
            height: 50.h,
            decoration: BoxDecoration(
                border: Border.all(color:Colors.grey.shade600),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.card
            ),
            child: TextField(
              controller: _controller,
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ҳудуди",
                  suffixIcon: IconButton(onPressed: ()async{
                    HttpResult res = await _repository.addClientClass(_controller.text);
                    if(res.result["status"] == true){
                      _repository.saveClientClassTypeBase(
                        ProductTypeAllResult(id: res.result['id'], name: _controller.text, st: 1),
                      );
                      await clientClassBloc.getAllClientClass();
                      _controller.clear();
                    }
                  }, icon: const Icon(Icons.add_circle,))
              ),
            ),
          ),
          Expanded(child: StreamBuilder<List<ProductTypeAllResult>>(
              stream: clientClassBloc.getClientClassStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  var data = snapshot.data!;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx,index){
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (i)async{
                                  HttpResult res = await _repository.deleteClientClass(data[index].name, data[index].id);
                                  if(res.result['status'] == true){
                                    await _repository.deleteClientClassBase(data[index].id);
                                    await clientClassBloc.getAllClientClass();
                                  }
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                              )
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            onTap: (){
                              RxBus.post(data[index].id.toString(),tag: "clientClassId");
                              RxBus.post(data[index].name,tag: "clientClassName");
                              Navigator.pop(context);
                            },
                            title: Text(data[index].name,style: AppStyle.medium(Colors.black),),
                          ),
                        );
                      });
                }
                return const SizedBox();
              }
          ))
        ],
      ),
    );
  }
}

