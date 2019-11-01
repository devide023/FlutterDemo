import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/pages/HomePage.dart';

class productappbar extends StatefulWidget with PreferredSizeWidget {
  String title;
  productappbar({Key key, this.title}) : super(key: key);
  @override
  State<productappbar> createState() {
    return _productappbar();
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConfig.appbar_height);
}

class _productappbar extends State<productappbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {},
      ),
      title: Text(widget.title),
      centerTitle: true,
      actions: <Widget>[],
    );
  }
}
