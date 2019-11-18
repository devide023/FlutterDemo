import 'package:flutter/material.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:provide/provide.dart';

class Drawer_List extends StatefulWidget {
  Drawer_List({Key key}) : super(key: key);

  @override
  _Drawer_ListState createState() => _Drawer_ListState();
}

class _Drawer_ListState extends State<Drawer_List> {
  @override
  Widget build(BuildContext context) {
    return Provide<UserProvide>(builder: (context, child, model) {
      return SliverToBoxAdapter(
        child: ExpansionPanelList.radio(
          children: model.userdrawerdata.map((item) {
            return ExpansionPanelRadio(
              value: item,
              canTapOnHeader: true,
              headerBuilder: (context, isexpand) {
                return ListTile(
                  leading: Icon(Icons.folder_open),
                  title: Text(item['title']),
                );
              },
              body: Container(
                child: ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (item['child'] as List).length,
                  itemBuilder: (context, index) {
                    var sublist = (item['child'] as List);
                    return ListTile(
                      leading: Icon(Icons.insert_drive_file),
                      title: Text(sublist[index]['title']),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    );
                  },
                ),
              ),
            );
          }).toList(),
          expansionCallback: (index, expand) {},
        ),
      );
    });
  }
}
