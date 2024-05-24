import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class OutcomeBloc{
  final Repository _repository = Repository();
  final _fetchOutcomeInfo = PublishSubject<List<OutcomeResult>>();
  Stream<List<OutcomeResult>> get getOutcomeStream => _fetchOutcomeInfo.stream;

  getAllOutcome(date,idSkl)async{
    List<AgentsResult> agentBase  = await _repository.getAgentsBase();
    List<ClientResult> clientBase  = await _repository.getClientBase();
    List<ProductTypeAllResult> warehouse  = await _repository.getWareHouseBase();
    // CenterDialog.showLoadingDialog(context, 'Бироз кутинг');
    HttpResult result = await _repository.getOutCome(date,idSkl);
    if(result.isSuccess){
      var data = OutcomeModel.fromJson(result.result);
      for(int i=0;i<data.outcomeResult.length;i++){
        for(int j =0; j<agentBase.length;j++){
          if(data.outcomeResult[i].idAgent == agentBase[j].id){
            data.outcomeResult[i].idAgentName = agentBase[j].name;
          }
        }
        for(int k =0; k<clientBase.length;k++){
          if(data.outcomeResult[i].idT == clientBase[k].idT){
            data.outcomeResult[i].clientPhone = clientBase[k].tel;
            data.outcomeResult[i].clientTarget = clientBase[k].manzil;
            data.outcomeResult[i].clientAddress = clientBase[k].muljal;
          }
        }
        for(int l = 0; l<warehouse.length;l++){
          if(data.outcomeResult[i].idSkl == warehouse[l].id){
            data.outcomeResult[i].sklName = warehouse[l].name;
          }
        }
      }
      _fetchOutcomeInfo.sink.add(data.outcomeResult);
      // Navigator.pop(context);
    }
  }
}
final outcomeBloc = OutcomeBloc();