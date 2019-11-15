import 'package:flutter/material.dart';
import 'package:flutterproject/pages/HomePage.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:flutterproject/public/NetLoadingDialog.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:provide/provide.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  State<Login> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  GlobalKey _formkey = GlobalKey<FormState>();
  Future _systemlogin(String user, String pwd) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return NetLoadingDialog(
              loadingText: "正在登录请稍候……",
              requestCallBack: UserService().login(user, pwd),
            );
          }).then((res) {
        var result = json.decode(res);
        if (result['user'] != null) {
          Provide.value<UserProvide>(context).SaveUserInfo(result['user']);
        }
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("提示"),
                content: Text(result['msg']),
                actions: <Widget>[
                  FlatButton(
                    child: Text("确定"),
                    onPressed: () {
                      if (result['user'] == null) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => route == null);
                      }
                    },
                  )
                ],
              );
            });
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("错误"),
              content: Text(e.toString()),
              actions: <Widget>[
                FlatButton(
                  child: Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _ctrusername = TextEditingController();
    TextEditingController _ctrusepwd = TextEditingController();
    return Provide<UserProvide>(
      builder: (context, child, model) {
        return Material(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
            child: Form(
              autovalidate: true,
              key: _formkey,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text("系统登录",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 10.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      controller: _ctrusername,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person_outline,
                            color: Colors.deepOrange,
                          ),
                          hintText: "用户名/手机号/电子邮箱",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            width: 0.2,
                            style: BorderStyle.none,
                          ))),
                      keyboardType: TextInputType.text,
                      validator: (v) {
                        return v.trim().length > 0 ? null : '该字段不能为空';
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      controller: _ctrusepwd,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock_outline,
                              color: Theme.of(context).primaryColor),
                          hintText: "密码",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            width: 0.2,
                            style: BorderStyle.none,
                          ))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              FormState form =
                                  _formkey.currentState as FormState;
                              if (form.validate()) {
                                var uname = _ctrusername.text;
                                var upwd = _ctrusepwd.text;
                                _systemlogin(uname, upwd);
                              }
                            },
                            child: Text("登录"),
                            color: Colors.deepOrange,
                            textColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Divider(
                            height: 1.0,
                            color: Colors.grey[60],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  child: Image.asset(
                                    "lib/image/qq.jpg",
                                    width: 50.0,
                                  ),
                                  onTap: () {
                                    print("qq登录");
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: InkWell(
                                  child: Image.asset('lib/image/wechat.jpg',
                                      width: 50.0),
                                  onTap: () {
                                    print("微信登录");
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          "CopyRight©2019 All Rights Reserved",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
