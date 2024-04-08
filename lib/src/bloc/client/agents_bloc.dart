import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';

class AgentsBloc{
  final Repository _repository = Repository();
  final _fetchAgentsInfo = PublishSubject<List<AgentsResult>>();
  Stream<List<AgentsResult>> get getAgentsStream => _fetchAgentsInfo.stream;

  getAllAgents()async{
    List<AgentsResult> agentBase = await _repository.getAgentsBase();
    _fetchAgentsInfo.sink.add(agentBase);
    if(agentBase.isEmpty){
      HttpResult result = await _repository.getClientWorker();
      if(result.isSuccess){
        var data = AgentsModel.fromJson(result.result);
        for(int i=0;i<data.data.length;i++){
          await _repository.saveAgentsBase(data.data[i]);
        }
        _fetchAgentsInfo.sink.add(data.data);
      }
    }
  }
}
final agentsBloc = AgentsBloc();