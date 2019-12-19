import 'package:flutter/material.dart';
import 'package:flutterproject/db/DatabaseHelper.dart';
import 'package:flutterproject/db/Dbmanager.dart';
import 'package:flutterproject/db/userdao.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:flutterproject/route/application.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pagecontroller;
  List pageviewlist = ['page1', 'page2', 'page3', 'page4', 'page5'];
  int activeindex = 0;
  List pageviewcolors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.deepOrange,
    Colors.pink
  ];
  @override
  void initState() {
    _pagecontroller = PageController(initialPage: 0, viewportFraction: 0.8);
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

  Widget _chart() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    var chart_data = [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
    return charts.BarChart(
      chart_data,
      animate: true,
    );
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
          Column(
            children: <Widget>[
              Container(
                width: ScreenUtil().setHeight(750.0),
                height: 200.0,
                child: _chart(),
              ),
            ],
          ),
          Container(
            color: Colors.deepPurple,
            height: 100.0,
            child: PageView.builder(
              itemCount: pageviewlist.length,
              pageSnapping: true,
              onPageChanged: (int index) {
                setState(() {
                  activeindex = index;
                });
              },
              controller: _pagecontroller,
              itemBuilder: (context, index) {
                print("activeindex===$activeindex====index===$index");
                return AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Duration(microseconds: 300),
                  height: index == activeindex ? 100.0 : 50.0,
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: pageviewcolors[index],
                    borderRadius: BorderRadius.all(Radius.circular(13.0)),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        child: Image.network(
                          'http://a.hiphotos.baidu.com/image/pic/item/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.0),
                                    bottomLeft: Radius.circular(12.0),
                                  ),
                                ),
                                child: Text(
                                  pageviewlist[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                var uid = Provide.value<UserProvide>(context).userentity.id;
                print("======uid=====$uid");
                UserModel entity = await Userdao.GetUserInfo(uid);
                print(
                    "======UserModel=====${entity.id}->${entity.usercode}->${entity.username}->${entity.birthday}");
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

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
