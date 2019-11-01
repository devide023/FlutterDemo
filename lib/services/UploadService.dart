import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutterproject/http/request.dart';

class UploadService {
  Future uploadImg(FormData data) async {
    Response res = await request().instance.post('/upload/uploadimg',data: data);
    return res;
  }
}
