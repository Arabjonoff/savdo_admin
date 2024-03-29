
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/payments/payments_model.dart';

class IncomePayBloc{
  final Repository _repository = Repository();
  final _fetchIncomePayInfo = PublishSubject<List<PaymentsResult>>();
  Stream<List<PaymentsResult>> get getIncomePayStream => _fetchIncomePayInfo.stream;

  getAllIncomePay(date)async{
    HttpResult result = await _repository.getPaymentsDaily(date);
    var data = PaymentsModel.fromJson(result.result);
    _fetchIncomePayInfo.sink.add(data.data);
  }
}
final incomePayBloc = IncomePayBloc();