import 'package:flutter/cupertino.dart';

class ProgressHud extends ChangeNotifier{
  bool isLoading=true;

  changeIsLoading(bool value){
   isLoading= !value;
   notifyListeners();
  }
}