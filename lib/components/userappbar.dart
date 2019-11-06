import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/pages/HomePage.dart';
import 'package:flutterproject/pages/UserMgr/AddUser.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:scoped_model/scoped_model.dart';

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
  MainProvide mainprovide;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    mainprovide = ScopedModel.of<MainProvide>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainProvide>(
      builder: (context, child, model) {
        return AppBar(
          leading: IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //   return AddUser();
              // }));
              model.mainrouter.navigateTo(context, '/user/add');
            },
          ),
          title: Text(widget.title),
          centerTitle: true,
        );
      },
    );
  }
}
