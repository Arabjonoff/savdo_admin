import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class WareHouseBloc{
  final Repository _repository = Repository();
  final _fetchWareHouseInfo = PublishSubject<List<ProductTypeAllResult>>();
  Stream<List<ProductTypeAllResult>> get getWareHouseStream => _fetchWareHouseInfo.stream;

  getAllWareHouse()async{
    List<ProductTypeAllResult> wareHouseBase = await _repository.getWareHouseBase();
    _fetchWareHouseInfo.sink.add(wareHouseBase);
    if(wareHouseBase.isEmpty){
      HttpResult result = await _repository.getWareHouse();
      if(result.isSuccess){
        var event = ProductTypeAll.fromJson(result.result);
        for(int i=0;i<event.data.length;i++){
          await _repository.saveWareHouseBase(event.data[i]);
        }
        _fetchWareHouseInfo.sink.add(event.data);
      }
    }
  }
}
final wareHouseBloc = WareHouseBloc();