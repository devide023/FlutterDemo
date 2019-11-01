import 'package:flutter/material.dart';
import 'package:flutterproject/pages/HomePage.dart';
import 'package:flutterproject/pages/Login.dart';
import 'package:flutterproject/providers/mainprovide.dart';
import 'package:scoped_model/scoped_model.dart';
import 'config/config.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return new _MyApp();
  }
  // This widget is the root of your application.

}

class _MyApp extends State<MyApp> {
  var mainprovide = MainProvide();
  var router = Router();
  void defineRoutes() {
    this.router.define("/", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return HomePage();
    }));
  }

  @override
  void initState() {
    super.initState();
    defineRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainProvide>(
      model: mainprovide,
      child: MaterialApp(
        title: AppConfig.str_Appname,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: Login(),
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
      ),
    );
  }
}
