import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';

class ProductOutComeBloc{
  final Repository _repository = Repository();
  final _fetchProductOutcomeInfo = PublishSubject<List<SkladResult>>();
  final _fetchProductOutcomeSearchInfo = PublishSubject<List<SkladResult>>();
  Stream<List<SkladResult>> get getProductOutcomeStream => _fetchProductOutcomeInfo.stream;
  Stream<List<SkladResult>> get getProductOutcomeSearchStream => _fetchProductOutcomeSearchInfo.stream;


  getAllProductOutcome()async{
    List<Skl2Result> productBase = await _repository.getProductBase();
    List<SkladResult> outcomeBase = await _repository.getOutcomeBase();
    for(int i=0;i<outcomeBase.length;i++){
      for(int j =0;j<productBase.length;j++){
        if(outcomeBase[i].idSkl2 == productBase[j].id){
          outcomeBase[i].photo = productBase[j].photo;
        }
      }
    }
    _fetchProductOutcomeInfo.sink.add(outcomeBase);
    if(outcomeBase.isEmpty){
      HttpResult result = await _repository.getProductOutCome();
      if(result.isSuccess){
        var data = SkladModel.fromJson(result.result);
        for(int i=0;i<data.data.length;i++){
          for(int j =0;j<productBase.length;j++){
            if(data.data[i].idSkl2 == productBase[j].id){
              data.data[i].photo = productBase[j].photo;
            }
          }
          _repository.saveOutcomeBase(data.data[i]);
        }
        _fetchProductOutcomeInfo.sink.add(data.data);
      }
    }
  }
  getAllProductOutcomeSearch(obj)async{
    await getAllProductOutcome();
    List<Skl2Result> productBase = await _repository.getProductBase();
    List<SkladResult> outcomeBase = await _repository.getOutcomeSearchBase(obj);
    for(int i=0;i<outcomeBase.length;i++){
      for(int j =0;j<productBase.length;j++){
        if(outcomeBase[i].idSkl2 == productBase[j].id){
          outcomeBase[i].photo = productBase[j].photo;
        }
      }
    }
    _fetchProductOutcomeSearchInfo.sink.add(outcomeBase);
  }

  getOutcomeProduct(data,count)async{
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
    await _repository.updateOutcomeBase(SkladResult.fromJson(updateData));
    await productOutComeBloc.getAllProductOutcomeSearch('');
    await productOutComeBloc.getAllProductOutcome();
  }

}
final productOutComeBloc = ProductOutComeBloc();