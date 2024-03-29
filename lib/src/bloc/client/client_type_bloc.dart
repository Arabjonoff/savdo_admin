
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class ClientTypeBloc{
  final Repository _repository = Repository();
  final _fetchClientTypeInfo = PublishSubject<List<ProductTypeAllResult>>();
  Stream<List<ProductTypeAllResult>> get getClientTypeStream => _fetchClientTypeInfo.stream;


  getAllClientType()async{
    List<ProductTypeAllResult> clientTypeBase = await _repository.getClientTypeBase();
    _fetchClientTypeInfo.sink.add(clientTypeBase);
    if(clientTypeBase.isEmpty){
      HttpResult result = await _repository.getClientType();
      var event = ProductTypeAll.fromJson(result.result);
      for(int i =0; i<event.data.length; i++){
        await _repository.saveClientTypeBase(event.data[i]);
      }
      _fetchClientTypeInfo.sink.add(event.data);

    }
  }
}

final clientTypeBloc = ClientTypeBloc();