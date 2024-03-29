
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/barcode_model.dart';

class BarcodeProductBloc{
  final Repository _repository = Repository();
  final _fetchBarcodeDetailInfo = PublishSubject<List<BarcodeResult>>();
  final _fetchBarcodeInfo = PublishSubject<List<BarcodeResult>>();
  Stream<List<BarcodeResult>> get getBarcodeDetailStream => _fetchBarcodeDetailInfo.stream;
  Stream<List<BarcodeResult>> get getBarcodeStream => _fetchBarcodeInfo.stream;

  getBarcodeDetail(id)async{
      HttpResult response = await _repository.getBarcodeDetail(id);
      if(response.isSuccess){
        var data = BarcodeModel.fromJson(response.result);
        _fetchBarcodeDetailInfo.sink.add(data.data);
    }
  }
  getBarcodeAll()async{
    List<BarcodeResult> barcodeBase = await _repository.getBarcodeBase();
    _fetchBarcodeInfo.sink.add(barcodeBase);
    if(barcodeBase.isEmpty){
      HttpResult response = await _repository.getBarcode();
      if(response.isSuccess){
        var data = BarcodeModel.fromJson(response.result);
        for(int i =0; i<data.data.length;i++){
          await _repository.saveBarcodeBase(data.data[i]);
        }
        _fetchBarcodeInfo.sink.add(data.data);
      }
    }
  }
}
final barcodeProductBloc = BarcodeProductBloc();