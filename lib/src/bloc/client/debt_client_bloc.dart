import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/model/client/debt_detail_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';

class ClientDebtBloc{
  final Repository _repository = Repository();
  final _fetchClientDebtInfo = PublishSubject<List<DebtClientModel>>();
  final _fetchClientDebtSearchInfo = PublishSubject<List<DebtClientModel>>();
  final _fetchClientDebtDetailInfo = PublishSubject<List<DebtClientDetail>>();
  Stream<List<DebtClientModel>> get getClientDebtStream => _fetchClientDebtInfo.stream;
  Stream<List<DebtClientModel>> get getClientDebtSearchStream => _fetchClientDebtSearchInfo.stream;
  Stream<List<DebtClientDetail>> get getClientDebtDetailStream => _fetchClientDebtDetailInfo.stream;

  getAllClientDebt(year,month)async{
    List<AgentsResult> agentBase = await _repository.getAgentsBase();
    List<DebtClientModel> clientDebtBase = await _repository.getClientDebtBase();
    for(int i = 0; i<clientDebtBase.length;i++){
      for(int a = 0;a<agentBase.length;a++){
        if(clientDebtBase[i].idAgent == agentBase[a].id){
          clientDebtBase[i].agentName = agentBase[a].name;
          clientDebtBase[i].agentId = agentBase[a].id;
        }
      }
    }
    _fetchClientDebtInfo.sink.add(clientDebtBase);
    if(clientDebtBase.isEmpty){
      HttpResult result = await _repository.clientDebt(year,month);
      var data = debtClientModelFromJson(json.encode(result.result));
      for(int i = 0; i<data.length;i++){
        for(int a = 0;a<agentBase.length;a++){
          if(data[i].idAgent == agentBase[a].id){
            data[i].agentName = agentBase[a].name;
            data[i].agentId = agentBase[a].id;
          }
        }
        _repository.saveClientDebtBase(data[i]);
      }
      _fetchClientDebtInfo.sink.add(data);
    }
  }
  getAllClientDebtSearch(obj)async{
    List<AgentsResult> agentBase = await _repository.getAgentsBase();
    List<DebtClientModel> clientDebtBase = await _repository.getClientDebtSearchBase(obj);
    for(int i = 0; i<clientDebtBase.length;i++){
      for(int a = 0;a<agentBase.length;a++){
        if(clientDebtBase[i].idAgent == agentBase[a].id){
          clientDebtBase[i].agentName = agentBase[a].name;
          clientDebtBase[i].agentId = agentBase[a].id;
        }
      }
    }
    _fetchClientDebtSearchInfo.sink.add(clientDebtBase);
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