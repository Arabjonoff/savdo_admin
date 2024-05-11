import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/income/income_model.dart';

class IncomeBloc{
  final Repository _repository = Repository();
  final _fetchIncomeInfo = PublishSubject<IncomeModel>();
  Stream<IncomeModel> get getIncomeStream => _fetchIncomeInfo.stream;
  getAllIncome(year,month,idSkl)async{
    HttpResult res = await _repository.getIncome(year,month,idSkl);
    if(res.isSuccess){
      var data = IncomeModel.fromJson(res.result);
      _fetchIncomeInfo.sink.add(data);
    }
  }
}

final incomeBloc = IncomeBloc();