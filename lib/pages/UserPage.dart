import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' show StatelessWidget;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutterproject/components/listitem.dart';
import 'package:flutterproject/components/userappbar.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/services/UserService.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() {
    return _UserPage();
  }
}

class _UserPage extends State<UserPage> with AutomaticKeepAliveClientMixin {
  List<UserModel> list = List();
  int pagesize = 10; //每页数量
  int pageindex = 1; //页索引
  int pagecount = 0;
  EasyRefreshController _controller;
  Future<List<UserModel>> GetUserData() async {
    List<UserModel> datalist = [];
    var data = FormData.fromMap({"per_page": pagesize, "page": pageindex});
    var result = await UserService().list(data);
    var pageinfo = jsonDecode(result.toString())['list'];
    pagecount = pageinfo['last_page'];
    (pageinfo['data'] as List).forEach((item) {
      datalist.add(UserModel.fromJson(item));
    });
    return datalist;
  }

  @override
  void initState() {
    _controller = EasyRefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userappbar(
        title: AppConfig.str_userlist,
      ),
      body: EasyRefresh(
          firstRefresh: true,
          controller: _controller,
          header: MaterialHeader(),
          footer: ClassicalFooter(
              loadingText: "努力加载中……",
              loadedText: "加载完成",
              noMoreText: "没有内容了",
              infoText: "更新于%T"),
          firstRefreshWidget: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return listitem(
                userobj: list[index],
              );
            },
          ),
          onRefresh: () async {
            pageindex = 1;
            var data = await GetUserData();
            setState(() {
              list.clear();
              list.addAll(data);
            });
            _controller.resetLoadState();
            _controller.finishRefresh();
          },
          onLoad: () async {
            pageindex++;
            var data = await GetUserData();
            setState(() {
              list.addAll(data);
            });
            _controller.finishLoad(noMore: pageindex > pagecount);
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
