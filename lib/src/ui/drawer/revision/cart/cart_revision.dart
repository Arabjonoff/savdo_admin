import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';

class CartRevision{
  final Repository _repository = Repository();
  final _fetchRevisionCartInfo = PublishSubject<List<SklRsTov>>();
  Stream<List<SklRsTov>> get getRevisionStream => _fetchRevisionCartInfo.stream;


  getAllRevisionCart()async{
    List<SklRsTov> cartRevision = await _repository.getOutcomeCart();
    _fetchRevisionCartInfo.sink.add(cartRevision);
  }
  updateRevisionCart(){

  }
}