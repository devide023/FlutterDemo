import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterproject/components/searchpanel.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:provide/provide.dart';

class searchWidget extends StatefulWidget {
  Function onSearch;
  searchWidget({Key key,this.onSearch,}) : super(key: key);

  @override
  _searchWidgetState createState() => _searchWidgetState();
}

class _searchWidgetState extends State<searchWidget> {
  double _widgetwidth = 300.0;
  Map<String, dynamic> postdata = {};
  @override
  Widget build(BuildContext context) {
    var provide = Provide.value<SearchProvide>(context);
    provide.GetPlaceNo();
    var placenolist = provide.placeno;
    print("placenolist======$placenolist");
    return Provide<SearchProvide>(
      builder: (context, child, model) {
        return Container(
          width: _widgetwidth,
          height: ScreenUtil().height,
          margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SearchPanel(
                        paneltitle: "性别",
                        paneldata: jsonDecode(
                            '[{"code":"0","name":"全部"},{"code":"1","name":"男"},{"code":"2","name":"女"}]'),
                        datakey: "code",
                        datavalue: "name",
                        clickCallback: (v) {
                          print("select value $v");
                          postdata.remove("sex");
                          postdata.addAll({"sex": v["code"]});
                        },
                      ),
                      SearchPanel(
                        paneltitle: "航次",
                        paneldata: model.shipclass,
                        datakey: "rcno",
                        datavalue: "rcno",
                        clickCallback: (v) {
                          print("select value $v");
                          postdata.remove("rcno");
                          postdata.addAll({"rcno": v["rcno"]});
                        },
                      ),
                      SearchPanel(
                        paneltitle: "销售地点",
                        paneldata: placenolist,
                        datakey: "placeno",
                        datavalue: "placename",
                        clickCallback: (v) {
                          provide.GetXMType(v['placeno']);
                          postdata.remove("placeno");
                          postdata.addAll({"placeno": v["placeno"]});
                        },
                      ),
                      SearchPanel(
                        paneltitle: "项目类型",
                        paneldata: provide.xmtype,
                        datakey: "menuno",
                        datavalue: "menuname",
                        clickCallback: (v) {
                          print("select value $v");
                          postdata.remove("typeno");
                          postdata.addAll({"typeno": v["typeno"]});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              _query_btn(),
            ],
          ),
        );
      },
    );
  }

  Widget _query_btn() {
    return Container(
      width: _widgetwidth,
      height: 70.0,
      padding: EdgeInsets.all(0.0),
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            color: Colors.black38,
            child: Container(
              width: 85.0,
              child: Center(
                child: Text(
                  "取消",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Container(
              width: 85.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Center(
                child: Text("确定",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            color: Colors.red,
            onPressed: () {
              print("postdata====$postdata");
              widget.onSearch(postdata);
            },
          )
        ],
      ),
    );
  }

  Widget _queryContent() {
    return Container(
      width: _widgetwidth,
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: "关键字",
                hintStyle: TextStyle(fontSize: 12.0),
                icon: Icon(Icons.vpn_key),
              ),
            )
          ],
        ),
      ),
    );
  }
}
