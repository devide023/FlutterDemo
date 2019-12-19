import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/services/BaseInfoService.dart';

class SearchProvide with ChangeNotifier {
  List placeno = [];
  List menutype = [];
  List xmtype = [];
  List shipclass = [];
  List menucodelist = [];
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

  void GetMenuCodeList(String typeno, {String xmtypeno}) {
    BaseInfoServices.menucode_gold5({"typeno": typeno, "xmtypeno": xmtypeno})
        .then((res) {
      this.menucodelist = jsonDecode(res.toString());
      notifyListeners();
    });
  }
}
