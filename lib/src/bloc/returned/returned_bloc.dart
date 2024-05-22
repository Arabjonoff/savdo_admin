import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/returned/returned_model.dart';

class ReturnBloc{
  final Repository _repository = Repository();
  final _fetchReturnedInfo = PublishSubject<List<ReturnedResult>>();
  Stream<List<ReturnedResult>> get getReturnedStream => _fetchReturnedInfo.stream;

  getReturnedAll(year, month, idSkl) async {
    List<AgentsResult> agentBase  = await _repository.getAgentsBase();
    List<ClientResult> clientBase  = await _repository.getClientBase('');
    List<ProductTypeAllResult> warehouse  = await _repository.getWareHouseBase();
    HttpResult result = await _repository.getReturned(year, month, idSkl);
      var data = ReturnedModel.fromJson(result.result);
      for(int i =0;i<data.returnedResult.length;i++){
        for(int j =0; j<agentBase.length;j++){
          if(data.returnedResult[i].idAgent == agentBase[j].id){
            data.returnedResult[i].idAgentName = agentBase[j].name;
          }
        }
        for(int k =0; k<clientBase.length;k++){
          if(data.returnedResult[i].idT == clientBase[k].idT){
            data.returnedResult[i].clientPhone = clientBase[k].tel;
            data.returnedResult[i].clientTarget = clientBase[k].manzil;
            data.returnedResult[i].clientAddress = clientBase[k].muljal;
          }
        }
        for(int l = 0; l<warehouse.length;l++){
          if(data.returnedResult[i].idSkl == warehouse[l].id){
            data.returnedResult[i].sklName = warehouse[l].name;
          }
        }
      }
      _fetchReturnedInfo.sink.add(data.returnedResult);
  }
}
final returnBloc = ReturnBloc();