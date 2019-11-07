import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';

class UserDetail_Page extends StatefulWidget {
  UserModel userinfo;
  UserDetail_Page({
    Key key,
    this.userinfo,
  }) : super(key: key);
  @override
  State<UserDetail_Page> createState() {
    return _UserDetail();
  }
}

class _UserDetail extends State<UserDetail_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户详情"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'save',
                  child: Text("保存"),
                )
              ];
            },
            onSelected: (v) {
              switch (v) {
                case 'save':
                  print('save');
                  break;
                default:
              }
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text("userdetails${widget.userinfo.id}"),
      ),
    );
  }
}
