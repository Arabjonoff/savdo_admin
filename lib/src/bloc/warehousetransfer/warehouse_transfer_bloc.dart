import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/warehousetransfer/warehouse_model.dart';

class WareHouseTransferBloc{
  final Repository _repository = Repository();
  final _fetchWareHouseTransferInfo = PublishSubject<List<WareHouseResult>>();
  Stream<List<WareHouseResult>> get getWarehouseTransferStream => _fetchWareHouseTransferInfo.stream;

  getAllWareHouseTransfer(year, month)async{
    List<ProductTypeAllResult> wareHouseBase = await _repository.getWareHouseBase();
    HttpResult result = await _repository.getWarehouseTransfer(year, month);
    if(result.isSuccess){
      var data = WareHouseTransferModel.fromJson(result.result);
      for(int i = 0; i<data.data.length; i++){
        for(int j = 0; j<wareHouseBase.length; j++){
          if(data.data[i].idSkl == wareHouseBase[j].id){
            data.data[i].warehouseFrom = wareHouseBase[j].name;
          }
          if(data.data[i].idSklTo == wareHouseBase[j].id){
            data.data[i].warehouseTo = wareHouseBase[j].name;
          }
        }
      }
      _fetchWareHouseTransferInfo.sink.add(data.data);
    }
  }
}

final wareHouseTransferBloc = WareHouseTransferBloc();