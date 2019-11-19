import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    final fileDirectory = await getApplicationDocumentsDirectory();
    final dbPath = fileDirectory.path;
    var db = await openDatabase(dbPath + '/mydatabase.db',
        version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    String sql = '''
          CREATE TABLE sys_user (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            status INTEGER, 
            usercode TEXT, 
            username TEXT, 
            userpwd TEXT, 
            headimg TEXT, 
            tel TEXT, 
            phone TEXT, 
            address TEXT, 
            birthdate NUMERIC, 
            sex INTEGER, 
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
