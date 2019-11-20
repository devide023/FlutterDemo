import 'package:flutterproject/entitys/userentity.dart';
import 'package:flutterproject/route/application.dart';

class Userdao {
  static Future<int> SaveUserInfo(Map<String, dynamic> user) async {
    var db = await Application.appdb;
    print("====sys_user===${user}");
    await db.transaction((trx) async {
      trx.rawDelete("delete from sys_user ");
      var result = await trx.rawInsert('''insert into sys_user(status,
     usercode, 
     username, 
     userpwd, 
     headimg, 
     tel, 
     phone, 
     address, 
     birthdate, 
     sex, 
     addtime, 
     userid)  VALUES (?,?,?,?,?,?,?,?,?,?,?,?)''', [
        user['status'] ?? 1,
        user['usercode'],
        user['username'] ?? '',
        user['userpwd'],
        user['headimg'] ?? '',
        user['tel'] ?? '',
        user['phone'] ?? '',
        user['address'] ?? '',
        user['birthdate'] ?? '',
        user['sex'] ?? 1,
        user['addtime'],
        user['id'] ?? 0
      ]);

      return result;
    });
  }

  static Future<UserModel> GetUserInfo(int userid) async {
    var db = await Application.appdb;
    var list =
        await db.rawQuery("select * from sys_user where userid =?", [userid]);
    return list.length > 0 ? UserModel.fromJson(list.first) : UserModel();
  }
}
