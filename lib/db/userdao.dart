import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/pages/Login.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:flutterproject/route/application.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:provide/provide.dart';
import 'package:sqflite/sqflite.dart';

class Userdao {
  static Future<int> SaveUserInfo(Map<String, dynamic> user) async {
    var db = await Application.appdb;
    print("====sys_user===${user}");
    await db.transaction((trx) async {
      trx.rawDelete("delete from sys_login_info ");
      var result = await trx.rawInsert('''insert into sys_login_info(
          userid,
          usercode,
          username,
          userpwd,
          orgid,
          depid)  VALUES (?,?,?,?,?,?)''', [
        user['id'] ?? 0,
        user['usercode'],
        user['username'] ?? '',
        user['oldpwd'] ?? '',
        user['orgid'] ?? 0,
        user['depid'] ?? 0
      ]);
      return result;
    });
  }

  static Future<Map<String, dynamic>> get GetCurrentUserInfo async {
    var db = await Application.appdb;
    var list =
        await db.rawQuery("select * from sys_user order by id asc limit 1");
    var temp = list.first;
    print("local userinfo====$temp");
    return Map<String, dynamic>.from({
      "id": temp["userid"],
      "status": temp["status"],
      "usercode": temp["usercode"],
      "username": temp["username"],
      "userpwd": temp["userpwd"],
      "tel": temp["tel"],
      "phone": temp["phone"],
      "sex": temp["sex"],
      "address": temp["address"],
      "birthdate": temp["birthdate"],
      "headimg": temp["headimg"],
    });
  }

  static Future<UserModel> GetUserInfo(int userid) async {
    var db = await Application.appdb;
    var list =
        await db.rawQuery("select * from sys_user where userid =?", [userid]);
    return list.length > 0 ? UserModel.fromJson(list.first) : UserModel();
  }

  static Future<bool> islogined(BuildContext context) async {
    var db = await Application.appdb;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM sys_login_info'));
    if (count > 0) {
      var list = await db.rawQuery(
          "select userid,usercode,userpwd from sys_login_info order by id asc limit 1");
      var userentity = list.first;
      var userid = userentity['userid'];
      var usercode = userentity['usercode'];
      var userpwd = userentity['userpwd'];
      var loginres = await UserService().login(usercode, userpwd);
      var loginresult = jsonDecode(loginres.toString());
      print("loginresult>>>>$loginresult");
      if (loginresult['code'] == 1) {
        var userprovide = Provide.value<UserProvide>(context);
        userprovide.UserDrawerdata(userid);
        userprovide.GetUserEntity(userid);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Logout(BuildContext context) async {
    String sql = "delete from sys_login_info ";
    var db = await Application.appdb;
    await db.execute(sql);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return Login();
      },
    ), (route) => route == null);
  }
}
