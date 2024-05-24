import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/dialog/center_dialog.dart';
import 'package:savdo_admin/src/model/client/agents_model.dart';
import 'package:savdo_admin/src/model/client/clientdebt_model.dart';
import 'package:savdo_admin/src/model/client/debt_detail_model.dart';
import 'package:savdo_admin/src/model/client/debt_moth_client.dart';
import 'package:savdo_admin/src/model/http_result.dart';

class ClientDebtBloc {
  final Repository _repository = Repository();
  final _fetchClientDebtInfo = PublishSubject<List<DebtClientModel>>();
  final _fetchClientDebtSearchInfo = PublishSubject<List<DebtClientModel>>();
  final _fetchClientDebtDetailInfo = PublishSubject<List<DebtClientDetail>>();
  Stream<List<DebtClientModel>> get getClientDebtStream => _fetchClientDebtInfo.stream;
  Stream<List<DebtClientModel>> get getClientDebtSearchStream => _fetchClientDebtSearchInfo.stream;
  Stream<List<DebtClientDetail>> get getClientDebtDetailStream => _fetchClientDebtDetailInfo.stream;

  getAllClientDebt(year,month)async{
    List<AgentsResult> agentBase = await _repository.getAgentsBase();
    List<DebtClientModel> clientDebtBase = await _repository.getClientDebtBase();
    for(int i = 0; i<clientDebtBase.length;i++){
      for(int a = 0;a<agentBase.length;a++){
        if(clientDebtBase[i].idAgent == agentBase[a].id){
          clientDebtBase[i].agentName = agentBase[a].name;
          clientDebtBase[i].agentId = agentBase[a].id;
        }
      }
    }
    _fetchClientDebtInfo.sink.add(clientDebtBase);
    if(clientDebtBase.isEmpty){
      HttpResult result = await _repository.clientDebt(year,month);
      var data = debtClientModelFromJson(json.encode(result.result));
      for(int i = 0; i<data.length;i++){
        for(int a = 0;a<agentBase.length;a++){
          if(data[i].idAgent == agentBase[a].id){
            data[i].agentName = agentBase[a].name;
            data[i].agentId = agentBase[a].id;
          }
        }
        _repository.saveClientDebtBase(data[i]);
      }
      _fetchClientDebtInfo.sink.add(data);
    }
  }
  getAllClientDebtSearch(obj)async{
    List<AgentsResult> agentBase = await _repository.getAgentsBase();
    List<DebtClientModel> clientDebtBase = await _repository.getClientDebtSearchBase(obj);
    for(int i = 0; i<clientDebtBase.length;i++){
      for(int a = 0;a<agentBase.length;a++){
        if(clientDebtBase[i].idAgent == agentBase[a].id){
          clientDebtBase[i].agentName = agentBase[a].name;
          clientDebtBase[i].agentId = agentBase[a].id;
        }
      }
    }
    _fetchClientDebtSearchInfo.sink.add(clientDebtBase);
  }
  getClientDebtDetail(year,month,idT,tp)async{
    HttpResult result = await _repository.clientDetail(year,month, idT,tp);
    if(result.isSuccess){
      var data = debtClientDetailFromJson(json.encode(result.result));
      data.sort((a, b) => a.pn.compareTo(b.pn));
      _fetchClientDebtDetailInfo.sink.add(data);
    }
  }
  debtMonth(year, month,context)async{
    CenterDialog.showLoadingDialog(context, 'Бироз кутинг');
    int oldMonth = 0;
    int oldYear = 0;
    switch(month){
      case 1:
        oldMonth = 12;
      case 2:
        oldMonth = 1;
      case 3:
        oldMonth = 2;
      case 4:
        oldMonth = 3;
      case 5:
        oldMonth = 4;
      case 6:
        oldMonth = 5;
      case 7:
        oldMonth = 6;
      case 8:
        oldMonth = 7;
      case 9:
        oldMonth = 8;
      case 10:
        oldMonth = 9;
      case 11:
        oldMonth = 10;
      case 12:
        oldMonth = 11;
    }
    if(month == 1){
      oldYear = DateTime.now().year -1;
    }else{
      oldYear = DateTime.now().year;
    }
    await _repository.clearClientDebtBase();
    List<Map> oldMonthDebtList = [];
    List<Map> newMonthDebtList = [];
    HttpResult oldMonthDebt = await _repository.getOldDebtClient(oldYear, oldMonth);
    if(oldMonthDebt.isSuccess){
      var data = debtMonthClientModelFromJson(json.encode(oldMonthDebt.result));
      for(int i=0; i<data.length;i++){
        oldMonthDebtList.add({
            "name":data[i].name,
            "osK":data[i].osK,
            "osKS":data[i].osKS,
            "idToch":data[i].idToch,
            "tp":data[i].tp,
          });
      }
    }
    for(int i =0; i<oldMonthDebtList.length;i++){
      newMonthDebtList.add({
        "ID_T":oldMonthDebtList[i]["idToch"],
        "KL_K":oldMonthDebtList[i]["osK"],
        "KL_K_S":oldMonthDebtList[i]["osKS"],
        "TP":oldMonthDebtList[i]["tp"],
      });
    }
    HttpResult result =  await _repository.postNewDebtClient(year, month, newMonthDebtList);
    if(result.result['status']){
      await getAllClientDebt(year,month);
      Navigator.pop(context);
    }else{
      Navigator.pop(context);
    }
  }
}
final clientDebtBloc = ClientDebtBloc();