import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class InternetBloc{
  final _checkInternetInfo = PublishSubject<bool>();
  Stream<bool> get getCheckConnectionStream => _checkInternetInfo.stream;

  // connection(check)async{
  //    BuildContext context;
  //   if(check == false){
  //     CenterDialog.showErrorDialog(context, "text");
  //   }
  //   if(check == true){
  //     CenterDialog.showErrorDialog(context, "text");
  //   }
  // }
}
final internetBloc = InternetBloc();