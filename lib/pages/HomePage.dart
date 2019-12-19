import 'package:flutter/material.dart';
import 'package:flutterproject/components/drawer_index.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/pages/IndexPage.dart';
import 'package:flutterproject/pages/TestPage.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:flutterproject/providers/myprovide.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'MyPage.dart';
import 'ProductListPage.dart';
import 'UserPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with AutomaticKeepAliveClientMixin {
  UserProvide userprovide;
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
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(context)
      ..setSp(12.0);
    return ProvideMulti(
      requestedValues: [MyProvide, MainProvide, UserProvide],
      builder: (context, child, vals) {
        return Scaffold(
          drawer: DrawerIndex(),
          body: IndexedStack(
            index: vals.get<MyProvide>().index,
            children: [
              IndexPage(),
              ProductListPage(),
              GZXDropDownMenuTestPage()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: vals.get<MyProvide>().index,
            onTap: (index) {
              vals.get<MyProvide>().changeIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(AppConfig.str_home),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text(AppConfig.str_productlist),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(AppConfig.str_my),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
