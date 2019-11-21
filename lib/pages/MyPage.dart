import 'package:flutter/material.dart';
import 'package:flutterproject/db/DatabaseHelper.dart';
import 'package:flutterproject/db/Dbmanager.dart';
import 'package:flutterproject/db/userdao.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:flutterproject/route/application.dart';
import 'package:provide/provide.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() {
      if (_tabController.index.toDouble() == _tabController.animation.value) {
        var index = _tabController.index;
        var previousIndex = _tabController.previousIndex;
        print("index: $index");
        print('previousIndex: $previousIndex');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: <Widget>[
            Tab(
              child: Text("sqflite"),
            ),
            Tab(
              child: Text("tab2"),
            ),
            Tab(
              child: Text("tab3"),
            ),
            Tab(
              child: Text("tab4"),
            ),
          ],
        ),
        //centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: FlatButton(
              child: Text("logout"),
              onPressed: () async {
                Userdao.Logout(context);
              },
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                var dh = DatabaseHelper();
                dh.db.then((_db) async {
                  List<Map> list = await _db.rawQuery(
                      "select id,usercode,username,userpwd,userid from sys_user");
                  for (var item in list) {
                    print(
                        "=====sqflite====list->id:${item['id']}--${item['usercode']} username->${item['username']}->userid->${item['userid']}");
                  }
                });
              },
              child: Text("获取数据"),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                var uid = Provide.value<UserProvide>(context).userentity.id;
                print("======uid=====$uid");
                UserModel entity = await Userdao.GetUserInfo(uid);
                print(
                    "======UserModel=====${entity.id}->${entity.usercode}->${entity.username}->${entity.birthdate}");
              },
              child: Text("获取本地用户信息"),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                var db = await Application.appdb;
                var des =
                    await Dbmanager.sqlite_table_describe(db, "sqlite_master");
                print("desc>>>>>>$des");
                var list = await Dbmanager.sqlite_tabeles(db);
                for (var item in list) {
                  print("item>>>>>>${item}");
                }
              },
              child: Text("dbmanager"),
            ),
          )
        ],
      ),
    );
  }
}
