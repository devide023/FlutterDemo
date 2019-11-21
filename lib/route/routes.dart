import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/pages/HomePage.dart';
import 'package:flutterproject/pages/UserMgr/AddUser.dart';
import 'package:flutterproject/pages/UserMgr/EditUser_Page.dart';
import 'package:flutterproject/pages/UserMgr/UserDetail_Page.dart';
import 'package:flutterproject/pages/UserPage.dart';
import 'package:flutterproject/tools/fluro_convert_util.dart';

class routeconfig {
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define('/home', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return HomePage();
    }));

    router.define("/user/list", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return UserPage();
    }));

    router.define('/user/add', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddUser();
    }));

    router.define('/user/edit', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      var userjson = params['userjson']?.first;
      print("json---------$userjson");
      var userentity =
          UserModel.fromJson(FluroConvertUtils.string2map(userjson));
      return EditUser_Page(
        usermodel: userentity,
      );
    }));

    router.define('user/detail', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      var userinfo = params['userinfo']?.first;
      print("get userinfo json-------$userinfo");
      var userentity =
          UserModel.fromJson(FluroConvertUtils.string2map(userinfo));
      return UserDetail_Page(
        userinfo: userentity,
      );
    }));
  }
}
