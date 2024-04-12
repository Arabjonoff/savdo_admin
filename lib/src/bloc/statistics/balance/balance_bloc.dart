import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/balance/balance_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';

class BalanceBloc{
  final Repository _repository = Repository();
  final _fetchBalanceInfo = PublishSubject<BalanceModel>();
  Stream<BalanceModel> get  getBalanceStream => _fetchBalanceInfo.stream;

  getAllBalance(date)async{
    num balanceUzs = 0;
    HttpResult result = await _repository.getBalance(date);
    if(result.isSuccess){
      var data = BalanceModel.fromJson(result.result);
      data.balance = (data.sklSm+data.kzSm+data.tlSm)-(data.psSm-data.oySm);
      _fetchBalanceInfo.sink.add(data);
    }
  }
}
final balanceBloc = BalanceBloc();