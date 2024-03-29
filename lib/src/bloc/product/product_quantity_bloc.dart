
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class ProductQuantityTypeBloc{

  final Repository _repository = Repository();
  final _fetchQuantityTypeInfo = PublishSubject<List<ProductTypeAllResult>>();
  Stream<List<ProductTypeAllResult>> get getQuantityTypeStream => _fetchQuantityTypeInfo.stream;

  getQuantityBaseTypeAll()async{
    List<ProductTypeAllResult> quantityBase = await _repository.getQuantityTypBase();
    _fetchQuantityTypeInfo.sink.add(quantityBase);
    if(quantityBase.isEmpty){
      HttpResult result = await _repository.getQuantityType();
      if(result.isSuccess){
        var data = ProductTypeAll.fromJson(result.result);
        for(int i=0; i<data.data.length;i++){
          await _repository.saveQuantityTypeBase(data.data[i]);
          _fetchQuantityTypeInfo.sink.add(data.data);
        }
      }
    }
  }
}
final productQuantityTypeBloc = ProductQuantityTypeBloc();