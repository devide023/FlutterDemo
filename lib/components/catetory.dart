import 'package:flutter/material.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef categoryselected = void Function(List value);

class Category extends StatefulWidget {
  List category_dl_list = [];
  String dl_showfield = "";
  String dl_valuefield = "";
  String zl_showfield = "";
  String zl_valuefield = "";
  String zl_valuefield1 = "";
  String xl_showfield = "";
  String xl_valuefield = "";
  double category_height = ScreenUtil.screenHeight * 0.4;
  categoryselected oncategoryselected;
  Category({
    Key key,
    this.category_dl_list,
    this.dl_valuefield,
    this.dl_showfield,
    this.zl_showfield,
    this.zl_valuefield,
    this.zl_valuefield1 = "menuno",
    this.xl_showfield,
    this.xl_valuefield,
    this.category_height = 400.0,
    this.oncategoryselected,
  }) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int index_dl = -1;
  int index_xl = -1;
  int index_menucode = -1;
  List selecteditems=['','',''];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.category_height,
      decoration: BoxDecoration(
        color: Colors.black12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _DLWidget(),
          _ZLWidget(),
          Expanded(
            child: _MenuWidget(),
          )
        ],
      ),
    );
  }

  Widget _DLWidget() {
    return Provide<SearchProvide>(
      builder: (context, child, model) {
        return Container(
          width: 100.0,
          child: ListView.separated(
            itemCount: widget.category_dl_list.length,
            padding: EdgeInsets.all(0.0),
            separatorBuilder: (context, index) {
              return Divider(
                height: 1.0,
                color: Colors.black26,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                height: 30.0,
                decoration: BoxDecoration(
                  color: index_dl == index
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                ),
                child: InkWell(
                  onTap: () {
                    var provide = Provide.value<SearchProvide>(context);
                    var placeno = widget.category_dl_list[index]
                            [widget.dl_valuefield]
                        .toString();
                    provide.xmtype.clear();
                    provide.menucodelist.clear();
                    index_xl = -1;
                    index_menucode = -1;
                    selecteditems[0]=widget.category_dl_list[index][widget.dl_valuefield].toString();
                    selecteditems[1]='';
                    selecteditems[2]='';
                    provide.GetXMType(placeno);
                    setState(() {
                      index_dl = index;
                    });
                    widget.oncategoryselected(selecteditems);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.category_dl_list[index][widget.dl_valuefield] +
                          widget.category_dl_list[index][widget.dl_showfield]
                              .toString(),
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color:
                              index == index_dl ? Colors.white : Colors.black,
                          fontSize: 12.0),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _ZLWidget() {
    return Provide<SearchProvide>(
      builder: (context, child, provide) {
        return Container(
          width: 80.0,
          child: ListView.separated(
            padding: EdgeInsets.all(0.0),
            itemCount: provide.xmtype.length,
            separatorBuilder: (content, index) {
              return Divider(
                height: 1.0,
                color: Colors.black26,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                height: 30.0,
                decoration: BoxDecoration(
                  color: index_xl == index
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      var typeno = provide.xmtype[index][widget.zl_valuefield]
                          .toString();
                      var xmtypeno = provide.xmtype[index]
                              [widget.zl_valuefield1]
                          .toString();
                      provide.GetMenuCodeList(typeno, xmtypeno: xmtypeno);
                      provide.menucodelist.clear();
                      index_menucode = -1;
                      selecteditems[1]=provide.xmtype[index][widget.zl_valuefield1].toString();
                      selecteditems[2]='';
                      setState(() {
                        index_xl = index;
                      });
                      widget.oncategoryselected(selecteditems);
                    },
                    child: Text(
                      provide.xmtype[index][widget.zl_valuefield1].toString() +
                          provide.xmtype[index][widget.zl_showfield].toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: index_xl == index ? Colors.white : Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _MenuWidget() {
    return Provide<SearchProvide>(
      builder: (context, child, provide) {
        return Container(
          child: ListView.separated(
            padding: EdgeInsets.all(0.0),
            itemCount: provide.menucodelist.length,
            separatorBuilder: (context, index) {
              return Divider(
                height: 1.0,
                color: Colors.black26,
              );
            },
            itemBuilder: (context, index) {
              return Container(
                height: 30.0,
                decoration: BoxDecoration(
                  color: index_menucode == index
                      ? Theme.of(context).primaryColor
                      : Colors.black12,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      selecteditems[2]=provide.menucodelist[index][widget.xl_valuefield].toString();
                      widget.oncategoryselected(selecteditems);
                      setState(() {
                        index_menucode = index;
                      });
                    },
                    child: Text(
                      provide.menucodelist[index][widget.xl_valuefield] +
                          provide.menucodelist[index][widget.xl_showfield],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: index_menucode == index
                            ? Colors.white
                            : Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
