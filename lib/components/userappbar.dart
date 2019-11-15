import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/pages/UserMgr/SearchBarDelegate.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:flutterproject/route/application.dart';
import 'package:provide/provide.dart';

class userappbar extends StatefulWidget with PreferredSizeWidget {
  String title;
  userappbar({
    Key key,
    this.title,
  }) : super(key: key);
  @override
  State<userappbar> createState() {
    return _userappbar();
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConfig.appbar_height);
}

class _userappbar extends State<userappbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<MainProvide>(
      builder: (context, child, model) {
        return AppBar(
          leading: IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //   return AddUser();
              // }));
              Application.router.navigateTo(context, '/user/add');
            },
          ),
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              },
            )
          ],
        );
      },
    );
  }
}
