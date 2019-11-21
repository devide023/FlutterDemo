import 'package:sqflite/sqflite.dart';

class Dbmanager {
  static Future<List<Map>> sqlite_tabeles(Database db) async {
    String sql = "select * from sqlite_master where type='table'";
    var list = await db.rawQuery(sql);
    for(var item in list){
      print("item>>>>>>${item}");
    }
    return list;
  }
  static sqlite_table_describe(Database db,String tablename) async {
    String sql = "pragma table_info ($tablename)";
    return await db.rawQuery(sql);
  }
}
