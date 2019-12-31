class ResponseModel {
  int _code;
  String _msg;

  ResponseModel({int code,String msg}){
    _code = code;
    _msg = msg;
  }

  int get code => _code;

  set code(int code) => _code = code;

  String get msg => _msg;

  set msg(String msg) => _msg = msg;
  ResponseModel.fromjson(Map<String,dynamic> json){
    _code = json['code'];
    _msg=json['msg'];
  }
}
