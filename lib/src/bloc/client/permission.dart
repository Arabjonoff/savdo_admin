import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/client/agent_permission_model.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class StaffPermission{
  final Repository _repository = Repository();
  final _fetchStaffPermissionInfo = PublishSubject<List<StaffPermissionResult>>();
  Stream<List<StaffPermissionResult>> get getStaffPermissionStream => _fetchStaffPermissionInfo.stream;

  getAllStaffPermission(id)async{
    HttpResult result = await _repository.getStaffPermission(id);
    var data = StaffPermissionModel.fromJson(result.result);
    for(int i = 0; i<data.data.length;i++){
      if(data.data[i].tp == 1){
        CacheService.permissionProduct1(data.data[i].p1);
        CacheService.permissionProduct2(data.data[i].p2);
        CacheService.permissionProduct3(data.data[i].p3);
        CacheService.permissionProduct4(data.data[i].p4);
      }
      else if(data.data[i].tp == 2){
        CacheService.permissionWarehouseIncome1(data.data[i].p1);
        CacheService.permissionWarehouseIncome2(data.data[i].p2);
        CacheService.permissionWarehouseIncome3(data.data[i].p3);
        CacheService.permissionWarehouseIncome4(data.data[i].p4);
        CacheService.permissionWarehouseIncome5(data.data[i].p5);
      }
      else if(data.data[i].tp == 3){
        CacheService.permissionWarehouseOutcome1(data.data[i].p1);
        CacheService.permissionWarehouseOutcome2(data.data[i].p2);
        CacheService.permissionWarehouseOutcome3(data.data[i].p3);
        CacheService.permissionWarehouseOutcome4(data.data[i].p4);
        CacheService.permissionWarehouseOutcome5(data.data[i].p5);
      }
      else if(data.data[i].tp == 4){
        CacheService.permissionWarehouseExpense1(data.data[i].p1);
        CacheService.permissionWarehouseExpense2(data.data[i].p2);
        CacheService.permissionWarehouseExpense3(data.data[i].p3);
        CacheService.permissionWarehouseExpense4(data.data[i].p4);
        CacheService.permissionWarehouseExpense5(data.data[i].p5);
      }
      else if(data.data[i].tp == 5){
        CacheService.permissionMainWarehouse1(data.data[i].p1);
        CacheService.permissionMainWarehouse2(data.data[i].p2);
        CacheService.permissionMainWarehouse3(data.data[i].p3);
        CacheService.permissionMainWarehouse4(data.data[i].p4);
        CacheService.permissionMainWarehouse5(data.data[i].p5);
      }
      else if(data.data[i].tp == 6){
        CacheService.permissionClientList1(data.data[i].p1);
        CacheService.permissionClientList2(data.data[i].p2);
        CacheService.permissionClientList3(data.data[i].p3);
        CacheService.permissionClientList4(data.data[i].p4);
      }
      else if(data.data[i].tp == 7){
        CacheService.permissionCourierList1(data.data[i].p1);
        CacheService.permissionCourierList2(data.data[i].p2);
        CacheService.permissionCourierList3(data.data[i].p3);
        CacheService.permissionCourierList4(data.data[i].p4);
      }
      else if(data.data[i].tp == 8){
        CacheService.permissionClientDebt1(data.data[i].p1);
        CacheService.permissionClientDebt2(data.data[i].p2);
        CacheService.permissionClientDebt3(data.data[i].p3);
        CacheService.permissionClientDebt4(data.data[i].p4);
      }
      else if(data.data[i].tp == 9){
        CacheService.permissionCourierDebt1(data.data[i].p1);
        CacheService.permissionCourierDebt2(data.data[i].p2);
        CacheService.permissionCourierDebt3(data.data[i].p3);
        CacheService.permissionCourierDebt4(data.data[i].p4);
      }
      else if(data.data[i].tp == 10){
        CacheService.permissionPaymentIncome1(data.data[i].p1);
        CacheService.permissionPaymentIncome2(data.data[i].p2);
        CacheService.permissionPaymentIncome3(data.data[i].p3);
        CacheService.permissionPaymentIncome4(data.data[i].p4);
      }
      else if(data.data[i].tp == 11){
        CacheService.permissionPaymentOutcome1(data.data[i].p1);
        CacheService.permissionPaymentOutcome2(data.data[i].p2);
        CacheService.permissionPaymentOutcome3(data.data[i].p3);
        CacheService.permissionPaymentOutcome4(data.data[i].p4);
      }
      else if(data.data[i].tp == 12){
        CacheService.permissionPaymentExpense1(data.data[i].p1);
        CacheService.permissionPaymentExpense2(data.data[i].p2);
        CacheService.permissionPaymentExpense3(data.data[i].p3);
        CacheService.permissionPaymentExpense4(data.data[i].p4);
      }
      else if(data.data[i].tp == 13){
        CacheService.permissionMonth1(data.data[i].p1);
        CacheService.permissionMonth2(data.data[i].p2);
        CacheService.permissionMonth3(data.data[i].p3);
        CacheService.permissionMonth4(data.data[i].p4);
      }
      else if(data.data[i].tp == 14){
        CacheService.permissionUserWindow1(data.data[i].p1);
        CacheService.permissionUserWindow2(data.data[i].p2);
        CacheService.permissionUserWindow3(data.data[i].p3);
        CacheService.permissionUserWindow4(data.data[i].p4);
      }
      else if(data.data[i].tp == 15){
        CacheService.permissionBalanceWindow1(data.data[i].p1);
        CacheService.permissionBalanceWindow2(data.data[i].p2);
        CacheService.permissionBalanceWindow3(data.data[i].p3);
        CacheService.permissionBalanceWindow4(data.data[i].p4);
        CacheService.permissionBalanceWindow5(data.data[i].p5);
      }
      else if(data.data[i].tp == 16){
        CacheService.permissionProductInfo1(data.data[i].p1);
        CacheService.permissionProductInfo2(data.data[i].p2);
        CacheService.permissionProductInfo3(data.data[i].p3);
        CacheService.permissionProductInfo4(data.data[i].p4);
      }
      else if(data.data[i].tp == 17){
        CacheService.permissionAmountNumber1(data.data[i].p1);
        CacheService.permissionAmountNumber2(data.data[i].p2);
        CacheService.permissionAmountNumber3(data.data[i].p3);
        CacheService.permissionAmountNumber4(data.data[i].p4);
      }
      else if(data.data[i].tp == 18){
        CacheService.permissionHistoryAction1(data.data[i].p1);
        CacheService.permissionHistoryAction2(data.data[i].p2);
        CacheService.permissionHistoryAction3(data.data[i].p3);
        CacheService.permissionHistoryAction4(data.data[i].p4);
      }
      else if(data.data[i].tp == 19){
        CacheService.permissionRemoteCashier1(data.data[i].p1);
        CacheService.permissionRemoteCashier2(data.data[i].p2);
        CacheService.permissionRemoteCashier3(data.data[i].p3);
        CacheService.permissionRemoteCashier4(data.data[i].p4);
      }
      else if(data.data[i].tp == 20){
        CacheService.permissionRemoteCashier1(data.data[i].p1);
        CacheService.permissionRemoteCashier2(data.data[i].p2);
        CacheService.permissionRemoteCashier3(data.data[i].p3);
        CacheService.permissionRemoteCashier4(data.data[i].p4);
      }
      else if(data.data[i].tp == 21){
        CacheService.permissionWarehouseReturn1(data.data[i].p1);
        CacheService.permissionWarehouseReturn2(data.data[i].p2);
        CacheService.permissionWarehouseReturn3(data.data[i].p3);
        CacheService.permissionWarehouseReturn4(data.data[i].p4);
        CacheService.permissionWarehouseReturn5(data.data[i].p5);
      }
      else if(data.data[i].tp == 22){
        CacheService.permissionWarehouseAction1(data.data[i].p1);
        CacheService.permissionWarehouseAction2(data.data[i].p2);
        CacheService.permissionWarehouseAction3(data.data[i].p3);
        CacheService.permissionWarehouseAction4(data.data[i].p4);
      }
      else if(data.data[i].tp == 23){
        CacheService.permissionBooking1(data.data[i].p1);
        CacheService.permissionBooking2(data.data[i].p2);
        CacheService.permissionBooking3(data.data[i].p3);
        CacheService.permissionBooking4(data.data[i].p4);
      }
    }
    _fetchStaffPermissionInfo.sink.add(data.data);
  }
}
final staffPermission = StaffPermission();

class AgentPermission{
  final Repository _repository = Repository();
  final _fetchAgentPermissionInfo = PublishSubject<AgentPermissionModel>();
  Stream<AgentPermissionModel> get getAgentPermissionStream => _fetchAgentPermissionInfo.stream;

  getAllAgentPermission(id)async{
    HttpResult result = await _repository.getAgentPermission(id);
    var data = AgentPermissionModel.fromJson(result.result);
    _fetchAgentPermissionInfo.sink.add(data);
  }
}
final agentPermission = AgentPermission();