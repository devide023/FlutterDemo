import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/pages/HomePage.dart';
import 'package:flutterproject/pages/UserMgr/AddUser.dart';
import 'package:flutterproject/pages/UserMgr/EditUser_Page.dart';
import 'package:flutterproject/services/UserService.dart';

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

    router.define('/user/add', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return AddUser();
    }));

    router.define('/user/edit', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      var userid = params['userid']?.first;
      return EditUser_Page(
        userid: int.parse(userid),
      );
    }));
  }
}
