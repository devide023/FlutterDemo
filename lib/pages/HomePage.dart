import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with AutomaticKeepAliveClientMixin {
  MainProvide mainprovide;
  @override
  void initState() {
    super.initState();
    mainprovide = ScopedModel.of<MainProvide>(context);
    mainprovide.UserDrawerdata();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainProvide>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: model.mainappbars[model.index],
          body: model.mainpages[model.index],
          drawer: Container(
            color: Colors.white,
            child: ListView(
              children: model.userdrawer,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.index,
            onTap: (index) {
              model.changeIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text(AppConfig.str_userlist),
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
