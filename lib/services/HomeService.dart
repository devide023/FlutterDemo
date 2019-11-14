import 'package:flutterproject/http/request.dart';

class HomeService {
  static Future Homedata() async {
    return await request().instance.get('/index/data');
  }
}
