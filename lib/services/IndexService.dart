import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterproject/http/request.dart';
import 'package:flutterproject/services/BaseInfoService.dart';

class IndexService {
  Future getCatagory() async {
    //var v1 = await BaseInfoServices.index_gold5();
    var v1=await BaseInfoServices.placeno_gold5();
    var v2=await BaseInfoServices.menutyp_gold5();
    var v3='{"placenolist":${v1},"menutypelist":${v2}}';
    return v3;
  }
}
