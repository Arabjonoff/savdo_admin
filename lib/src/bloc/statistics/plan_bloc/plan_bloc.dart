import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/client_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/outcome/outcome_model.dart';

class PlanBloc{
  double percent = 0.0, f = 0;
  int taskDone = 0,
      taskGo = 0,
      weekday = 0,
      taskOut= 0;
  final Repository _repository = Repository();
  getPlanAll()async{
    List<ClientResult> clientBase = await _repository.getClientBase('');
    HttpResult result = await _repository.getOutCome(DateTime);
    if(result.isSuccess){
      var data = OutcomeModel.fromJson(result.result);
      /// Tasks function Done
      for(int i=0; i<data.outcomeResult.length;i++){
        for(int j =0; j< clientBase.length;j++){
          if(data.outcomeResult[i].idAgent == clientBase[j].idAgent){
            if(data.outcomeResult[i].idT == clientBase[j].idT){
              if (weekday == 7) {
                if (clientBase[j].h7 == 1) {
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 6) {
                if (clientBase[j].h6 == 1) {
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 5) {
                if (clientBase[j].h5 == 1) {
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 4) {
                if (clientBase[j].h4 == 1) {
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 3) {
                if (clientBase[j].h3 == 1) {
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 2) {
                if (clientBase[j].h2 == 1) {
                  taskDone += 1;
                }
                else{
                  taskOut +=1;
                }
              }
              if (weekday == 1) {
                if (clientBase[j].h1 == 1) {
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
      for(int i =0;i<data.outcomeResult.length;i++){
        for (int j = 0; j < clientBase.length; j++) {
          if (data.outcomeResult[i].idAgent == clientBase[j].idAgent) {
            if (weekday == 7) {
              if (clientBase[j].h7 == 1) {
                taskGo += clientBase[j].h7;
              }
            }
            if (weekday == 6) {
              if (clientBase[j].h6 == 1) {
                taskGo += clientBase[j].h6;
              }
            }
            if (weekday == 5) {
              if (clientBase[j].h5 == 1) {
                taskGo += clientBase[j].h5;
              }
            }
            if (weekday == 4) {
              if (clientBase[j].h4 == 1) {
                taskGo += clientBase[j].h4;
              }
            }
            if (weekday == 3) {
              if (clientBase[j].h3 == 1) {
                taskGo += clientBase[j].h3;
              }
            }
            if (weekday == 2) {
              if (clientBase[j].h2 == 1) {
                taskGo += clientBase[j].h2;
              }
            }
            if (weekday == 1) {
              if (clientBase[j].h1 == 1) {
                taskGo += clientBase[j].h1;
              }
            }
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
    }
    print("************************");
    print(taskDone);
    print(taskGo);
  }
}
final planBloc = PlanBloc();