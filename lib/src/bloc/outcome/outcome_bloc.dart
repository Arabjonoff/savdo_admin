
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';

class OutcomeBloc{
  final Repository _repository = Repository();
  final _fetchOutcomeInfo = PublishSubject<List<OutcomeResult>>();
  Stream<List<OutcomeResult>> get getOutcomeStream => _fetchOutcomeInfo.stream;

  getAllOutcome(date)async{
    List<AgentsResult> agentBase  = await _repository.getAgentsBase();
    // CenterDialog.showLoadingDialog(context, 'Бироз кутинг');
    HttpResult result = await _repository.getOutCome(date);
    if(result.isSuccess){
      var data = OutcomeModel.fromJson(result.result);
      for(int i=0;i<data.outcomeResult.length;i++){
        for(int j =0; j<agentBase.length;j++){
          if(data.outcomeResult[i].idAgent == agentBase[j].id){
            data.outcomeResult[i].idAgentName = agentBase[j].name;
          }
        }
      }
      _fetchOutcomeInfo.sink.add(data.outcomeResult);
      // Navigator.pop(context);
    }
  }
}
final outcomeBloc = OutcomeBloc();