import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterproject/config/config.dart';
import 'package:flutterproject/services/HomeService.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProductListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _productstate();
  }
}

class _productstate extends State<StatefulWidget>
    with AutomaticKeepAliveClientMixin {
  List navlist;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeService.Homedata(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          print("ressult--->${snapshot.data}");
          var result = jsonDecode(snapshot.data.toString());
          navlist = (result['categorydata'] as List).cast();
          var swiperlist = (result['swiperdata'] as List).cast();
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                myswiper(
                  swiperlist: swiperlist,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: navitem(
                    list: navlist,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text("暂无数据"),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class myswiper extends StatelessWidget {
  List swiperlist;
  myswiper({Key key, this.swiperlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setHeight(750.0),
      height: ScreenUtil().setHeight(200.0),
      child: Swiper(
        autoplay: true,
        itemCount: swiperlist.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            AppConfig.str_imgurl + swiperlist[index],
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

class navitem extends StatelessWidget {
  List list;
  navitem({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(330.0),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: GridView.count(
        crossAxisCount: 5,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 4,
        physics: NeverScrollableScrollPhysics(),
        children: list.map((f) {
          return Container(
            width: ScreenUtil().setWidth(150.0),
            height: ScreenUtil().setHeight(200.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        AppConfig.str_imgurl + f['img'].toString()),
                  ),
                  onTap: () {
                    print(f['title']);
                  },
                ),
                Text(f['title']),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
