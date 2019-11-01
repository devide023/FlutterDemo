import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mydata.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    String sql = '''
          CREATE TABLE sys_user (
            id INTEGER, 
            status INTEGER, 
            usercode TEXT, 
            username TEXT, 
            userpwd TEXT, 
            headimg TEXT, 
            tel text, 
            phone text, 
            address text, 
            birthdate NUMERIC, 
            sex integer, 
            addtime NUMERIC
            )
          ''';
    await db.execute(sql);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
