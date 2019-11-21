import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/db/userdao.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:provide/provide.dart';

class Drawer_Header_Widget extends StatefulWidget {
  Drawer_Header_Widget({Key key}) : super(key: key);

  @override
  _Drawer_Header_WidgetState createState() => _Drawer_Header_WidgetState();
}

class _Drawer_Header_WidgetState extends State<Drawer_Header_Widget> {
  @override
  Widget build(BuildContext context) {
    return Provide<UserProvide>(
      builder: (context, child, model) {
        return SliverToBoxAdapter(
          child: UserAccountsDrawerHeader(
            accountName: Text(model.userentity.username),
            accountEmail: Text(model.userentity.usercode),
            onDetailsPressed: () {},
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/image/headbg.jpg"),
                    fit: BoxFit.fill)),
            currentAccountPicture: InkWell(
              child: CircleAvatar(
                backgroundImage: NetworkImage(AppConfig.str_imgurl +
                    (model.userentity.headimg ?? "default_head.jpg")),
              ),
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text("确定要退出吗?"),
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.label_outline),
                            title: Text("退出"),
                            onTap: () async {
                              Userdao.Logout(context);
                            },
                          )
                        ],
                      );
                    });
              },
            ),
          ),
        );
      },
    );
  }
}
