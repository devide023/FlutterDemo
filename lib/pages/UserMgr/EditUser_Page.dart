import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/components/userform.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/services/UserService.dart';

class EditUser_Page extends StatefulWidget {
  int userid;
  EditUser_Page({Key key, this.userid}) : super(key: key);
  @override
  _EditUser_Page createState() => _EditUser_Page();
}

class _EditUser_Page extends State<EditUser_Page> {
  UserModel userobj;
  void getuser() async {
    var res = await UserService().Find(widget.userid);
    print("edit user-------------${json.decode(res.toString())}");
    userobj = UserModel.fromJson(json.decode(res.toString()));
  }

  @override
  void initState() {
    print("useredit---userid->${widget.userid}");
    getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("编辑用户信息"),
        ),
        body: userform(
          userentity: userobj,
        ));
  }
}
