import 'package:flutter/material.dart';
import 'package:flutterproject/db/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FlatButton(
          child: Text("data"),
          onPressed: () async {
            Database mydb = await DatabaseHelper().db;
            int ret = await mydb.rawInsert(
                "insert into sys_user (usercode,username) values(?,?)",
                ['0001', 'admin']);
            print(ret);
          },
        ),
      ),
    );
  }
}
