import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterproject/components/catetory.dart';
import 'package:flutterproject/components/searchWidget.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:flutterproject/services/IndexService.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Future getdata;
  String rcno = '';
  String placeno = '';
  String typeno = '';

  @override
  void initState() {
    getdata = IndexService().getCatagory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchprovide = Provide.value<SearchProvide>(context);
    List dzxl = [];
    searchprovide.GetShipClass();
    searchprovide.GetSaleDataByRcno("");
    rcno = "";
    placeno = '';
    typeno = '';
    return Scaffold(
      endDrawer: searchWidget(
        onSearch: (v) {
          rcno = v['rcno'].toString();
          placeno = v['placeno'] ?? "";
          typeno = v['typeno'] ?? "";
          searchprovide.GetSaleDataByRcno(rcno,
              placeno: placeno, typeno: typeno);
        },
      ),
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
            return Provide<SearchProvide>(
              builder: (context, child, sprovide) {
                rcno = rcno == "" ? sprovide.shipclass.first['rcno'] : rcno;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                  ),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      _catagory(list['menutypelist']),
                      _saledata(sprovide.saledata_rcno, rcno),
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
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              debugPrint(
                                                                  jsonEncode(
                                                                      dzxl));
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "确定",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                              "取消",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
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
                                            category_dl_list:
                                                list['placenolist'],
                                            dl_showfield: "placename",
                                            dl_valuefield: "placeno",
                                            zl_showfield: "menuname",
                                            zl_valuefield: "typeno",
                                            zl_valuefield1: "menuno",
                                            xl_showfield: "menuname",
                                            xl_valuefield: "menuno",
                                            oncategoryselected: (v) {
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
                  ),
                );
              },
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
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
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
  Widget _saledata(List list, String rcno) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("航次${rcno}销售详情："),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text("销售点"),
                    ),
                    DataColumn(
                      label: Text("类别"),
                    ),
                    DataColumn(
                      label: Text("金额"),
                      numeric: true,
                    ),
                  ],
                  rows: list.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item['placename'].toString())),
                      DataCell(Text(item['typename'].toString())),
                      DataCell(Text(item['je'].toString())),
                    ]);
                  }).toList()),
            ),
          ),
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
