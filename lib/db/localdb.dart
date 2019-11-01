import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'dart:io';

class dbmanager {
  static Database db;

  static init() async {
    var databasepath = await getDatabasesPath();
    // Make sure the directory exists
    try {
      await Directory(databasepath).create(recursive: true);
    } catch (_) {}
    String path = join(databasepath, 'demo.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      String sql='''
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
      print("sql:$sql");
      database.execute(sql);
      database.rawInsert("insert into sys_user (id,usercode,username) values(9,'001','admin')");
    });
  }

  static Future<Database> getcurrentdb() async {
    if (db == null) {
      await init();
    }
    return db;
  }

   static istabelexsit(String tablename) async {
    await getcurrentdb();
    String sql =
        "select * from sqlite_master where type='table' and name='$tablename'";
    var ret = await db.rawQuery(sql);
    return ret != null && ret.length > 0;
  }

  static insert(String table, Map<String, dynamic> values) async {
      var mydb = await getcurrentdb();
      return mydb.insert(table, values);
  }

  static rawinsert(String sql,List<dynamic> arguments) async{
    var databasepath = await getDatabasesPath();
    String sql='''
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
    // Make sure the directory exists
    try {
      await Directory(databasepath).create(recursive: true);
      String p = join(databasepath, 'demo.db');
      Database mydb = await openDatabase(p,
      version: 1,
        onCreate: (Database database, int version) async{
          database.execute(sql);
          database.rawInsert("insert into sys_user (id,usercode,username) values(9,'001','admin')");
        }
      );
    } catch (_) {}

  }

  static close() {
    db?.close();
    db = null;
  }
}
