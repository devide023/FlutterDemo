import 'package:fluro/fluro.dart';
import 'package:flutterproject/entitys/userentity.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';
class Application {
  static Router router;
  static Future<Database> appdb;
  static StreamController<List<UserModel>> streamctrl=StreamController.broadcast();
  static int userid=0;
}
