import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/pages/UserMgr/EditUser_Page.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:scoped_model/scoped_model.dart';

class listitem extends StatefulWidget {
  UserModel userobj;
  listitem({Key key, this.userobj}) : super(key: key);
  @override
  _listitem createState() => _listitem();
}

class _listitem extends State<listitem> {
  var tempname = "default_head.jpg";
  @override
  Widget build(BuildContext context) {
    if (widget.userobj.headimg != null) {
      tempname = widget.userobj.headimg;
    }
    var model = ScopedModel.of<MainProvide>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(AppConfig.str_imgurl + tempname),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.userobj.username,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.userobj.usercode,
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 1.0),
            child: PopupMenuButton(
              onSelected: (v) {
                switch (v) {
                  case 'edit':
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   return EditUser_Page(
                    //     userobj: widget.userobj,
                    //   );
                    // }));
                    model.mainrouter.navigateTo(
                        context, '/user/edit?userid=${widget.userobj.id}');
                    break;
                  case 'del':
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("提示"),
                            content: Text("你确定要删除？"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("确定"),
                                onPressed: () {},
                              ),
                              FlatButton(
                                child: Text("取消"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                    break;
                  case 'enable':
                    break;
                }
              },
              itemBuilder: (context) {
                return <PopupMenuItem>[
                  PopupMenuItem(
                    value: 'edit',
                    child: Text("编辑"),
                  ),
                  PopupMenuItem(
                    value: 'del',
                    child: Text("删除"),
                  ),
                  PopupMenuItem(
                    value: 'enabel',
                    child: Text("启用"),
                  )
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
