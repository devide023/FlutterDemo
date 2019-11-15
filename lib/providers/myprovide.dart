import 'package:flutter/material.dart';

class MyProvide with ChangeNotifier {
  int _index = 0;
  int _sex = 1;
  Map _prouctlist;
  int get sex => _sex;
  void choosesex(int val) {
    this._sex = val;
    notifyListeners();
  }

  int get index {
    return _index;
  }

  set productlist(Map value) {
    _prouctlist = value;
  }

  Map get getproductlist {
    return _prouctlist;
  }

  void changeIndex(int index) {
    this._index = index;
    notifyListeners();
  }
}
