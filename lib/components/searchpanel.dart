import 'package:flutter/material.dart';

class SearchPanel extends StatefulWidget {
  String paneltitle = '';
  List paneldata = [];
  String datakey = "code";
  String datavalue = "name";
  Function clickCallback;
  SearchPanel(
      {Key key,
      this.paneltitle,
      this.paneldata,
      this.clickCallback,
      this.datakey,
      this.datavalue})
      : super(key: key);

  @override
  _SearchPanelState createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  bool isshow = false;
  List checkedvalues = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _Panel(widget.paneltitle, widget.paneldata, widget.clickCallback,
          widget.datakey, widget.datavalue),
    );
  }

  Widget _Panel(
      String title, List data, Function callback, String k, String v) {
    var head = Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          //Panel标题
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
          //展开关闭图标
          Container(
            width: 20.0,
            margin: EdgeInsets.only(right: 10.0),
            child: InkWell(
              child: Icon(
                  isshow ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
              onTap: () {
                setState(() {
                  isshow = !isshow;
                });
              },
            ),
          )
        ],
      ),
    );
    var body = Container(
      child: Offstage(
        offstage: isshow,
        child: GridView.count(
          padding: EdgeInsets.all(6.0),
          crossAxisCount: 4,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 2.0,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: data.map((item) {
            return Container(
              decoration: BoxDecoration(
                  color: checkedvalues.indexOf(item[k]) < 0
                      ? Colors.black12
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      checkedvalues
                        ..clear()
                        ..add(item[k]);
                    });
                    callback(item);
                  },
                  child: Text(
                    item[v].toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: checkedvalues.indexOf(item[k]) >= 0
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );

    var div = Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Divider(
        color: Colors.black26,
        height: 2.0,
      ),
    );

    return Column(
      children: <Widget>[
        head,
        body,
        div,
      ],
    );
  }
}
