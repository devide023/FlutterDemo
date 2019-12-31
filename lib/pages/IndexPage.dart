import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterproject/components/SearchDrawerhWidget.dart';
import 'package:flutterproject/components/catetory.dart';
import 'package:flutterproject/components/mycheckbox.dart';
import 'package:flutterproject/components/saledata.dart';
import 'package:flutterproject/components/searchWidget.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:flutterproject/services/IndexService.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
  SearchProvide searchProvide = SearchProvide();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
//      sprovide = Provider.of<SearchProvide>(context, listen: false);
//      sprovide.GetShipClass();
//      sprovide.GetSaleDataByRcno("");
    });
  }

  @override
  void initState() {
    getdata = IndexService().getCatagory();

    super.initState();
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
  Widget _saledata() {
    var _provide = Provider.of<SearchProvide>(context, listen: false);
    return SliverToBoxAdapter(
      child: SaleDataTable(
        list: _provide.saledata_rcno,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    searchProvide.GetShipClass();
    searchProvide.GetSaleDataByRcno("");
    searchProvide.GetPlaceNo();
    List dzxl = [];
    return Scaffold(
      endDrawer: ChangeNotifierProvider.value(
        value: searchProvide,
        child: Consumer<SearchProvide>(
          builder: (context, m, c) {
            return SearchDrawerhWidget(
              shipclasslist: m.shipclass,
              selected_rcno_items: m.rcnoItems,
              onselectedItems: (items){
                m.rcnoItems=items;
              },
              isShow: m.showRcnoItems,
              onshow: (v){
                m.showRcnoItems=v;
              },

              placenolist: m.placeno,
              selectplacenoItems: m.placenoItems,
              onPlacenoSelected: (items){
                m.placenoItems = items;
                m.GetXMTypeList(items);
              },
              showplaceno: m.showplaceno,
              onPlacenoShow: (v){
                m.showPlaceno=v;
              },

              xmtypelist: m.xmtype,
              selectedtypeItems: m.xmtypeItems,
              showXmtype: m.showxmtyp,
              onXmtypeSelected: (items){
                m.xmtypeItems = items;
              },
              onXmtypeShow: (v){
                m.showxmtyp=v;
              },
            );
          },
        ),
      ),
//      searchWidget(
//        onSearch: (v) {
//          rcno = v['rcno'].toString();
//          placeno = v['placeno'] ?? "";
//          typeno = v['typeno'] ?? "";
//          searchProvide.GetSaleDataByRcno(rcno, placeno: placeno, typeno: typeno);
//        },
//      ),
      body: FutureBuilder(
          future: getdata,
          builder: (context, snapshot) {
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
              return ChangeNotifierProvider.value(
                value: searchProvide,
                child: CustomScrollView(
                  slivers: <Widget>[
                    _catagory(list['menutypelist']),
                    SliverToBoxAdapter(
                      child: Consumer<SearchProvide>(
                        builder: (context, model, child) {
                          return DataTable(
                              columns: [
                                DataColumn(label: Text("销售点")),
                                DataColumn(label: Text("类型")),
                                DataColumn(label: Text("金额"), numeric: true),
                              ],
                              rows: model.saledata_rcno.map((f) {
                                return DataRow(cells: [
                                  // ignore: missing_return
                                  DataCell(Text(f['placename'].toString())),
                                  DataCell(Text(f['typename'].toString())),
                                  DataCell(Text(f['je'].toString())),
                                ]);
                              }).toList());
//                            return model.saledata_rcno != null
//                                ? SaleDataTable(
//                                    list: model.saledata_rcno,
//                                  )
//                                : Container();
                        },
                      ),
                    ),
                  ],
                ),
              );

//                Column(
//                children: <Widget>[
//
//                ],
//              );

//                Container(
//                decoration: BoxDecoration(
//                  color: Colors.grey[50],
//                ),
//                child: CustomScrollView(
//                  slivers: <Widget>[
//                    _catagory(list['menutypelist']),
//                    _saledata(),
//                    SliverToBoxAdapter(
//                      child: RaisedButton(
//                        child: Text("分类"),
//                        onPressed: () {
//                          showBottomSheet(
//                              context: context,
//                              builder: (context) {
//                                return Container(
//                                  height: 430.0,
//                                  child: ClipRRect(
//                                    borderRadius: BorderRadius.only(
//                                      topLeft: Radius.circular(15.0),
//                                      topRight: Radius.circular(15.0),
//                                    ),
//                                    child: Column(
//                                      children: <Widget>[
//                                        Container(
//                                          height: 30.0,
//                                          width: double.infinity,
//                                          decoration: BoxDecoration(
//                                            color: Colors.black26,
//                                          ),
//                                          child: Stack(
//                                            children: <Widget>[
//                                              Center(
//                                                child: Text(
//                                                  "分类选择",
//                                                  textAlign: TextAlign.center,
//                                                ),
//                                              ),
//                                              Positioned(
//                                                right: 5.0,
//                                                child: Container(
//                                                  height: 30.0,
//                                                  child: Row(
//                                                    children: <Widget>[
//                                                      Padding(
//                                                        padding: EdgeInsets
//                                                            .symmetric(
//                                                                horizontal:
//                                                                    5.0),
//                                                        child: InkWell(
//                                                          onTap: () {
//                                                            debugPrint(
//                                                                jsonEncode(
//                                                                    dzxl));
//                                                            Navigator.of(
//                                                                    context)
//                                                                .pop();
//                                                          },
//                                                          child: Text(
//                                                            "确定",
//                                                            style: TextStyle(
//                                                              color: Theme.of(
//                                                                      context)
//                                                                  .primaryColor,
//                                                            ),
//                                                          ),
//                                                        ),
//                                                      ),
//                                                      Padding(
//                                                        padding: EdgeInsets
//                                                            .symmetric(
//                                                                horizontal:
//                                                                    5.0),
//                                                        child: InkWell(
//                                                          onTap: () {
//                                                            Navigator.of(
//                                                                    context)
//                                                                .pop();
//                                                          },
//                                                          child: Text(
//                                                            "取消",
//                                                            style: TextStyle(
//                                                              color: Theme.of(
//                                                                      context)
//                                                                  .primaryColor,
//                                                            ),
//                                                          ),
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                ),
//                                              )
//                                            ],
//                                          ),
//                                        ),
//                                        Category(
//                                          category_dl_list: list['placenolist'],
//                                          dl_showfield: "placename",
//                                          dl_valuefield: "placeno",
//                                          zl_showfield: "menuname",
//                                          zl_valuefield: "typeno",
//                                          zl_valuefield1: "menuno",
//                                          xl_showfield: "menuname",
//                                          xl_valuefield: "menuno",
//                                          oncategoryselected: (v) {
//                                            dzxl = v;
//                                          },
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                );
//                              });
//                        },
//                      ),
//                    )
//                  ],
//                ),
//              );
            }
            ;
          }),
    );
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
