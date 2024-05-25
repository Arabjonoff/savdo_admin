import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/sklad/sklad_bloc.dart';
import 'package:savdo_admin/src/model/product/barcode_model.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';
import 'package:savdo_admin/src/theme/colors/app_colors.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class RevisionListScreen extends StatefulWidget {
  const RevisionListScreen({super.key});

  @override
  State<RevisionListScreen> createState() => _RevisionListScreenState();
}

class _RevisionListScreenState extends State<RevisionListScreen> {
  DateTime dateTime = DateTime(DateTime.now().year,DateTime.now().month);
  int wareHouseId = 1;
  @override
  void initState() {
    wareHouseId = CacheService.getWareHouseId();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Repository repository = Repository();
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          placeholder: "Излаш",
          suffixIcon:const Icon(Icons.qr_code_scanner, size: 25,),
          suffixMode: OverlayVisibilityMode.always,
          onSuffixTap: ()async{
            List<BarcodeResult> barcodeBase = await repository.getBarcodeBase();
            List<SkladResult> outcomeBase = await repository.getSkladBase();
            var result = await BarcodeScanner.scan();
            result.rawContent;
            // for(int i = 0; i<barcodeBase.length;i++){
            //   if(barcodeBase[i].shtr == result.rawContent){
            //     for(int j = 0; j<outcomeBase.length;j++){
            //       if(barcodeBase[i].idSkl2 == outcomeBase[j].id){
            //         price = 0;
            //         priceUsd = 0;
            //         if (idPrice == 0) {
            //           if (outcomeBase[j].snarhi != 0) {
            //             price = outcomeBase[j].snarhi;
            //           } else {
            //             price = outcomeBase[j].snarhiS;
            //             priceUsd = 1;
            //           }
            //         } else if (idPrice == 1) {
            //           if (outcomeBase[j].snarhi1 != 0) {
            //             price = outcomeBase[j].snarhi1;
            //           } else {
            //             price = outcomeBase[j].snarhi1S;
            //             priceUsd = 1;
            //           }
            //         } else if (idPrice == 2) {
            //           if (outcomeBase[j].snarhi2 != 0) {
            //             price = outcomeBase[j].snarhi2;
            //           } else {
            //             price = outcomeBase[j].snarhi2S;
            //             priceUsd = 1;
            //           }
            //         }
            //         BottomDialog.showScreenDialog(context, AddOutcomeWidgetDialog(data: outcomeBase[j], price: price, priceUsd: priceUsd,ndocId: widget.ndocId, typeName: outcomeBase[j].idEdizName,isReturned: true,));
            //       }
            //     }
            //   }
            // }
          },
          onChanged: (i)async{
            await skladBloc.getAllSkladSearch(dateTime.year, dateTime.month,wareHouseId,i);
          },
        ),
        backgroundColor: AppColors.background,
      ),
    );
  }
}
