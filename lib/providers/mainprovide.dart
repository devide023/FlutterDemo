import 'package:flutter/material.dart';
import 'package:flutterproject/components/myappbar.dart';
import 'package:flutterproject/components/producappbar.dart';
import 'package:flutterproject/components/userappbar.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/pages/MyPage.dart';
import 'package:flutterproject/pages/ProductListPage.dart';
import 'package:flutterproject/pages/UserPage.dart';
import 'package:flutterproject/providers/myprovide.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:scoped_model/scoped_model.dart';

class MainProvide extends Model with UserProvide, MyProvide {
  List<Widget> mainpages = [UserPage(), ProductListPage(), Mypage()];
  List<String> appbartitle = [
    AppConfig.str_userlist,
    AppConfig.str_productlist,
    AppConfig.str_my
  ];
  List<Widget> mainappbars = [
    userappbar(
      title: AppConfig.str_userlist,
    ),
    productappbar(
      title: AppConfig.str_productlist,
    ),
    myappbar(
      title: AppConfig.str_my,
    )
  ];
}
