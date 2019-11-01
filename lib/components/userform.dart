import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:flutterproject/public/NetLoadingDialog.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:scoped_model/scoped_model.dart';

class userform extends StatefulWidget {
  UserModel userentity;
  userform({Key key, this.userentity}) : super(key: key);
  @override
  State<userform> createState() {
    return _userform();
  }
}

class _userform extends State<userform> {
  TextEditingController ctr_usercode = TextEditingController();
  TextEditingController ctr_username = TextEditingController();
  TextEditingController ctr_usertel = TextEditingController();
  TextEditingController ctr_userphone = TextEditingController();
  TextEditingController ctr_sex = TextEditingController();
  TextEditingController ctr_address = TextEditingController();
  TextEditingController ctr_birthdate = TextEditingController();
  TextEditingController ctr_head = TextEditingController();
  String temp = AppConfig.str_default_image;
  int choosesex = 1;

  @override
  Widget build(BuildContext context) {
    if (userentity != null) {
      ctr_usercode.text = widget.userentity.usercode;
      ctr_username.text = widget.userentity.username;
      ctr_usertel.text = widget.userentity.tel;
      ctr_userphone.text = widget.userentity.phone;
      ctr_birthdate.text = widget.userentity.birthdate;
      ctr_address.text = widget.userentity.address;
      ctr_birthdate.text = widget.userentity.birthdate;
      temp = widget.userentity.headimg ?? AppConfig.str_default_image;
      ctr_head.text = temp;
    }
    return ScopedModelDescendant<MainProvide>(
      builder: (context, child, model) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: ctr_head,
                    decoration: InputDecoration(
                      icon: Icon(Icons.image),
                      hintText: "头像",
                    ),
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    controller: ctr_usercode,
                    decoration: InputDecoration(
                      icon: Icon(Icons.code),
                      hintText: "用户编码",
                    ),
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    controller: ctr_username,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), hintText: "用户名"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.wc),
                      Flexible(
                        child: RadioListTile(
                          value: 1,
                          title: Text("男"),
                          groupValue: choosesex,
                          onChanged: (v) {
                            setState(() {
                              choosesex = v;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          value: 2,
                          title: Text("女"),
                          groupValue: choosesex,
                          onChanged: (v) {
                            setState(() {
                              choosesex = v;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    controller: ctr_usertel,
                    decoration: InputDecoration(
                        icon: Icon(Icons.stay_primary_portrait),
                        hintText: "电话"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    controller: ctr_userphone,
                    decoration:
                        InputDecoration(icon: Icon(Icons.call), hintText: "座机"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    controller: ctr_birthdate,
                    decoration: InputDecoration(
                        icon: Icon(Icons.date_range), hintText: "出生日期"),
                    readOnly: true,
                    onTap: () async {
                      var d = await showDatePicker(
                          firstDate: DateTime(1700),
                          lastDate: DateTime(2900, 12, 31),
                          initialDate: DateTime.now(),
                          context: context,
                          locale: Locale('zh'));
                      ctr_birthdate.text = d.toString().substring(0, 10);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    controller: ctr_address,
                    decoration: InputDecoration(
                        icon: Icon(Icons.room), hintText: "通讯地址"),
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                  child: FlatButton(
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: Text("确定"),
                    onPressed: () async {
                      widget.userentity.sex = choosesex;
                      var formdata =
                          FormData.fromMap(widget.userentity.toJson());
                      var result = await showDialog(
                        context: context,
                        builder: (context) {
                          return NetLoadingDialog(
                            requestCallBack: UserService().modify(formdata),
                          );
                        },
                      );
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("提示"),
                              content: json.decode(result.toString())['msg'],
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("确定"),
                                  onPressed: () {},
                                )
                              ],
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
