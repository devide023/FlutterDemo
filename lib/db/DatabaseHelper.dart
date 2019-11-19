import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    final dbPath = join(fileDirectory.path,'mydatabase.db');
    print("dbpath========$dbPath");
    var db = await openDatabase(dbPath,
        version: 5, onCreate: _onCreate,onUpgrade: _onUpgrade,onDowngrade: onDatabaseDowngradeDelete);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    print("===========创建数据库==============");
    String sql = '''
          CREATE TABLE sys_user (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            userid INTEGER,
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
            );
            
          ''';
    await db.execute(sql);
  }

  void _onUpgrade(Database db,int oldversion,int newsersion) async{
  print("oldversion=====$oldversion");
  print("newversion=====$newsersion");
  db.execute("ALTER TABLE sys_user ADD COLUMN userid INTEGER ");
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
