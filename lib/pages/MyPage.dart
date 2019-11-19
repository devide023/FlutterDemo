import 'package:flutter/material.dart';
import 'package:flutterproject/db/DatabaseHelper.dart';

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
              child: Text("sqflite test"),
              onPressed: () {
                var mydb = DatabaseHelper();
                mydb.db.then((_db) {
                  _db.transaction((trans) async {
                    return await trans.rawInsert(
                        "insert into sys_user(usercode,username) values('0002','admin')");
                  });
                });
              },
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                var dh = DatabaseHelper();
                dh.db.then((_db) async {
                  var list = await _db.rawQuery("select * from sys_user");
                  print("=====sqflite====list->${list.length}");
                });
              },
              child: Text("获取数据"),
            ),
          ),
          Center(
            child: Text("tab3"),
          ),
          Center(
            child: Text("tab4"),
          )
        ],
      ),
    );
  }
}
