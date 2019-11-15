import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/services/UserService.dart';
import 'dart:convert';

class UserProvide with ChangeNotifier {
  Map _userinfo;
  List<Widget> userdrawer = [];
  List<PopupMenuItem> useractions = [];
  List userlist = [];
  UserModel userentity;
  void SaveUserInfo(Map val) {
    _userinfo = val;
    notifyListeners();
  }

  Future UserList(FormData data) async {
    Response res = await UserService().list(data);
    return json.decode(res.data.toString())['list'];
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
        (result as List).cast().forEach((item) {
          userdrawer.add(ListTile(
            leading: Icon(Icons.label),
            title: Text(item['title'].toString()),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ));
          userdrawer.add(Divider());
        });
      }
    });
  }

  void GetUserEntity(int userid) async {
    var result = await UserService().Find(userid);
    this.userentity = UserModel.fromJson(json.decode(result.toString()));
    notifyListeners();
  }
}
