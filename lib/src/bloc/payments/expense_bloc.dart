import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';

class ExpenseBloc{
  final Repository _repository =Repository();
  final _fetchExpenseInfo = PublishSubject();
}