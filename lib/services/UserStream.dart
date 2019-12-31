import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/services/UserService.dart';

class UserStream {
  UserStream();

  Stream<List<UserModel>> UserList() {
    return Stream<List<UserModel>>.fromFuture(UserService().allusers());
  }
}
