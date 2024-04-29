import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';

class ClientDebtBloc{
  final Repository _repository = Repository();
  final _fetchClientDebtInfo = PublishSubject<List<DebtClientModel>>();
  Stream<List<DebtClientModel>> get getClientDebtStream => _fetchClientDebtInfo.stream;

  getAllClientDebt()async{
    List<DebtClientModel> clientDebtBase = await _repository.getClientDebtBase();
    _fetchClientDebtInfo.sink.add(clientDebtBase);
    if(clientDebtBase.isEmpty){
      HttpResult result = await _repository.clientDebt();
      var data = DebtClientModel.fromJson(result.result);
      _fetchClientDebtInfo.sink.add([data]);
    }
  }
}
final clientDebtBloc = ClientDebtBloc();