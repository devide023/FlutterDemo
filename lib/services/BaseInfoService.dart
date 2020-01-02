import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/http/request.dart';

class BaseInfoServices {
  static Future menutyp_gold5() async {
    return await request().instance.get('/gold05/menutype');
  }

  static Future xmtype_gold5(Map<String, dynamic> data) async {
    return await request()
        .instance
        .get('/gold05/xmtype', queryParameters: data);
  }

  static Future xmtypes_gold5(FormData data) async {
    return await request()
        .instance
        .post('/gold05/xmtypes', data: data);
  }

  static Future index_gold5() async {
    return await request().instance.get('/gold05/index');
  }

  static Future placeno_gold5() async {
    return await request().instance.get('/gold05/menuplace');
  }

  static Future shipclass_gold5(Map data) async {
    return await request()
        .instance
        .get('/gold05/shipclass', queryParameters: data);
  }

  static Future menucode_gold5(Map<String, dynamic> data) async {
    return await request()
        .instance
        .get('/gold05/menucode', queryParameters: data);
  }

  static Future shipsaledata(Map<String, dynamic> data) async {
    return await request()
        .instance
        .get('/gold05/saledata', queryParameters: data);
  }
  static Future shipsaledatas(Map<String, dynamic> data) async {
    return await request()
        .instance
        .post('/gold05/saledatas', queryParameters: data);
  }
}
