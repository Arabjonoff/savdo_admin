import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';

class CartRevision{
  final Repository _repository = Repository();
  final _fetchRevisionCartInfo = PublishSubject<List<Map<String,Object>>>();
  Stream<List<Map<String,Object>>> get getRevisionStream => _fetchRevisionCartInfo.stream;


  getAllRevisionCart()async{
    List<Map<String,Object>> cartRevision = await _repository.getRevisionBase();
    _fetchRevisionCartInfo.sink.add(cartRevision);
  }
  updateRevisionCart(){

  }
}
final cartRevision = CartRevision();