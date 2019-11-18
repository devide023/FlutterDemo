import 'package:flutter/material.dart';
import 'package:flutterproject/components/drawer_header.dart';
import 'package:flutterproject/components/drawer_list.dart';

class DrawerIndex extends StatefulWidget {
  DrawerIndex({Key key}) : super(key: key);

  @override
  _DrawerIndexState createState() => _DrawerIndexState();
}

class _DrawerIndexState extends State<DrawerIndex> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        Drawer_Header_Widget(),
        Drawer_List(),
      ],
    );
  }
}
