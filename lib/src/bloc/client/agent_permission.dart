import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agent_permission_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';

class AgentPermission{
  final Repository _repository = Repository();
  final _fetchAgentPermissionInfo = PublishSubject<List<AgentPermissionResult>>();
  Stream<List<AgentPermissionResult>> get getPermissionStream => _fetchAgentPermissionInfo.stream;

  getAllPermission(id)async{
    HttpResult result = await _repository.getAgentPermission(id);
    var data = AgentPermissionModel.fromJson(result.result);
    _fetchAgentPermissionInfo.sink.add(data.data);
  }
}
final agentPermission = AgentPermission();