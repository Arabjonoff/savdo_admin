import 'package:rxdart/rxdart.dart';
import 'package:savdo_admin/src/api/repository.dart';
import 'package:savdo_admin/src/model/income/income_add_model.dart';
import 'package:savdo_admin/src/utils/cache.dart';

class IncomeProductBloc{
  final Repository _repository = Repository();
  final _fetchInfoIncomeAddProduct = PublishSubject<List<IncomeAddModel>>();
  Stream<List<IncomeAddModel>> get getIncomeProductStream => _fetchInfoIncomeAddProduct.stream;
  num summa = 0;


  getAllIncomeProduct()async{
    List<IncomeAddModel> data = await _repository.getIncomeProductBase();
    _fetchInfoIncomeAddProduct.sink.add(data);
  }

  /// Tannarxi soni bo'yicha xisoblash
  costsAmount(countUzs,countUsd)async{
    List<IncomeAddModel> data = await _repository.getIncomeProductBase();
    num resUzs = CacheService.getExpenseSummaUzs() / countUzs;
    num resUsd = CacheService.getExpenseSummaUsd() / countUsd;
    for(int i =0;i<data.length;i++){
       if(data[i].narhi != 0){
         IncomeAddModel incomeModel = IncomeAddModel(
           price: data[i].price,
           id: data[i].id,
           idSklPr: data[i].idSklPr,
           idSkl2: data[i].idSkl2,
           name: data[i].name,
           idTip: data[i].idTip,
           idFirma: data[i].idFirma,
           idEdiz: data[i].idEdiz,
           soni: data[i].soni,
           narhi: data[i].narhi,
           narhiS: data[i].narhiS,
           sm: data[i].sm,
           smS: data[i].smS,
           snarhi: data[i].snarhi,
           snarhiS: data[i].snarhiS,
           snarhi1: data[i].snarhi1,
           snarhi1S: data[i].snarhi1S,
           snarhi2: data[i].snarhi2,
           snarhi2S: data[i].snarhi2S,
           tnarhi: data[i].narhi+resUzs,
           tnarhiS: data[i].tnarhiS,
           tsm: data[i].tsm,
           tsmS: data[i].tsmS,
           shtr: data[i].shtr,
         );
         await _repository.updateIncomeProductBase(incomeModel);
       }
       else{
         IncomeAddModel incomeModel = IncomeAddModel(
           price: data[i].price,
           id: data[i].id,
           idSklPr: data[i].idSklPr,
           idSkl2: data[i].idSkl2,
           name: data[i].name,
           idTip: data[i].idTip,
           idFirma: data[i].idFirma,
           idEdiz: data[i].idEdiz,
           soni: data[i].soni,
           narhi: data[i].narhi,
           narhiS: data[i].narhiS,
           sm: data[i].sm,
           smS: data[i].smS,
           snarhi: data[i].snarhi,
           snarhiS: data[i].snarhiS,
           snarhi1: data[i].snarhi1,
           snarhi1S: data[i].snarhi1S,
           snarhi2: data[i].snarhi2,
           snarhi2S: data[i].snarhi2S,
           tnarhi: data[i].tnarhi,
           tnarhiS: data[i].narhiS+resUsd,
           tsm: data[i].tsm,
           tsmS: data[i].tsmS,
           shtr: data[i].shtr,
         );
         await _repository.updateIncomeProductBase(incomeModel);
       }
      await getAllIncomeProduct();
    }
  }

  /// Tannarxi narxi bo'yicha xisoblash
  costsPrice(countUzs,summa,countUsd)async{
    List<IncomeAddModel> data = await _repository.getIncomeProductBase();
    num resUzs = CacheService.getExpenseSummaUzs();
    num resUsd = CacheService.getExpenseSummaUsd();
    for(int i =0;i<data.length;i++){
      if(data[i].narhi != 0){
        num d = (data[i].sm/summa*100);
        num s = (resUzs/100)*d;
        num ds = s+data[i].sm;
        IncomeAddModel incomeModel = IncomeAddModel(
          price: data[i].price,
          id: data[i].id,
          idSklPr: data[i].idSklPr,
          idSkl2: data[i].idSkl2,
          name: data[i].name,
          idTip: data[i].idTip,
          idFirma: data[i].idFirma,
          idEdiz: data[i].idEdiz,
          soni: data[i].soni,
          narhi: data[i].narhi,
          narhiS: data[i].narhiS,
          sm: data[i].sm,
          smS: data[i].smS,
          snarhi: data[i].snarhi,
          snarhiS: data[i].snarhiS,
          snarhi1: data[i].snarhi1,
          snarhi1S: data[i].snarhi1S,
          snarhi2: data[i].snarhi2,
          snarhi2S: data[i].snarhi2S,
          tnarhi: ds/data[i].soni,
          tnarhiS: data[i].narhiS,
          tsm: data[i].tsm,
          tsmS: data[i].tsmS,
          shtr: data[i].shtr,
        );
        await _repository.updateIncomeProductBase(incomeModel);
        await getAllIncomeProduct();
      }
      else{
        num d = (data[i].smS/summa*100);
        num s = (resUsd/100)*d;
        num ds = s+data[i].smS;
        IncomeAddModel incomeModel = IncomeAddModel(
          price: data[i].price,
          id: data[i].id,
          idSklPr: data[i].idSklPr,
          idSkl2: data[i].idSkl2,
          name: data[i].name,
          idTip: data[i].idTip,
          idFirma: data[i].idFirma,
          idEdiz: data[i].idEdiz,
          soni: data[i].soni,
          narhi: data[i].narhi,
          narhiS: data[i].narhiS,
          sm: data[i].sm,
          smS: data[i].smS,
          snarhi: data[i].snarhi,
          snarhiS: data[i].snarhiS,
          snarhi1: data[i].snarhi1,
          snarhi1S: data[i].snarhi1S,
          snarhi2: data[i].snarhi2,
          snarhi2S: data[i].snarhi2S,
          tnarhi: data[i].tnarhi,
          tnarhiS: ds/data[i].soni,
          tsm: data[i].tsm,
          tsmS: data[i].tsmS,
          shtr: data[i].shtr,
        );
        await _repository.updateIncomeProductBase(incomeModel);
        await getAllIncomeProduct();
      }
    }
    _fetchInfoIncomeAddProduct.sink.add(data);
  }
}

final incomeProductBloc = IncomeProductBloc();



