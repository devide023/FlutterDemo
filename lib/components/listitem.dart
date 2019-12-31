import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/pages/UserMgr/EditUser_Page.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:flutterproject/tools/fluro_convert_util.dart';
import '../route/application.dart';

class listitem extends StatefulWidget {
  UserModel userobj;
  listitem({Key key, this.userobj}) : super(key: key);
  @override
  _listitem createState() => _listitem();
}

class _listitem extends State<listitem> {
  @override
  Widget build(BuildContext context) {
    var tempname = AppConfig.str_default_image;
    if (widget.userobj.headimg != null) {
      tempname = widget.userobj.headimg;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(AppConfig.str_imgurl + tempname),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.userobj.username,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.userobj.usercode,
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 1.0),
            child: PopupMenuButton(
              onSelected: (v) {
                switch (v) {
                  case "detail":
                    String userjson =
                        FluroConvertUtils.object2string(widget.userobj);
                    Application.router
                        .navigateTo(context, '/user/detail?userinfo=$userjson');
                    break;
                  case 'edit':
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EditUser_Page(
                        usermodel: widget.userobj,
                      );
                    }));
                    // String userjson =
                    //     FluroConvertUtils.object2string(widget.userobj);
                    // model.mainrouter
                    //     .navigateTo(context, '/user/edit?userjson=$userjson');
                    break;
                  case 'del':
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("提示"),
                            content: Text("你确定要删除？"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("确定"),
                                onPressed: () async {
                                  var res = await UserService()
                                      .remove(widget.userobj.id);

                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("取消"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                    break;
                  case 'enable':
                    break;
                  case 'setpwd':
                    showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController ctr_setpwd =
                              TextEditingController();
                          return Dialog(
                              child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            height: 150.0,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 15.0),
                                  child: TextField(
                                    decoration:
                                        InputDecoration(hintText: "新密码"),
                                    controller: ctr_setpwd,
                                    obscureText: true,
                                  ),
                                ),

                              ],
                            ),
                          ));
                        });
                    break;
                }
              },
              itemBuilder: (context) {
                return <PopupMenuItem>[
                  PopupMenuItem(
                    value: 'detail',
                    child: Text("详情"),
                  ),
                  // PopupMenuItem(
                  //   value: 'edit',
                  //   child: Text("编辑"),
                  // ),
                  // PopupMenuItem(
                  //   value: 'del',
                  //   child: Text("删除"),
                  // ),
                  // PopupMenuItem(
                  //   value: 'enabel',
                  //   child: Text("启用"),
                  // ),
                  // PopupMenuItem(
                  //   value: 'setpwd',
                  //   child: Text("重置密码"),
                  // )
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
