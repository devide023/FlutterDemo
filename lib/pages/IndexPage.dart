import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterproject/components/catetory.dart';
import 'package:flutterproject/components/searchWidget.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:flutterproject/public/MyScrollBehavior.dart';
import 'package:flutterproject/services/IndexService.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:provide/provide.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Future getdata;

  @override
  void initState() {
    getdata = IndexService().getCatagory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchprovide = Provide.value<SearchProvide>(context);
    List dzxl=[];
    searchprovide.GetShipClass();
    return Scaffold(
      endDrawer: searchWidget(),
      body: FutureBuilder(
        future: getdata,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return Material(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          if (snapshot.hasData) {
            var list = jsonDecode(snapshot.data.toString());
            return CustomScrollView(
              slivers: <Widget>[
                _catagory(list['menutypelist']),
                SliverToBoxAdapter(
                  child: RaisedButton(
                    child: Text("分类"),
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 430.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 30.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                      ),
                                      child: Stack(
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "分类选择",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Positioned(
                                            right: 5.0,
                                            child: Container(
                                              height: 30.0,
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        debugPrint(jsonEncode(dzxl));
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text(
                                                        "确定",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "取消",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Category(
                                      category_dl_list: list['placenolist'],
                                      dl_showfield: "placename",
                                      dl_valuefield: "placeno",
                                      zl_showfield: "menuname",
                                      zl_valuefield: "typeno",
                                      zl_valuefield1: "menuno",
                                      xl_showfield: "menuname",
                                      xl_valuefield: "menuno",
                                      oncategoryselected: (v){
                                        dzxl = v;
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  //菜单类目
  Widget _catagory(List list) {
    return SliverToBoxAdapter(
      child: Container(
        width: ScreenUtil().setWidth(750.0),
        height: ScreenUtil().setHeight(400.0),
        //color: Colors.deepOrange,
        child: Swiper(
          itemCount: (list.length / 10).ceil(),
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.grey,
            activeColor: Colors.deepOrange,
          )),
          autoplay: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GridView.count(
              crossAxisCount: 5,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              physics: NeverScrollableScrollPhysics(),
              children: list.skip(index * 10).take(10).map((item) {
                return Container(
                  width: ScreenUtil().setWidth(70.0),
                  height: ScreenUtil().setHeight(70.0),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        style: BorderStyle.solid,
                        width: 1.0,
                        color: Theme.of(context).primaryColor,
                      )),
                  child: Center(
                    child: Text(
                      item['typename'],
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  //table
  Widget _table() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        height: 100.0,
        child: ScrollConfiguration(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(50.0),
                1: FixedColumnWidth(80.0),
                2: FixedColumnWidth(80.0),
                3: FixedColumnWidth(100.0),
                4: FixedColumnWidth(60.0),
                5: FixedColumnWidth(50.0),
              },
              border: new TableBorder.all(width: 1.0, color: Colors.black26),
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                    ),
                    children: [
                      TableCell(
                        child: Center(
                          child: Text("A"),
                        ),
                      ),
                      TableCell(
                        child: Text("B"),
                      ),
                      TableCell(
                        child: Text("C"),
                      ),
                      TableCell(
                        child: Text("D"),
                      ),
                      TableCell(
                        child: Text("E"),
                      ),
                      TableCell(
                        child: Text("F"),
                      ),
                    ]),
                TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text("data1"),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text("data2"),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text("data3"),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text("data4"),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text("data5"),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text("data6"),
                    ),
                  ),
                ])
              ],
            ),
          ),
          behavior: MyScrollBehavior(),
        ),
      ),
    );
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
