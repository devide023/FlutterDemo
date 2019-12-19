import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/components/userform.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/entitys/userentity.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() {
    return _AddUser();
  }
}

class _AddUser extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加用户信息"),
      ),
      body: userform(
        isadd: true,
        editusercode: true,
        showpasswordfiled: true,
      ),
    );
  }
}
