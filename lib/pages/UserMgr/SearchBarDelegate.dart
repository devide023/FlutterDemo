import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:flutterproject/services/UserService.dart';
import 'package:flutterproject/tools/fluro_convert_util.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchBarDelegate extends SearchDelegate {
  List<UserModel> users;
  Future GetData(String keyword) async {
    var res = await UserService().Search(keyword);
    var userjson = jsonDecode(res.toString());
    users = userentity.fromJson(userjson).userlist;
    return users;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: ListTile(
            title: Text(users[index].username),
            subtitle: Text(
                "[${users[index].usercode}]  ${users[index].tel}，${users[index].phone}"),
            trailing: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(users[index].sex == 1 ? "男" : "女"),
            ),
          ),
          onTap: () {
            print(users[index].id);
            var model = ScopedModel.of<MainProvide>(context);
            var json = FluroConvertUtils.object2string(users[index]);
            print("json----$json");
            model.mainrouter.navigateTo(context, '/user/detail?userinfo=$json');
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: GetData(query),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ListView.builder(
          itemCount: (snapshot.data as List<UserModel>).length,
          itemBuilder: (context, index) {
            UserModel userobj = (snapshot.data as List<UserModel>)[index];
            return InkWell(
              child: ListTile(
                title: Text("[${userobj.usercode}]" + userobj.username),
              ),
              onTap: () {
                print(userobj.id);
                var model = ScopedModel.of<MainProvide>(context);
                var json = FluroConvertUtils.object2string(userobj);
                print("json--suggest--$json");
                model.mainrouter
                    .navigateTo(context, '/user/detail?userinfo=$json');
              },
            );
          },
        );
      },
    );
  }
}
