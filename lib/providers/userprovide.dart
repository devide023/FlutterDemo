import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';

import 'mainprovide.dart';

class UserProvide extends Model {
  Map _userinfo;
  List<Widget> userdrawer = [];
  List<PopupMenuItem> useractions = [];
  List userlist = [];
  void SaveUserInfo(Map val) {
    _userinfo = val;
    notifyListeners();
  }

  void UserActionsData() {
    UserService().actions(_userinfo['id']).then((res) {
      print("res:$res");
      var result = json.decode(res.toString());
      print("res:$result");
      (result['actions'] as List<dynamic>).forEach((item) {
        useractions.add(PopupMenuItem(
          child: Text(item['title'].toString()),
          value: item['code'].toString(),
        ));
      });
      notifyListeners();
    });
  }

  Future UserList() async {
    Response res = await UserService().list();
    return json.decode(res.data.toString());
  }

  void UserDrawerdata() {
    userdrawer.add(UserAccountsDrawerHeader(
      accountName: Text(_userinfo['username'].toString()),
      accountEmail: Text(_userinfo['usercode']?.toString()),
      onDetailsPressed: () {},
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/image/headbg.jpg"), fit: BoxFit.fill)),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(AppConfig.str_imgurl +
            (_userinfo['headimg'] ?? "default_head.jpg")),
      ),
    ));
    UserService().drawer(_userinfo['id']).then((res) {
      if (res.toString().isNotEmpty) {
        var result = json.decode(res.toString());
        (result as List).forEach((item) {
          userdrawer.add(ListTile(
            title: item['title'],
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ));
          userdrawer.add(Divider());
        });
        notifyListeners();
      }
    });
  }
}
