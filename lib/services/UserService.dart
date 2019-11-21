import '../http/request.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class UserService {
  Future login(String username, String userpwd) async {
    request q = request();
    Response res = await q.instance
        .post('/user/login', data: {'usercode': username, 'userpwd': userpwd});
    return res;
  }

  Future add(FormData data) async {
    try {
      request q = request();
      Response res = await q.instance.post('/user/add', data: data);
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future list(FormData data) async {
    request q = request();
    Response res = await q.instance.post('/user/list', data: data);
    return res;
  }

  Future actions(int userid) async {
    return await request()
        .instance
        .post('/user/actions', data: {"userid": userid});
  }

  Future drawer(int userid) async {
    return await request()
        .instance
        .get('/drawer/data', queryParameters: {"userid": userid});
  }

  Future modify(FormData data) async {
    return await request().instance.post('/user/modify', data: data);
  }

  Future Find(int userid) async {
    return await request()
        .instance
        .get('/user/find', queryParameters: {"userid": userid});
  }

  Future remove(int userid) async {
    return await request()
        .instance
        .get('/user/del', queryParameters: {"userid": userid});
  }

  Future setpwd(int userid, String newpwd) async {
    return await request()
        .instance
        .post('/user/setpwd', data: {"userid": userid, "newpwd": newpwd});
  }

  Future Search(String keyword) async {
    return await request()
        .instance
        .get('/user/search', queryParameters: {"keywords": keyword});
  }
}
