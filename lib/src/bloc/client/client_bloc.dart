import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class ClientBloc{
  final Repository _repository = Repository();
  final _fetchClientInfo = PublishSubject<List<ClientResult>>();
  final _fetchClientInfoSearch = PublishSubject<List<ClientResult>>();
  Stream<List<ClientResult>> get getClientStream => _fetchClientInfo.stream;
  Stream<List<ClientResult>> get getClientSearchStream => _fetchClientInfoSearch.stream;


  getAllClient()async{
    /// Agent Base
    List<AgentsResult> agentBase = await _repository.getAgentsBase();
    /// Client Base
    List<ClientResult> clientBase = await _repository.getClientBase();
    /// Client Type Base
    List<ProductTypeAllResult> clientTypeBase = await _repository.getClientTypeBase();
    /// Client Class Base
    List<ProductTypeAllResult> clientClassBase = await _repository.getClientClassTypeBase();

    List<DebtClientModel> clientDebtBase = await _repository.getClientDebtBase();


    for(int i = 0; i < clientBase.length;i++){
      for(int a = 0;a<agentBase.length;a++){
        if(clientBase[i].idAgent == agentBase[a].id){
          clientBase[i].agentName = agentBase[a].name;
          clientBase[i].agentId = agentBase[a].id;
        }
      }
      for(int j =0; j < clientTypeBase.length; j++){
        if(clientBase[i].idFaol == clientTypeBase[j].id){
          clientBase[i].idFaolName = clientTypeBase[j].name;
        }
      }
      for(int n = 0; n < clientClassBase.length;n++){
        if(clientBase[i].idKlass == clientClassBase[n].id){
          clientBase[i].idKlassName = clientClassBase[n].name;
        }
      }
      for(int k =0; k<clientDebtBase.length;k++){
        if(clientBase[i].idT == clientDebtBase[k].idToch){
          clientBase[i].osK = clientDebtBase[k].osK;
          clientBase[i].osKS = clientDebtBase[k].osKS;
        }
      }
    }
    _fetchClientInfo.sink.add(clientBase);
    if(clientBase.isEmpty){
      HttpResult result = await _repository.getDebtClientDetail();
      if(result.isSuccess){
        var data = ClientModel.fromJson(result.result);
          for(int i=0; i<data.data.length;i++){
            for(int j =0; j<clientTypeBase.length;j++){
              if(data.data[i].idFaol == clientTypeBase[j].id){
                data.data[i].idFaolName = clientTypeBase[j].name;
              }
            }
            for(int n =0; n<clientClassBase.length;n++){
              if(data.data[i].idKlass == clientClassBase[n].id){
                data.data[i].idKlassName = clientClassBase[n].name;
              }
            }
            for(int k =0; k<clientDebtBase.length;k++){
              if(data.data[i].idT == clientDebtBase[k].idToch){
                data.data[i].osK = clientDebtBase[k].osK;
                data.data[i].osKS = clientDebtBase[k].osKS;
              }
            }
            _repository.saveClientBase(data.data[i]);
        }
        _fetchClientInfo.sink.add(data.data);
      }
    }
    if(clientDebtBase.isEmpty){
      HttpResult debtResult = await _repository.clientDebt(DateTime.now().year,DateTime.now().month);
      var dataDebt = debtClientModelFromJson(json.encode(debtResult.result));
      for(int i =0; i<dataDebt.length;i++){
        await _repository.saveClientDebtBase(dataDebt[i]);
      }
    }
  }
  getAllClientSearch(obj)async{
    /// Agent Base
    List<DebtClientModel> clientDebtBase = await _repository.getClientDebtBase();
    List<AgentsResult> agentBase = await _repository.getAgentsBase();
    List<ProductTypeAllResult> clientTypeBase = await _repository.getClientTypeBase();
    List<ProductTypeAllResult> clientClassBase = await _repository.getClientClassTypeBase();
    List<ClientResult> clientBase = await _repository.getClientBase();
    for(int i=0; i<clientBase.length;i++){
      for(int a = 0;a<agentBase.length;a++){
        if(clientBase[i].idAgent == agentBase[a].id){
          clientBase[i].agentName = agentBase[a].name;
          clientBase[i].agentId = agentBase[a].id;
        }
      }
      for(int j =0; j<clientTypeBase.length;j++){
        if(clientBase[i].idFaol == clientTypeBase[j].id){
          clientBase[i].idFaolName = clientTypeBase[j].name;
        }
      }
      for(int n =0; n<clientClassBase.length;n++){
        if(clientBase[i].idKlass == clientClassBase[n].id){
          clientBase[i].idKlassName = clientClassBase[n].name;
        }
      }
      for(int k =0; k<clientDebtBase.length;k++){
        if(clientBase[i].idT == clientDebtBase[k].idToch){
          clientBase[i].osK = clientDebtBase[k].osK;
          clientBase[i].osKS = clientDebtBase[k].osKS;
        }
      }
    }
    _fetchClientInfoSearch.sink.add(clientBase);
  }
}
final clientBloc = ClientBloc();