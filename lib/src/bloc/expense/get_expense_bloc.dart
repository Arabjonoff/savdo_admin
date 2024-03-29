import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/expense/get_expense_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class GetExpenseBloc{
  final Repository _repository = Repository();
  final _fetchGetExpenseInfo = PublishSubject<GetExpenseModel>();
  Stream<GetExpenseModel> get getExpenseStream => _fetchGetExpenseInfo.stream;

  getAllExpense(date)async{
    List<ProductTypeAllResult> productType = await _repository.getExpenseTypeBase();
    HttpResult httpResult = await _repository.getPaymentsDaily(date);
    if(httpResult.isSuccess){
      var data = GetExpenseModel.fromJson(httpResult.result);
      for(int i =0;i<data.data.length;i++){
        for(int j = 0; j<data.data[i].tHar.length;j++){
          for(int k = 0; k<productType.length;k++){
            if(productType[k].id == data.data[i].tHar[j].idNima){
              data.data[i].tHar[j].idNimaName = productType[k].name;
            }
          }
        }
      }
      _fetchGetExpenseInfo.sink.add(data);
    }
  }
}
final getExpenseBloc = GetExpenseBloc();