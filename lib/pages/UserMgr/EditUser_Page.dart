import 'package:flutter/material.dart';
import 'package:flutterproject/components/userform.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:provide/provide.dart';
import 'package:scoped_model/scoped_model.dart';

class EditUser_Page extends StatelessWidget {
  UserModel usermodel;
  EditUser_Page({Key key, this.usermodel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("编辑用户信息"),
        ),
        body: userform(
          userentity: usermodel,
        ));
  }
}
