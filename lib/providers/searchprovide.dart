import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/services/BaseInfoService.dart';

class SearchProvide with ChangeNotifier {
  List placeno = [];
  List menutype = [];
  List xmtype = [];
  List shipclass = [];
  List menucodelist = [];
  List saledata_rcno=[];
  String current_rcno="";
  bool isselected = true;
  bool _showRcnoItems=false;
  List<String> _rcno_items=[];
  List<String> _placeno_items=[];
  List<String> _xmtype_items=[];
  bool _showplaceno =false;
  bool _showxmtyp = false;

  void xmtypeclean(){
    this._xmtype_items.clear();
    this.xmtype.clear();
    notifyListeners();
  }

  set xmtypeItems(List<String> items){
    this._xmtype_items = items;
    notifyListeners();
  }
  List<String> get xmtypeItems=>_xmtype_items;

  set showxmtyp(bool v){
    _showxmtyp = v;
    notifyListeners();
  }

  bool get showxmtyp=>_showxmtyp;

  set placenoItems(List<String> items){
    _placeno_items = items;
    notifyListeners();
  }
  List<String> get placenoItems => _placeno_items;
  set showPlaceno(bool v){
    _showplaceno = v;
    notifyListeners();
  }
  bool get showplaceno=>_showplaceno;

  set showRcnoItems(bool v){
    _showRcnoItems = v;
    notifyListeners();
  }
  bool get showRcnoItems=>_showRcnoItems;

  set rcnoItems(List<String> items){
    _rcno_items = items;
    notifyListeners();
  }
  List<String> get rcnoItems=>_rcno_items;

  void SelectedChange(bool v){
    this.isselected = v;
    notifyListeners();
  }



  void GetSaleDataByRcno(String rcno,{String placeno,String typeno}){
    current_rcno = rcno;
    BaseInfoServices.shipsaledata({"rcno":rcno,"placeno":placeno,"typeno":typeno}).then((res){
      this.saledata_rcno =  jsonDecode(res.toString());
      notifyListeners();
    });
  }
  void GetSaleDataByRcnos({List<String> rcnos,List<String> placenos,List<String> typenos}){
    BaseInfoServices.shipsaledatas({"rcnos":rcnos,"placenos":placenos,"typenos":typenos}).then((res){
      this.saledata_rcno =  jsonDecode(res.toString());
      notifyListeners();
    });
  }
  void GetPlaceNo() {
    BaseInfoServices.placeno_gold5().then((res) {
      this.placeno = jsonDecode(res.toString());
      notifyListeners();
    });
  }

  void GetShipClass({Map data}) {
    BaseInfoServices.shipclass_gold5(data).then((res) {
      this.shipclass = jsonDecode(res.toString());
      notifyListeners();
    });
  }

  void GetXMType(String place) {
    BaseInfoServices.xmtype_gold5(Map.from({"placeno": place})).then((res) {
      this.xmtype = jsonDecode(res.toString());
      notifyListeners();
    });
  }

  void GetXMTypeList(List<String> place) {
    FormData data = FormData.fromMap({
      "placenos":place
    });
    BaseInfoServices.xmtypes_gold5(data).then((res) {
      this.xmtype = jsonDecode(res.toString());
      notifyListeners();
    });
  }

  void GetMenuCodeList(String typeno, {String xmtypeno}) {
    BaseInfoServices.menucode_gold5({"typeno": typeno, "xmtypeno": xmtypeno})
        .then((res) {
      this.menucodelist = jsonDecode(res.toString());
      notifyListeners();
    });
  }

}
