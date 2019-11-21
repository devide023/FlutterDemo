import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/services/UserService.dart';
import 'dart:convert';

class UserProvide with ChangeNotifier {
  Widget userdrawer;
  List<PopupMenuItem> useractions = [];
  List userlist = [];
  List userdrawerdata = [];
  UserModel userentity;

  Future UserList(FormData data) async {
    Response res = await UserService().list(data);
    return json.decode(res.data.toString())['list'];
  }

  void UserDrawerdata(int userid) {
    UserService().drawer(userid).then((res) {
      if (res.toString().isNotEmpty) {
        var result = json.decode(res.toString());
        userdrawerdata = result;
        notifyListeners();
      }
    });
  }

  void GetUserEntity(int userid) async {
    var result = await UserService().Find(userid);
    this.userentity = UserModel.fromJson(json.decode(result.toString()));
    notifyListeners();
  }
}
