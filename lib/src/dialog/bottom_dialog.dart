import 'package:flutter/material.dart';

class BottomDialog{
  static void showScreenDialog(BuildContext context ,Widget screen){
    showModalBottomSheet(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
        context: context, builder: (ctx){
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
          child: screen);
    });
  }
}