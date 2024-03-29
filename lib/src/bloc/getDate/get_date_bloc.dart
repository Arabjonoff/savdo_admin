import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class GetDateBloc{
  final Repository _repository = Repository();
  getDateId()async{
    HttpResult result = await _repository.getDatePayment();
    if(result.result['status']==true){
      CacheService.saveDateId(result.result['ID']);
    }
  }
}
final getDateBloc = GetDateBloc();