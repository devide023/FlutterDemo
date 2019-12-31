import 'package:flutter/material.dart';

class SearchDrawerProvider with ChangeNotifier{

int _shipclassindex=-1;
String _sex="";
String _rcno="";
int get shipclassindex=>_shipclassindex;
bool _showshipclass=false;

List<bool> t1=[false,false,false];

void setT1(int index){
  t1[index] = !t1[index];
  notifyListeners();
}

set shipclassindex(int index){
  _shipclassindex = index;
  notifyListeners();
}

String get sex=>_sex;
set sex(String sex){
  _sex = sex;
  notifyListeners();
}

String get rcno=>_rcno;
set rcno(String rcno){
  _rcno = rcno;
  notifyListeners();
}

void shipclassShow(){
  _showshipclass = !_showshipclass;
  notifyListeners();
}

bool get showshipclass=>_showshipclass;



}