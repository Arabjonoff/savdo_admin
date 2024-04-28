import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/sklad/get_sklad_per_model.dart';

class SkladPerBloc{
  final Repository _repository = Repository();
  final _fetchSkladPerInfo = PublishSubject<List<GetSkladPerResult>>();
  Stream<List<GetSkladPerResult>> get getSkladPerStream => _fetchSkladPerInfo.stream;
  List sklad = [];
  getAllSkladPer(year, month, idSkl)async{
    HttpResult result = await _repository.getSkladPer(year, month, idSkl);
    if(result.isSuccess){
      var data = GetSkladPerModel.fromJson(result.result);
      for(int i =0; i<data.data.length;i++){
        sklad.add(data.data[i].idSkl2);
      }
      if(sklad.length <= 1000){
        restAllSkladPer2(year, month, idSkl);
      }
      else{
        restAllSkladPer(year, month, idSkl,0,20);
      }
      _fetchSkladPerInfo.sink.add(data.data);
    }
  }
  restAllSkladPer(year, month, idSkl,start,end)async{
    List<Map> data = [];
    try{
      for(int i=start; i<end;i++){
        data.add({'ID_SKL2':sklad[i]});
      }
      restAllSkladPer(year, month, idSkl,start+=20,end+=20);
    }catch(_){
      sklad.clear();
    }
  }
  restAllSkladPer2(year, month, idSkl)async{
    List<Map> data = [];
    try{
      for(int i=0; i<sklad.length;i++){
        data.add({'ID_SKL2':sklad[i]});
      }
      HttpResult result = await _repository.resetSkladPer(data, year, month, idSkl);
      if(result.result["status"] == true){
        sklad.clear();
      }
    }catch(_){
      sklad.clear();
    }
  }
  List skl = [];
  getSkladSkl(year, month, idSkl)async{
    HttpResult result = await _repository.getSkladSkl2(year, month, idSkl);
    if(result.result["status"] == true){
      var data = GetSkladPerModel.fromJson(result.result);
      for(int i = 0; i<data.data.length;i++){
        skl.add(data.data[i].idSkl2);
      }
      resetSkladSkl(year, month, idSkl);
    }
  }
  resetSkladSkl(year, month, idSkl)async{
    List<Map> data = [];
    for(int i=0; i<skl.length;i++){
      data.add({'ID_SKL2':skl[i]});
    }
    HttpResult result = await _repository.resetSkladSkl2(data, year, month, idSkl);
    if(result.result["status"] == true){
      skl.clear();
    }
  }
}
final skladPerBloc = SkladPerBloc();