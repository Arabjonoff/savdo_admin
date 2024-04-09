import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/http_result.dart';
import 'package:savdo_admin/src/model/product/product_all_type.dart';
import 'package:savdo_admin/src/model/skl2/skl2_model.dart';
import 'package:savdo_admin/src/model/sklad/sklad_model.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class ProductBloc{
  final Repository _repository = Repository();
  final _fetchProductInfo = PublishSubject<List<Skl2Result>>();
  Stream<List<Skl2Result>> get getProductStream => _fetchProductInfo.stream;

  getAllProduct()async{
    HttpResult currency = await _repository.getCurrency();
    CacheService.saveCurrency(currency.result["KURS"]);
    List<SkladResult> skladBase = await _repository.getSkladBase();
    List<ProductTypeAllResult> firmaBase = await _repository.getFirmaTypeBase();
    List<ProductTypeAllResult> quantityBase = await _repository.getQuantityTypBase();
    List<ProductTypeAllResult> productBaseType = await _repository.getProductTypeBase();
    List<Skl2Result> productBase = await _repository.getProductBase();
    _fetchProductInfo.sink.add(productBase);
    if(productBase.isEmpty){
      HttpResult response = await _repository.getProduct();
      if(response.isSuccess){
        var data = Skl2BaseModel.fromJson(response.result);
        for(int i =0; i<data.skl2Result.length;i++){
          for(int j = 0; j<firmaBase.length;j++){
            if(data.skl2Result[i].idFirma == firmaBase[j].id){
              data.skl2Result[i].firmName = firmaBase[j].name;
            }
          }
          for(int n = 0; n<quantityBase.length;n++){
            if(data.skl2Result[i].idEdiz == quantityBase[n].id){
              data.skl2Result[i].edizName = quantityBase[n].name;
            }
          }
          for(int k = 0; k<productBaseType.length;k++){
            if(data.skl2Result[i].idTip == productBaseType[k].id){
              data.skl2Result[i].tipName = productBaseType[k].name;
            }
          }
          for(int t = 0; t<skladBase.length;t++){
            if(data.skl2Result[i].id == skladBase[t].idSkl2){
              data.skl2Result[i].narhi = skladBase[t].narhi;
              data.skl2Result[i].narhiS = skladBase[t].narhiS;
              data.skl2Result[i].snarhi = skladBase[t].snarhi;
              data.skl2Result[i].snarhi1 = skladBase[t].snarhi1;
              data.skl2Result[i].snarhiS1 = skladBase[t].snarhi1S;
              data.skl2Result[i].snarhi2 = skladBase[t].snarhi2;
              data.skl2Result[i].snarhiS2 = skladBase[t].snarhi2S;
            }
          }
          await _repository.saveProductBase(data.skl2Result[i]);
        }
        _fetchProductInfo.sink.add(data.skl2Result);
      }
    }
    else{
      for(int i =0; i<productBase.length;i++){
        for(int j = 0; j<firmaBase.length;j++){
          if(productBase[i].idFirma == firmaBase[j].id){
            productBase[i].firmName = firmaBase[j].name;
          }
        }
        for(int n = 0; n<quantityBase.length;n++){
          if(productBase[i].idEdiz == quantityBase[n].id){
            productBase[i].edizName = quantityBase[n].name;
          }
        }
        for(int k = 0; k<productBaseType.length;k++){
          if(productBase[i].idTip == productBaseType[k].id){
            productBase[i].tipName = productBaseType[k].name;
          }
        }
        for(int t = 0; t<skladBase.length;t++){
          if(productBase[i].id == skladBase[t].idSkl2){
            productBase[i].narhi = skladBase[t].narhi;
            productBase[i].narhiS = skladBase[t].narhiS;
            productBase[i].snarhi = skladBase[t].snarhi;
            productBase[i].snarhi1 = skladBase[t].snarhi1;
            productBase[i].snarhiS1 = skladBase[t].snarhi1S;
            productBase[i].snarhi2 = skladBase[t].snarhi2;
            productBase[i].snarhiS2 = skladBase[t].snarhi2S;
          }
        }
        // await _repository.saveProductBase(productBase[i]);
      }
    }
  }

  searchProduct(obj)async{
    List<Skl2Result> productBase = await _repository.searchProduct(obj);
    _fetchProductInfo.sink.add(productBase);
  }

}
final productBloc = ProductBloc();