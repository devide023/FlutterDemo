import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/tools/myurl_lunch.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("用户详情"),
            actions: <Widget>[
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: "edit_header",
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.image),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("上传头像")),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "edit_password",
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.lock_open),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("修改密码")),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "disable",
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.stop),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("禁用")),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "enable",
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.play_arrow),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text("启用")),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (v) {
                  switch (v) {
                    case "edit_header":
                      break;
                    case "edit_password":
                      break;
                    case "disable":
                      break;
                    case "enable":
                      break;
                    default:
                  }
                },
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConfig.str_imgurl + widget.userinfo.headimg,
                fit: BoxFit.cover,
              ),
            ),
            expandedHeight: 200.0,
            pinned: true,
          ),
          SliverFixedExtentList(
            delegate: SliverChildListDelegate(<Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.format_list_numbered),
                  title: Text(widget.userinfo.id.toString()),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.assignment_ind),
                  title: Text(widget.userinfo.status == 1 ? "启用" : '禁用'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text(widget.userinfo.username ?? ""),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.collections),
                  title: Text(widget.userinfo.usercode),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.wc),
                  title: Text(widget.userinfo.sex == 1 ? "男" : "女"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.phone_android),
                  title: Text(widget.userinfo.tel ?? ""),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    myurl_launch.launch_tel(widget.userinfo.tel);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(widget.userinfo.phone ?? ""),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    myurl_launch.launch_tel(widget.userinfo.phone);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(widget.userinfo.address ?? ""),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(widget.userinfo.birthdate),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ]),
            itemExtent: 50.0,
          )
        ],
      ),
    );
  }
}
