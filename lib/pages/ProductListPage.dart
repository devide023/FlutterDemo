import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/model/UserModel.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _productstate();
  }
}

class _productstate extends State<StatefulWidget>
    with AutomaticKeepAliveClientMixin {
  Future getdata() async {
    try {
      final Response res = await UserService().list();
      print(res.data);
      if (res.statusCode == 200) {
        print("------------");
        print(json.decode(res.data));
        var list = json.decode(res.data).map<UserModel>((item) {
          return UserModel.fromJson(item);
        }).toList();
        return list;
      } else {
        throw Exception('statusCode:${res.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainProvide>(
      builder: (context, child, provide) {
        return FutureBuilder(
          future: getdata(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapShot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapShot.data[index].username),
                    leading: CircleAvatar(
                      child: Text(snapShot.data[index].id.toString()),
                      backgroundColor: Colors.blue,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      print(snapShot.data[index].username);
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
