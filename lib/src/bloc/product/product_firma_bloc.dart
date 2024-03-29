import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class ProductFirmaTypeBloc{
  final Repository _repository = Repository();
  final _fetchFirmaTypeInfo = PublishSubject<List<ProductTypeAllResult>>();
  Stream<List<ProductTypeAllResult>> get getFirmaTypeStream => _fetchFirmaTypeInfo.stream;

  getFirmaBaseTypeAll()async{
    List<ProductTypeAllResult> firmaBase = await _repository.getFirmaTypeBase();
    _fetchFirmaTypeInfo.sink.add(firmaBase);
    if(firmaBase.isEmpty){
      HttpResult result = await _repository.getFirmaType();
      if(result.isSuccess){
        var data = ProductTypeAll.fromJson(result.result);
        for(int i=0; i<data.data.length;i++){
          await _repository.saveFirmaTypeBase(data.data[i]);
        }
        _fetchFirmaTypeInfo.sink.add(data.data);
      }
    }
  }
}

final productFirmaTypeBloc = ProductFirmaTypeBloc();