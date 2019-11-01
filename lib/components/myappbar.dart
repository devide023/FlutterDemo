import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';

class myappbar extends StatefulWidget with PreferredSizeWidget {
  String title;
  myappbar({Key key, this.title}) : super(key: key);
  @override
  State<myappbar> createState() {
    return _myappbar();
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConfig.appbar_height);
}

class _myappbar extends State<myappbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      actions: <Widget>[],
    );
  }
}
