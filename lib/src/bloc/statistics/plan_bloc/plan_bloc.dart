import 'dart:async';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';
import 'package:savdo_admin/src/model/statistics/plan_model.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class PlanBloc{
  final _fetchPieChartInfo = PublishSubject<PlanModel>();
  final _fetchAgentInfo = PublishSubject<AgentModel>();
  final _fetchClient = PublishSubject<List<ClientResult>>();
  Stream<PlanModel> get getPlanStream => _fetchPieChartInfo.stream;
  Stream<AgentModel> get getAgentStream => _fetchAgentInfo.stream;
  Stream<List<ClientResult>> get getClientStream => _fetchClient.stream;
  double percent = 0.0, f = 0;
  int taskDone = 0, taskGo = 0, weekday = 0, taskOut= 0;
  final Repository _repository = Repository();
  getPlanAll()async{
    weekday = DateTime.now().weekday;
    List<ClientResult> clientBase = await _repository.getClientBase();
    HttpResult result = await _repository.getOutCome(DateFormat('yyyy-MM-dd').format(DateTime.now()),CacheService.getWareHouseId());
    if(result.isSuccess){
      taskDone = 0;taskGo = 0;taskOut= 0;percent = 0.0; f = 0;
      var data = OutcomeModel.fromJson(result.result);
      /// Tasks function Done
      List<ClientResult> listDone = [];
      for(int i=0; i<data.outcomeResult.length;i++){
        for(int j =0; j< clientBase.length;j++){
          if(data.outcomeResult[i].idAgent == clientBase[j].idAgent){
            if(data.outcomeResult[i].idT == clientBase[j].idT){
              if (weekday == 7) {
                if (clientBase[j].h7 == 1) {
                  clientBase[j].st=4;
                  listDone.add(clientBase[j]);
                  var data = ClientModel(status: true, data: listDone);
                  _fetchClient.sink.add(data.data);
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 6) {
                if (clientBase[j].h6 == 1) {
                  clientBase[j].st=4;
                  listDone.add(clientBase[j]);
                  var data = ClientModel(status: true, data: listDone);
                  _fetchClient.sink.add(data.data);
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 5) {
                if (clientBase[j].h5 == 1) {
                  clientBase[j].st=4;
                  listDone.add(clientBase[j]);
                  var data = ClientModel(status: true, data: listDone);
                  _fetchClient.sink.add(data.data);
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 4) {
                if (clientBase[j].h4 == 1) {
                  clientBase[j].st=4;
                  listDone.add(clientBase[j]);
                  var data = ClientModel(status: true, data: listDone);
                  _fetchClient.sink.add(data.data);
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 3) {
                if (clientBase[j].h3 == 1) {
                  clientBase[j].st=4;
                  listDone.add(clientBase[j]);
                  var data = ClientModel(status: true, data: listDone);
                  _fetchClient.sink.add(data.data);
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 2) {
                if (clientBase[j].h2 == 1) {
                  clientBase[j].st=4;
                  listDone.add(clientBase[j]);
                  var data = ClientModel(status: true, data: listDone);
                  _fetchClient.sink.add(data.data);
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 1) {
                if (clientBase[j].h1 == 1) {
                  clientBase[j].st=4;
                  listDone.add(clientBase[j]);
                  var data = ClientModel(status: true, data: listDone);
                  _fetchClient.sink.add(data.data);
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
            }
          }
        }
      }
      /// Tasks function go
      List<ClientResult> list =[];
      for (int j = 0; j < clientBase.length; j++) {
        if (weekday == 7) {
          if (clientBase[j].h7 == 1) {
            taskGo += clientBase[j].h7;
            list.add(clientBase[j]);
            var data = ClientModel(status: true, data: list);
            _fetchClient.sink.add(data.data);
          }
        }
        if (weekday == 6) {
          if (clientBase[j].h6 == 1) {
            list.add(clientBase[j]);
            var data = ClientModel(status: true, data: list);
            _fetchClient.sink.add(data.data);
            taskGo += clientBase[j].h6;
          }
        }
        if (weekday == 5) {
          if (clientBase[j].h5 == 1) {
            list.add(clientBase[j]);
            var data = ClientModel(status: true, data: list);
            _fetchClient.sink.add(data.data);
            taskGo += clientBase[j].h5;
          }
        }
        if (weekday == 4) {
          if (clientBase[j].h4 == 1) {
            list.add(clientBase[j]);
            var data = ClientModel(status: true, data: list);
            _fetchClient.sink.add(data.data);
            taskGo += clientBase[j].h4;
          }
        }
        if (weekday == 3) {
          if (clientBase[j].h3 == 1) {
            list.add(clientBase[j]);
            var data = ClientModel(status: true, data: list);
            _fetchClient.sink.add(data.data);
            taskGo += clientBase[j].h3;
          }
        }
        if (weekday == 2) {
          if (clientBase[j].h2 == 1) {
            list.add(clientBase[j]);
            var data = ClientModel(status: true, data: list);
            _fetchClient.sink.add(data.data);
            taskGo += clientBase[j].h2;
          }
        }
        if (weekday == 1) {
          if (clientBase[j].h1 == 1) {
            list.add(clientBase[j]);
            var data = ClientModel(status: true, data: list);
            _fetchClient.sink.add(data.data);
            taskGo += clientBase[j].h1;
          }
        }
      }

      f = 0;
      f = 100 / (taskGo / taskDone);
      if (f > 10) {
        percent = 0.1;
      }
      if (f > 20) {
        percent = 0.2;
      }
      if (f > 30) {
        percent = 0.3;
      }
      if (f > 40) {
        percent = 0.4;
      }
      if (f > 50) {
        percent = 0.5;
      }
      if (f > 60) {
        percent = 0.6;
      }
      if (f > 70) {
        percent = 0.7;
      }
      if (f > 80) {
        percent = 0.8;
      }
      if (f > 90) {
        percent = 0.9;
      }
      if (f == 100 || f > 100 ) {
        percent = 1;
        f = f = 100;
      }
      _fetchPieChartInfo.sink.add(PlanModel(taskDone: taskDone, taskOut: taskOut, taskGo: taskGo, percent: percent, f: f, weekday: weekday));
    }
  }
}
final planBloc = PlanBloc();