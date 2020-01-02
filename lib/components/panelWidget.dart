import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  String paneltitle = '';
  bool show = false;
  List datalist = [];
  String valuefield = 'code';
  String displayfield = 'name';
  List<String> selectedItems = [];
  Function onShow;
  Function onItemSelected;

  PanelWidget({
    @required this.paneltitle,
    this.show,
    @required this.datalist,
    this.selectedItems,
    this.valuefield,
    this.displayfield,
    @required this.onShow,
    @required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    var _panelheader = Container(
      height: 30.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(paneltitle),
          ),
          Container(
            width: 30.0,
            height: 30.0,
            child: InkWell(
              onTap: () {
                onShow(!show);
              },
              child: show
                  ? Icon(Icons.keyboard_arrow_down)
                  : Icon(Icons.keyboard_arrow_up),
            ),
          ),
        ],
      ),
    );
    var _list = datalist.map((item) {
      return InkWell(
        onTap: () {
          int pos = selectedItems.indexOf(item[valuefield]);
          if (pos < 0) {
            selectedItems.add(item[valuefield]);
          } else {
            selectedItems.remove(item[valuefield]);
          }
          onItemSelected(selectedItems);
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
    var _panelbody = Offstage(
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
    return Container(
      child: Column(
        children: <Widget>[
          _panelheader,
          _panelbody,
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
}
