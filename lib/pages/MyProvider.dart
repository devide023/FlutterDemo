import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/pages/Page1.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:flutterproject/route/application.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:flutterproject/services/UserStream.dart';
import 'package:provider/provider.dart';

class MyProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Consumer<SearchProvide>(
              builder: (context, model, child) {
                return RaisedButton(
                  onPressed: () {
                    model.GetPlaceNo();
                  },
                  child: Text("获取值"),
                );
              },
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Page1();
                  },
                ));
              },
              child: Text("展示值"),
            ),
            Consumer<List<UserModel>>(
              builder: (context, m, child) {
                return RaisedButton(
                  onPressed: () async {
                    var l = await UserService().allusers();
                    Application.streamctrl.sink.add(l);
                  },
                  child: Text("清除"),
                );
              },
            ),
            Expanded(
              child: Consumer<List<UserModel>>(
                builder: (context, model, child) {
                  return model != null
                      ? ListView.builder(
                          itemCount: model.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(model[index].username),
                            );
                          },
                        )
                      : Container(
                          child: child,
                        );
                },
                child: Container(
                  child: Text("努力加载中……"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
