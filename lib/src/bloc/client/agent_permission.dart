import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';

class AgentPermission{
  final Repository _repository = Repository();
  final _fetchAgentPermissionInfo = PublishSubject();
}