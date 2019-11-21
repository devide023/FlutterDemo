import 'package:sqflite/sqflite.dart';

class InitDataBase {
  static CreateTable_LoginInfo_v1(Batch batch) {
    batch.execute("drop table if exists sys_login_info");
    String sql = '''
    create table sys_login_info (
      id integer primary key autoincrement,
      userid integer,
      usercode text,
      username text,
      userpwd text,
      orgid integer,
      depid integer
    );
    ''';
    batch.execute(sql);
  }

  static CreateTable_SysUser_v1(Batch batch) async {
    batch.execute("DROP TABLE IF EXISTS sys_user");
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
    await batch.execute(sql);
  }

  static CreateTable_SysOrganize_v1(Batch batch) async {
    batch.execute("drop table if exists sys_organize");
    String sql = '''
    create table sys_organize(
      id integer primary key autoincrement,
      nodeid integer,
      nodepid integer,
      title text,
      nodecode text,
      nodetype text,
      status integer
    );
    ''';
    await batch.execute(sql);
  }

  static CreateTable_SysRole_v1(Batch batch) async {
    batch.execute("drop table if exists sys_role");
    String sql = '''
    create table sys_role(
      id integer primary key autoincrement,
      roleid integer,
      title text,
      note text,
      status integer
    );
    ''';
    await batch.execute(sql);
  }

  static CreateTable_SysMenu_v1(Batch batch) async {
    batch.execute("drop table if exists sys_menu");
    String sql = '''
    create table sys_menu(
      id integer primary key autoincrement,
      menuid integer,
      menupid integer,
      menucode text,
      title text,
      note text,
      status integer,
      menutype text
    );
    ''';
    await batch.execute(sql);
  }
}
