
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';

class OutcomeBloc{
  final Repository _repository = Repository();
  final _fetchOutcomeInfo = PublishSubject<List<OutcomeResult>>();
  Stream<List<OutcomeResult>> get getOutcomeStream => _fetchOutcomeInfo.stream;

  getAllOutcome(date)async{
    // CenterDialog.showLoadingDialog(context, 'Бироз кутинг');
    HttpResult result = await _repository.getOutCome(date);
    if(result.isSuccess){
      var data = OutcomeModel.fromJson(result.result);
      _fetchOutcomeInfo.sink.add(data.outcomeResult);
      // Navigator.pop(context);
    }
  }
}
final outcomeBloc = OutcomeBloc();