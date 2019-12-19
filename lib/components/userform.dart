import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/public/NetLoadingDialog.dart';
import 'package:flutterproject/services/UploadService.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class userform extends StatefulWidget {
  UserModel userentity;
  bool showpasswordfiled;
  bool editusercode;
  bool isadd = true;
  userform(
      {Key key,
      this.userentity,
      this.showpasswordfiled = false,
      this.isadd = true,
      this.editusercode = false})
      : super(key: key);

  @override
  _userform createState() {
    return _userform();
  }
}

class _userform extends State<userform> {
  TextEditingController ctr_usercode = TextEditingController();
  TextEditingController ctr_username = TextEditingController();
  TextEditingController ctr_usertel = TextEditingController();
  TextEditingController ctr_userpwd = TextEditingController();
  TextEditingController ctr_userphone = TextEditingController();
  TextEditingController ctr_address = TextEditingController();
  TextEditingController ctr_birthdate = TextEditingController();
  TextEditingController ctr_head = TextEditingController();
  TextEditingController ctr_sex = TextEditingController();
  String temp = AppConfig.str_default_image;
  int choosesex = 1;
  @override
  void initState() {
    if (!widget.isadd) {
      ctr_usercode.text = widget.userentity.usercode;
      ctr_username.text = widget.userentity.username;
      ctr_usertel.text = widget.userentity.tel;
      ctr_userphone.text = widget.userentity.phone;
      ctr_birthdate.text = widget.userentity.birthday;
      ctr_address.text = widget.userentity.address;
      var sex = widget.userentity.sex;
      if (sex == 1) {
        ctr_sex.text = "男";
      }
      if (sex == 2) {
        ctr_sex.text = "女";
      }
      temp = widget.userentity.headimg ?? AppConfig.str_default_image;
      ctr_head.text = temp;
    }
    super.initState();
  }

  Widget UserPasswordField() {
    if (widget.showpasswordfiled) {
      return Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: TextFormField(
          controller: ctr_userpwd,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock_outline),
            hintText: "用户密码",
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Future SubmitData(FormData formdata) async {
    if (!widget.isadd) {
      return UserService().modify(formdata);
    } else {
      var res = await UserService().add(formdata);
      return res;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      //height: keyboardHeight,
      child: Form(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextFormField(
                    controller: ctr_head,
                    decoration: InputDecoration(
                      icon: Icon(Icons.image),
                      hintText: "头像",
                    ),
                    readOnly: true,
                  ),
                  IconButton(
                    icon: Icon(Icons.cloud_upload),
                    onPressed: () async {
                      var img = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      FormData formData = FormData.fromMap(
                          {"file": await MultipartFile.fromFile(img.path)});
                      var res = await showDialog(
                          context: context,
                          builder: (context) {
                            return NetLoadingDialog(
                              loadingText: "文件上传中……",
                              requestCallBack:
                                  UploadService().uploadImg(formData),
                            );
                          });
                      var resultobj = jsonDecode(res.toString());
                      ctr_head.text = resultobj['filename'];
                    },
                  )
                ],
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
                readOnly: !widget.editusercode,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                controller: ctr_username,
                keyboardType: TextInputType.text,
                decoration:
                    InputDecoration(icon: Icon(Icons.person), hintText: "用户名"),
              ),
            ),
            UserPasswordField(),
            Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: TextFormField(
                  readOnly: true,
                  controller: ctr_sex,
                  decoration: InputDecoration(
                    icon: Icon(Icons.wc),
                    hintText: "性别",
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: Text("请选择性别"),
                            children: <Widget>[
                              SimpleDialogOption(
                                child: Text("男"),
                                onPressed: () {
                                  choosesex = 1;
                                  ctr_sex.text = "男";
                                  Navigator.of(context).pop();
                                },
                              ),
                              SimpleDialogOption(
                                child: Text("女"),
                                onPressed: () {
                                  choosesex = 2;
                                  ctr_sex.text = "女";
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                controller: ctr_usertel,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    icon: Icon(Icons.stay_primary_portrait), hintText: "电话"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                controller: ctr_userphone,
                keyboardType: TextInputType.phone,
                decoration:
                    InputDecoration(icon: Icon(Icons.call), hintText: "座机"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                controller: ctr_birthdate,
                keyboardType: TextInputType.datetime,
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
                decoration:
                    InputDecoration(icon: Icon(Icons.room), hintText: "通讯地址"),
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
                  FormData formdata;
                  if (widget.isadd) {
                    var j = {
                      'id': 0,
                      'sex': choosesex.toString(),
                      'usercode': ctr_usercode.text,
                      'username': ctr_username.text,
                      'tel': ctr_usertel.text,
                      'phone': ctr_userphone.text,
                      'birthday': ctr_birthdate.text,
                      'address': ctr_address.text,
                      'headimg': ctr_head.text,
                      'laravelpwd': ctr_userpwd.text,
                      'status': '1',
                      'company_id': '0',
                      'department_id': '0',
                      'position': '',
                    };
                    formdata = FormData.fromMap(j);
                  } else {
                    widget.userentity.sex = choosesex;
                    widget.userentity.usercode = ctr_usercode.text;
                    widget.userentity.username = ctr_username.text;
                    widget.userentity.tel = ctr_usertel.text;
                    widget.userentity.phone = ctr_userphone.text;
                    widget.userentity.birthday = ctr_birthdate.text;
                    widget.userentity.address = ctr_address.text;
                    widget.userentity.headimg = ctr_head.text;
                    widget.userentity.laravelpwd = ctr_userpwd.text;
                    widget.userentity.id = 0;
                    widget.userentity.status = 1;
                    widget.userentity.companyId = 0;
                    widget.userentity.departmentId = 0;
                    widget.userentity.position = '';
                    widget.userentity.userpwd = '';
                    formdata = FormData.fromMap(widget.userentity.toJson());
                  }
                  var result = await showDialog(
                    context: context,
                    builder: (context) {
                      return NetLoadingDialog(
                        requestCallBack: SubmitData(formdata),
                      );
                    },
                  );
                  var resjson = json.decode(result.toString());
                  Fluttertoast.showToast(
                      msg: resjson['msg'],
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
