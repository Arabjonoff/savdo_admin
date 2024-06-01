import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/revision/revision_model.dart';

class RevisionBloc{
  final Repository _repository = Repository();
  final _fetchRevisionInfo = PublishSubject<List<RevisionResult>>();
  Stream<List<RevisionResult>> get getRevisionStream => _fetchRevisionInfo.stream;

  getAllRevision(year,month,idSkl)async{
    List<AgentsResult> agentBase  = await _repository.getAgentsBase();
    List<ClientResult> clientBase  = await _repository.getClientBase();
    List<ProductTypeAllResult> warehouse  = await _repository.getWareHouseBase();
    HttpResult result = await _repository.getRevision(year,month,idSkl);
    var data = RevisionModel.fromJson(result.result);
    for(int i=0; i<data.data.length;i++){
      for(int j =0; j<agentBase.length;j++){
        if(data.data[i].idHodim == agentBase[j].id){
          data.data[i].agentName = agentBase[j].name;
        }
      }
    }
    _fetchRevisionInfo.sink.add(data.data);
  }
}
final revisionBloc = RevisionBloc();