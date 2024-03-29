import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';

class ExpenseBloc{

  final Repository _repository = Repository();
  final _fetchExpenseInfo = PublishSubject<List<ProductTypeAllResult>>();
  Stream<List<ProductTypeAllResult>> get getStream => _fetchExpenseInfo.stream;
  getAllExpense()async{
    List<ProductTypeAllResult> expenseBase = await _repository.getExpenseTypeBase();
    _fetchExpenseInfo.sink.add(expenseBase);
    if(expenseBase.isEmpty){
      HttpResult result = await _repository.getTypeExpense();
      if(result.isSuccess){
        var data = ProductTypeAll.fromJson(result.result);
        for(int i =0; i<data.data.length;i++){
          _repository.saveExpenseBase(data.data[i]);
        }
        _fetchExpenseInfo.sink.add(data.data);
      }
    }
  }
}

final expenseBloc = ExpenseBloc();