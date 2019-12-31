import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/model/ResponseModel.dart';

class LoginResultModel extends ResponseModel {
  UserModel _user;

  LoginResultModel({UserModel user, int code, String msg})
      : super(code: code, msg: msg) {
    _user = user;
  }

  UserModel get user=>_user;
  set user(UserModel user)=>_user = user;
  LoginResultModel.fromJson(Map<String, dynamic> json) {
    _user = UserModel.fromJson(json['user']);
    code = json['code'];
    msg = json['msg'];
  }
}
