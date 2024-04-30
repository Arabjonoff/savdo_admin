import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/model/client/debt_detail_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';

class ClientDebtBloc{
  final Repository _repository = Repository();
  final _fetchClientDebtInfo = PublishSubject<List<DebtClientModel>>();
  final _fetchClientDebtDetailInfo = PublishSubject<List<DebtClientDetail>>();
  Stream<List<DebtClientModel>> get getClientDebtStream => _fetchClientDebtInfo.stream;
  Stream<List<DebtClientDetail>> get getClientDebtDetailStream => _fetchClientDebtDetailInfo.stream;

  getAllClientDebt()async{
    List<DebtClientModel> clientDebtBase = await _repository.getClientDebtBase();
    _fetchClientDebtInfo.sink.add(clientDebtBase);
    if(clientDebtBase.isEmpty){
      HttpResult result = await _repository.clientDebt();
      var data = debtClientModelFromJson(json.encode(result.result));
      for(int i=0; i<data.length;i++){
        _repository.saveClientDebtBase(data[i]);
      }
      _fetchClientDebtInfo.sink.add(data);
    }
  }
  getClientDebtDetail(year,month,idT,tp)async{
    HttpResult result = await _repository.clientDetail(year,month, idT,tp);
    if(result.isSuccess){
      var data = debtClientDetailFromJson(json.encode(result.result));
      _fetchClientDebtDetailInfo.sink.add(data);
    }
  }
}
final clientDebtBloc = ClientDebtBloc();