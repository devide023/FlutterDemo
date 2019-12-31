import 'package:flutter/material.dart';

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
  List<String> selectedtypeItems=[];
  bool showXmtype = false;
  Function onXmtypeSelected;
  Function onXmtypeShow;

  SearchDrawerhWidget({
    Key key,
    this.shipclasslist,
    this.selected_rcno_items,
    this.onselectedItems,
    this.isShow=false,
    this.onshow,
    this.placenolist,
    this.selectplacenoItems,
    this.showplaceno=false,
    this.onPlacenoSelected,
    this.onPlacenoShow,
    this.xmtypelist,
    this.selectedtypeItems,
    this.showXmtype=false,
    this.onXmtypeSelected,
    this.onXmtypeShow,
  }) : super(key: key);

  Widget _panelTitle(String title, bool show, Function fun) {
    return Container(
      height: 30.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(title),
          ),
          Container(
            width: 30.0,
            height: 30.0,
            child: InkWell(
              onTap: () {
                fun(!show);
              },
              child: show
                  ? Icon(Icons.keyboard_arrow_down)
                  : Icon(Icons.keyboard_arrow_up),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panelBody(List list, bool show, List selectedItems,
      Function funselected, String valuefield, String displayfield) {
    var _list = list.map((item) {
      return InkWell(
        onTap: () {
          int pos = selectedItems.indexOf(item[valuefield]);
          if (pos < 0) {
            selectedItems.add(item[valuefield]);
          } else {
            selectedItems.remove(item[valuefield]);
          }
          funselected(selectedItems);
        },
        child: Container(
          decoration: BoxDecoration(
            color: selectedItems.contains(item[valuefield].toString())
                ? Colors.deepOrange
                : Colors.black12,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              item[displayfield],
              style: TextStyle(
                fontSize: 12.0,
                color: selectedItems.contains(item[valuefield].toString())
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
      );
    }).toList();
    return Offstage(
      offstage: show,
      child: GridView.count(
        padding: EdgeInsets.all(0.0),
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 3.0,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 4,
        children: _list,
      ),
    );
  }

  Widget _shipclassWidget() {
    var _Header = _panelTitle("航次", isShow, onshow);
    var _Body = _panelBody(shipclasslist, isShow, selected_rcno_items,
        onselectedItems, "rcno", "rcno");

    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 30,
            ),
            child: _Header,
          ),
          _Body,
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placenoListWidget() {
    var _Header = _panelTitle("销售地点", showplaceno, onPlacenoShow);
    var _Body = _panelBody(placenolist, showplaceno, selectplacenoItems,
        onPlacenoSelected, 'placeno', 'placename');
    return Container(
      child: Column(
        children: <Widget>[
          _Header,
          _Body,
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: Divider(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _xmtypeListWidget(){
    var _Header = _panelTitle("分类", showXmtype, onXmtypeShow);
    var _Body = _panelBody(xmtypelist, showXmtype, selectedtypeItems, onXmtypeSelected, 'menuno', 'menuname');
    return Container(
      child: Column(
        children: <Widget>[
          _Header,
          _Body,
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
            child: Divider(
              height: 1.0,
              color: Colors.grey,
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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _shipclassWidget(),
            _placenoListWidget(),
            _xmtypeListWidget(),
          ],
        ),
      ),
    );
  }
}
