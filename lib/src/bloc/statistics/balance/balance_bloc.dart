import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/balance/balance_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class BalanceBloc{
  final Repository _repository = Repository();
  final _fetchBalanceInfo = PublishSubject<BalanceModel>();
  Stream<BalanceModel> get  getBalanceStream => _fetchBalanceInfo.stream;

  getAllBalance(date)async{
    HttpResult currency = await _repository.getCurrency();
    CacheService.saveCurrency(currency.result["KURS"]);
    HttpResult result = await _repository.getBalance(date);
    if(result.isSuccess){
      var data = BalanceModel.fromJson(result.result);
      data.balance = (data.sklSm+data.kzSm+data.tlSm)-(data.psSm-data.oySm);
      data.balanceUsd = (data.sklSmS+data.kzSmS+data.tlSmS)-(data.psSmS-data.oySmS);
      _fetchBalanceInfo.sink.add(data);
    }
  }
}
final balanceBloc = BalanceBloc();