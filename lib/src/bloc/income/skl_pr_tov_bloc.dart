import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/income/income_model.dart';

class SklPrTovBloc{
  final Repository _repository = Repository();
  final _fetchSklPrTovInfo = PublishSubject<List<SklPrTovResult>>();
  Stream<List<SklPrTovResult>> get getSklPrTov => _fetchSklPrTovInfo.stream;

  getAllSklPrTov(List<SklPrTovResult> sklPrTovResult)async{
    List<SklPrTovResult> sklPrBase = await _repository.getSklPrTovBase();
    _fetchSklPrTovInfo.sink.add(sklPrBase);
    if(sklPrBase.isEmpty){
      for(int i =0; i<sklPrTovResult.length;i++){
        _repository.sklPrTovBase(sklPrTovResult[i]);
      }
      _fetchSklPrTovInfo.sink.add(sklPrBase);
    }
  }
  getAllSklPrTovAll()async{
    List<SklPrTovResult> sklPrBase = await _repository.getSklPrTovBase();
    _fetchSklPrTovInfo.sink.add(sklPrBase);
  }
}
final sklPrTovBloc = SklPrTovBloc();