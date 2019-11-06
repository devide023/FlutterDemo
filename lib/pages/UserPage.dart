import 'package:flutter/material.dart' show StatelessWidget;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterproject/components/listitem.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:scoped_model/scoped_model.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPage createState() {
    return _UserPage();
  }
}

class _UserPage extends State<UserPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainProvide>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.UserList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var list = userentity.fromJson(snapshot.data).userlist;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return listitem(
                    userobj: list[index],
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
