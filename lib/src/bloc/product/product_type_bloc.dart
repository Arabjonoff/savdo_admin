import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class ProductTypeBloc{
  final Repository _repository = Repository();
  final _fetchProductTypeInfo = PublishSubject<List<ProductTypeAllResult>>();
  Stream<List<ProductTypeAllResult>> get getProductTypeStream => _fetchProductTypeInfo.stream;

  getProductTypeAll()async{
    List<ProductTypeAllResult> productBase = await _repository.getProductTypeBase();
    _fetchProductTypeInfo.sink.add(productBase);
    if(productBase.isEmpty){
      HttpResult result = await _repository.getProductType();
      if(result.isSuccess){
          var data = ProductTypeAll.fromJson(result.result);
          for(int i=0; i<data.data.length;i++){
            await _repository.saveProductTypeBase(data.data[i]);
          }
          _fetchProductTypeInfo.sink.add(data.data);
      }
    }
  }
}

final productTypeBloc = ProductTypeBloc();