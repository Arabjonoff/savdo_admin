import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class ClientClassBloc{
  final Repository _repository = Repository();
  final _fetchClientClassInfo = PublishSubject<List<ProductTypeAllResult>>();
  Stream<List<ProductTypeAllResult>> get getClientClassStream => _fetchClientClassInfo.stream;

  getAllClientClass()async{
    List<ProductTypeAllResult> clientClassBase = await _repository.getClientClassTypeBase();
    _fetchClientClassInfo.sink.add(clientClassBase);
    if(clientClassBase.isEmpty){
      HttpResult result = await _repository.getClientClass();
      var event = ProductTypeAll.fromJson(result.result);
      for(int i =0; i<event.data.length; i++){
        await _repository.saveClientClassTypeBase(event.data[i]);
      }
      _fetchClientClassInfo.sink.add(event.data);
    }
  }
}

final clientClassBloc = ClientClassBloc();