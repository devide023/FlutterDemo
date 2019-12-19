import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterproject/db/DatabaseHelper.dart';
import 'package:flutterproject/db/userdao.dart';
import 'package:flutterproject/pages/HomePage.dart';
import 'package:flutterproject/pages/Login.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:flutterproject/providers/myprovide.dart';
import 'package:flutterproject/providers/searchprovide.dart';
import 'package:flutterproject/providers/userprovide.dart';
import 'package:flutterproject/route/application.dart';
import 'package:flutterproject/route/routes.dart';
import 'package:provide/provide.dart';
import 'config/config.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  final providers = Providers();
  providers
    ..provide(Provider.value(MainProvide()))
    ..provide(Provider.value(MyProvide()))
    ..provide(Provider.value(SearchProvide()))
    ..provide(Provider.value(UserProvide()));
  runApp(ProviderNode(
    providers: providers,
    child: MyApp(),
  ));
  // if (Platform.isAndroid) {
  //   // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
  //   SystemUiOverlayStyle systemUiOverlayStyle =
  //       SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return new _MyApp();
  }
// This widget is the root of your application.

}

class _MyApp extends State<MyApp> {
  var router = Router();
  Future<bool> _initfuture;
  @override
  void initState() {
    routeconfig.configureRoutes(router);
    Application.router = router;
    Application.appdb = DatabaseHelper().initDb();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initfuture = Userdao.islogined(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initfuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: AppConfig.str_Appname,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            home: snapshot.data ? HomePage() : Login(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: router.generator,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('zh', 'CH'),
              const Locale('en', 'US'),
            ],
          );
        } else {
          return Material(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepOrange,
                valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
              ),
            ),
          );
        }
      },
    );
  }
}
