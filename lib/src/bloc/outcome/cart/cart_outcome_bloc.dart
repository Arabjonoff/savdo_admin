import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/bloc/returned/returned_bloc.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class CartOutcomeBloc{
  final Repository _repository  = Repository();
  final _fetchCartOutcomeCartInfo = PublishSubject<List<SklRsTov>>();
  Stream<List<SklRsTov>> get getCartOutcomeStream => _fetchCartOutcomeCartInfo.stream;

  getAllCartOutcome()async{
    List<SklRsTov> cartOutcomeBase = await _repository.getOutcomeCart();
    _fetchCartOutcomeCartInfo.sink.add(cartOutcomeBase);
  }
  deleteCartOutcome(id,idSklRs, idSkl2,data,context,bool isReturned)async{
    CenterDialog.showLoadingDialog(context, 'Бироз кутинг');
    if(isReturned){
      HttpResult result = await _repository.deleteReturned(idSklRs, idSkl2,id);
      if(result.result['status'] == true){
        await _repository.deleteOutcomeCart(id);
        // await returnBloc.getReturnedAll(DateTime.now().year, DateTime.now().month, CacheService.getWareHouseId());
        await getAllCartOutcome();
        Navigator.pop(context);
      }
    }else{
      HttpResult result = await _repository.deleteOutcomeSklRs(id, idSklRs, idSkl2);
      if(result.result['status'] == true){
        await _repository.deleteOutcomeCart(id);
        await getAllCartOutcome();
        Navigator.pop(context);
      }
    }
  }
}
final cartOutcomeBloc = CartOutcomeBloc();