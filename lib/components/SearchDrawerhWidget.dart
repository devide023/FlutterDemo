import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterproject/components/panelWidget.dart';

class SearchDrawerhWidget extends StatelessWidget {
  double _width = 400.0;
  bool isShow = false;
  List shipclasslist = [];
  List selected_rcno_items = [];
  Function onselectedItems;
  Function onshow;

  List placenolist = [];
  List<String> selectplacenoItems = [];
  bool showplaceno = false;
  Function onPlacenoSelected;
  Function onPlacenoShow;

  List xmtypelist = [];
  List<String> selectedtypeItems = [];
  bool showXmtype = false;
  Function onXmtypeSelected;
  Function onXmtypeShow;

  Function onCancel;
  Function onQuery;

  SearchDrawerhWidget({
    Key key,
    this.shipclasslist,
    this.selected_rcno_items,
    this.onselectedItems,
    this.isShow = false,
    this.onshow,
    this.placenolist,
    this.selectplacenoItems,
    this.showplaceno = false,
    this.onPlacenoSelected,
    this.onPlacenoShow,
    this.xmtypelist,
    this.selectedtypeItems,
    this.showXmtype = false,
    this.onXmtypeSelected,
    this.onXmtypeShow,
    this.onCancel,
    this.onQuery,
  }) : super(key: key);

  Widget _shipclassWidget() {
    return Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: PanelWidget(
          paneltitle: "航次",
          datalist: shipclasslist,
          selectedItems: selected_rcno_items,
          onShow: onshow,
          onItemSelected: onselectedItems,
          show: isShow,
          valuefield: "rcno",
          displayfield: 'rcno',
        ));
  }

  Widget _placenoListWidget() {
    return PanelWidget(
      paneltitle: "销售地点",
      datalist: placenolist,
      show: showplaceno,
      selectedItems: selectplacenoItems,
      onShow: onPlacenoShow,
      onItemSelected: onPlacenoSelected,
      valuefield: "placeno",
      displayfield: "placename",
    );
  }

  Widget _xmtypeListWidget() {
    return PanelWidget(
      paneltitle: "分类",
      datalist: xmtypelist,
      show: showXmtype,
      selectedItems: selectedtypeItems,
      onShow: onXmtypeShow,
      onItemSelected: onXmtypeSelected,
      displayfield: "menuname",
      valuefield: "menuno",
    );
  }

  Widget _btnWidget() {
    return Container(
      height: 40.0,
      width: _width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: onCancel,
            child: Container(
              width: 80.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "取消",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 10.0,
            ),
            child: FlatButton(
              onPressed: onQuery,
              child: Container(
                width: 80.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "确定",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                bottom: 40.0,
              ),
              child: Column(
                children: <Widget>[
                  _shipclassWidget(),
                  _placenoListWidget(),
                  _xmtypeListWidget(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: _btnWidget(),
          )
        ],
      ),
    );
  }
}
