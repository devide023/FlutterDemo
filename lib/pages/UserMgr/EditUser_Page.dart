import 'package:flutter/material.dart';
import 'package:flutterproject/components/userform.dart';
import 'package:flutterproject/entitys/userentity.dart';

class EditUser_Page extends StatefulWidget {
  UserModel userobj;
  EditUser_Page({Key key, this.userobj}) : super(key: key);
  @override
  _EditUser_Page createState() => _EditUser_Page();
}

class _EditUser_Page extends State<EditUser_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("编辑用户信息"),
        ),
        body: userform(
          userentity: widget.userobj,
        ));
  }
}
