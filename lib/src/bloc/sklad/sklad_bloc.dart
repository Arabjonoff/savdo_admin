import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';

class SkladBloc{
  final Repository _repository = Repository();
  final _fetchSkladInfo = PublishSubject<List<SkladResult>>();
  final _fetchSkladSearchInfo = PublishSubject<List<SkladResult>>();
  Stream<List<SkladResult>> get getSkladStream => _fetchSkladInfo.stream;
  Stream<List<SkladResult>> get getSkladSearchStream => _fetchSkladSearchInfo.stream;

  getAllSklad(year, month,idSkl)async{
    List<Skl2Result> productBase = await _repository.getProductBase();
    List<SkladResult> skladBase = await _repository.getSkladBase();
    for(int i =0; i<skladBase.length;i++){
      for(int j =0; j<productBase.length;j++){
        if(skladBase[i].idSkl2 == productBase[j].id){
          skladBase[i].photo = productBase[j].photo;
          skladBase[i].idFirmaName = productBase[j].firmName;
          skladBase[i].idEdizName = productBase[j].edizName;
          skladBase[i].idTipName = productBase[j].tipName;
        }
      }
    }
    _fetchSkladInfo.sink.add(skladBase);
    if(skladBase.isEmpty){
      HttpResult result = await _repository.getSklad(year, month,idSkl);
      if(result.isSuccess){
        var data = SkladModel.fromJson(result.result);
        for(int i =0; i<data.data.length;i++){
          for(int j =0;j<productBase.length;j++){
            if(data.data[i].idSkl2 == productBase[j].id){
              data.data[i].photo = productBase[j].photo;
              data.data[i].idFirmaName = productBase[j].firmName;
              data.data[i].idEdizName = productBase[j].edizName;
              data.data[i].idTipName = productBase[j].tipName;
            }
          }
          await _repository.saveSkladBase(data.data[i]);
        }
        _fetchSkladInfo.sink.add(data.data);
      }
    }
  }

  getAllSkladSearch(year, month,idSkl,obj)async{
    List<Skl2Result> productBase = await _repository.getProductBase();
    List<SkladResult> skladBase = await _repository.getSkladSearchBase(obj);
    for(int i = 0; i<skladBase.length;i++){
      for(int j =0; j<productBase.length;j++){
        if(skladBase[i].idSkl2 == productBase[j].id){
          skladBase[i].photo = productBase[j].photo;
          skladBase[i].idFirmaName = productBase[j].firmName;
          skladBase[i].idEdizName = productBase[j].edizName;
          skladBase[i].idTipName = productBase[j].tipName;
        }
      }
    }
    _fetchSkladSearchInfo.sink.add(skladBase);
  }

}
final skladBloc = SkladBloc();