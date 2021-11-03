
// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class CommonProvider with ChangeNotifier{
  int currentIndexBottomNav = 0;

  setCurrentIndexBottomNav(int index){
    currentIndexBottomNav=index;
    notifyListeners();
  }
}