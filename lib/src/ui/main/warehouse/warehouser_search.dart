import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:savdo_admin/src/api/api_provider.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';
import 'package:savdo_admin/src/ui/main/main_screen.dart';
import 'package:savdo_admin/src/ui/main/product/product_image/image_preview.dart';

import '../../../bloc/sklad/sklad_bloc.dart';
import '../../../theme/icons/app_fonts.dart';

class WareHouseSearch extends StatefulWidget {
  const WareHouseSearch({super.key});

  @override
  State<WareHouseSearch> createState() => _WareHouseSearchState();
}

class _WareHouseSearchState extends State<WareHouseSearch> {
  final Repository _repository = Repository();
  final TextEditingController _controllerDate = TextEditingController();
  int wareHouse = 1;
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  List sklad = [];
  List<Map> sendData = [];
  @override
  void initState() {
    skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,wareHouse,'');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight),
          child: Padding(
            padding:EdgeInsets.only(left: 8.0.w,right: 8.0.w,bottom: 8.0.w,),
            child: CupertinoSearchTextField(
              autofocus: true,
              placeholder: "Излаш",
              onChanged: (i){
                skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,wareHouse,i);
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<SkladResult>>(
          stream: skladBloc.getSkladSearchStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              int productCount = 0;
              var data = snapshot.data!;
              for(int i =0; i<data.length;i++){
                productCount++;
              }
              return data.isEmpty?const Center(child: Text("Маълумотлар ёқ")):
              Column(
                children: [
                  Expanded(child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx,index){
                        return data[index].osoni == 0?const SizedBox():GestureDetector(
                          onTap: (){
                            _repository.clearSkladBase();
                          },
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (i){},
                                  backgroundColor: Colors.red,
                                  label: "Ўчириш",
                                  icon: Icons.delete,)
                              ],
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
                              height: 100.h,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300
                                      )
                                  )
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      CenterDialog.showImageDialog(context, data[index].name, ImagePreview(photo: data[index].photo,));
                                    },
                                    child: Container(
                                      width: 80.r,
                                      height: 80.r,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white
                                      ),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>  Icon(Icons.error_outline,size: 23.h,),
                                        imageUrl: 'https://naqshsoft.site/images/$db/${data[index].photo}',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w,),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].name,maxLines:2,style: AppStyle.mediumBold(Colors.black),),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          data[index].snarhi != 0?Text("${priceFormat.format(data[index].snarhi)} сўм",style: AppStyle.medium(Colors.black),):Text("${priceFormatUsd.format(data[index].snarhiS)} \$",style: AppStyle.medium(Colors.black),),
                                          Text(priceFormatUsd.format(data[index].osoni),style: AppStyle.medium(Colors.black),),
                                        ],
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
  dateTimePickerWidget(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
          ),
          child: child!,
        );
      },
    ).then((selectedDate) {
      // After selecting the date, display the time picker.
      if (selectedDate != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
        );
        _controllerDate.text = DateFormat('yyyy-MM-dd').format(selectedDateTime);
      }
    });
  }
}
void handleReadOnlyInputClick(context) {
  showBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: YearPicker(
          selectedDate: DateTime(1997),
          firstDate: DateTime(1995),
          lastDate: DateTime.now(),
          onChanged: (val) {
            print(val);
            Navigator.pop(context);
          },
        ),
      )
  );
}

