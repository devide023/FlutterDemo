import 'dart:async';
import 'package:flutterproject/db/initdatabase/InitDataBase.dart';
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

  Future<Database> initDb() async {
    final fileDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(fileDirectory.path, 'mydatabase.db');
    print("dbpath========$dbPath");
    var db = await openDatabase(dbPath,
        version: 3,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onDowngrade: onDatabaseDowngradeDelete);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    var batch = db.batch();
    print("===========创建数据库==============");
    InitDataBase.CreateTable_SysUser_v1(batch);
    InitDataBase.CreateTable_SysRole_v1(batch);
    InitDataBase.CreateTable_SysMenu_v1(batch);
    InitDataBase.CreateTable_SysOrganize_v1(batch);
    batch.commit();
  }

  void _onUpgrade(Database db, int oldversion, int newsersion) async {
    print("===========迁移数据库,原版本:$oldversion,新版本:$newsersion==============");
    var batch = db.batch();
    InitDataBase.CreateTable_SysUser_v1(batch);
    InitDataBase.CreateTable_SysRole_v1(batch);
    InitDataBase.CreateTable_SysMenu_v1(batch);
    InitDataBase.CreateTable_SysOrganize_v1(batch);
    batch.commit();
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
