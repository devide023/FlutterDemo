import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/model/LoginResultModel.dart';
import 'package:flutterproject/model/ResponseModel.dart';
import 'package:flutterproject/pages/Login.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:flutterproject/route/application.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Userdao {
  static Future<int> SaveUserInfo(Map<String, dynamic> user) async {
    var db = await Application.appdb;
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
        user['company_id'] ?? 0,
        user['department_id'] ?? 0
      ]);
      return result;
    });
  }

  static Future<Map<String, dynamic>> get GetCurrentUserInfo async {
    var db = await Application.appdb;
    var list =
        await db.rawQuery("select * from sys_user order by id asc limit 1");
    var temp = list.first;
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
      "birthday": temp["birthday"],
      "headimg": temp["headimg"],
    });
  }

  static Future<UserModel> GetUserInfo(int userid) async {
    var db = await Application.appdb;
    var list =
        await db.rawQuery("select * from sys_user where userid =?", [userid]);
    return list.length > 0 ? UserModel.fromJson(list.first) : UserModel();
  }

  static Future<LoginResultModel> islogined() async {
    var db = await Application.appdb;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM sys_login_info'));
    var list = await db.rawQuery(
        "select userid,usercode,userpwd from sys_login_info order by id asc limit 1");
    var userentity = list.first;
    var usercode = userentity['usercode'];
    var userpwd = userentity['userpwd'];
    var loginres = await UserService().login(usercode, userpwd);
    var loginresult = jsonDecode(loginres.toString());
    print("logininfo=========$loginresult");
    var r =  LoginResultModel.fromJson(loginresult);
    Application.userid=r.user.id;
    return r;
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
