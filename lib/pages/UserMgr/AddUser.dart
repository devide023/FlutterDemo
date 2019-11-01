import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterproject/http/request.dart';
import 'package:flutterproject/public/NetLoadingDialog.dart';
import 'package:flutterproject/services/UploadService.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddUser();
  }
}

class _AddUser extends State<StatefulWidget> {
  final TextEditingController _ctrUserName = TextEditingController();
  final TextEditingController _ctrUserPwd = TextEditingController();
  final TextEditingController _ctrTel = TextEditingController();
  final TextEditingController _ctrPhone = TextEditingController();
  final TextEditingController _ctrUserCode = TextEditingController();
  final TextEditingController _ctrAddress = TextEditingController();
  final TextEditingController _ctrbirthdate = TextEditingController();
  final TextEditingController _ctrheader = TextEditingController();
  var _sex = 1;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _ctrUserCode,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mood),
                    labelText: '请输入用户编码',
                    prefixStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: _ctrUserName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    labelText: '请输入用户姓名',
                    prefixStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              DropdownButtonFormField(
                value: _sex,
                items: <DropdownMenuItem>[
                  DropdownMenuItem(
                    value: 1,
                    child: Text('男'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('女'),
                  )
                ],
                onChanged: (v) {
                  setState(() {
                    _sex = v;
                  });
                },
                onSaved: (v) {
                  _sex = v;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.block),
                    prefixStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: _ctrbirthdate,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  prefixStyle:
                      TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  DatePicker.showDatePicker(context, onConfirm: (date) {
                    _ctrbirthdate.text = DateFormat("yyyy-MM-dd").format(date);
                  }, locale: LocaleType.zh, minTime: DateTime(1900, 01, 01));
                },
              ),
              TextFormField(
                controller: _ctrUserPwd,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: '请输入用户密码',
                    prefixStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: _ctrTel,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: '请输入手机号码',
                    prefixStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: _ctrPhone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.details),
                    labelText: '请输入座机号码',
                    prefixStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: _ctrAddress,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    labelText: '请输入联系地址',
                    prefixStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: _ctrheader,
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.image),
                ),
                onTap: () async {
                  var image =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  FormData formData = FormData.fromMap(
                      {"file": await MultipartFile.fromFile(image.path)});
                  Response response = await UploadService().uploadImg(formData);
                  if (response.statusCode == 200) {
                    print('imgres--:${response.data}');
                    var resdata = json.decode(response.data);
                    _ctrheader.text = resdata['filename'];
                  } else {
                    throw Exception('后端接口异常');
                  }
                },
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                label: Text('添加'),
                onPressed: () async {
                  FormData formdata = FormData.fromMap({
                    "usercode": _ctrUserCode.text,
                    "userpwd": _ctrUserPwd.text,
                    "username": _ctrUserName.text,
                    "tel": _ctrTel.text,
                    "phone": _ctrPhone.text,
                    "birthdate": _ctrbirthdate.text,
                    "sex": _sex,
                    "address": _ctrAddress.text,
                    "headimg": _ctrheader.text,
                  });

                  Future f = UserService().add(formdata);
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return NetLoadingDialog(
                          outsideDismiss: false,
                          requestCallBack: f,
                        );
                      });
                },
                textColor: Colors.white,
                color: Colors.deepOrange,
                padding: EdgeInsets.all(5.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
