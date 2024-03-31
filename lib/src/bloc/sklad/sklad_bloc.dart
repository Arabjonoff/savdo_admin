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
    if(DateTime.now().day == 1){
      await _repository.clearSkladBase();
    }
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
  updateSklad(data,count)async{
    var updateData = {
      "ID": data.id,
      "NAME": data.name,
      "ID_SKL2": data.idSkl2,
      "ID_TIP": data.idTip,
      "ID_FIRMA": data.idFirma,
      "ID_EDIZ": data.idEdiz,
      "NARHI": data.narhi,
      "NARHI_S": data.narhiS,
      "SNARHI": data.snarhi,
      "SNARHI_S": data.snarhiS,
      "SNARHI1": data.snarhi1,
      "SNARHI1_S": data.snarhi1S,
      "SNARHI2": data.snarhi2,
      "SNARHI2_S": data.snarhi2S,
      "KSONI": data.ksoni,
      "KSM": data.ksm,
      "KSM_S": data.ksmS,
      "PSONI": data.psoni,
      "PSM": data.psm,
      "PSM_S": data.psmS,
      "RSONI": data.rsoni,
      "RSM": data.rsm,
      "RSM_S": data.rsmS,
      "HSONI": data.hsoni,
      "HSM": data.hsm,
      "HSM_S": data.hsmS,
      "VSONI": data.vsoni,
      "VSM": data.vsm,
      "VSM_S": data.vsmS,
      "VZSONI": data.vzsoni,
      "VZSM": data.vzsm,
      "VZSM_S": data.vzsmS,
      "PSKSONI": data.psksoni,
      "PSKSM": data.psksm,
      "PSKSM_S": data.psksmS,
      "RSKSONI": data.rsksoni,
      "RSKSM": data.rsksm,
      "RSKSM_S": data.rsksmS,
      "OSONI": count,
      "OSM": data.osm,
      "OSM_S": data.osmS,
      "OSM_T": data.osmT,
      "OSM_T_S": data.osmTS,
      "KSM_T": data.ksmT,
      "KSM_T_S": data.ksmTS,
      "YIL": data.yil,
      "OY": data.oy,
      "ID_SKL0": data.idSkl0,
      "FOYDA": data.foyda,
      "FOYDA_S": data.foydaS,
      "SONI": data.soni,
      "VZ": data.vz,
      "PHOTO": data.photo,
    };
    await _repository.updateSkladBase(SkladResult.fromJson(updateData));
    await getAllSklad(DateTime.now().year, DateTime.now().month,1);
    await getAllSkladSearch(DateTime.now().year, DateTime.now().month,1,'');
  }

}
final skladBloc = SkladBloc();