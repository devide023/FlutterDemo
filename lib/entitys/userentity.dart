class userentity {
  int _code;
  String _msg;
  List<UserModel> _userlist;

  userentity({int code, String msg, List<UserModel> userlist}) {
    this._code = code;
    this._msg = msg;
    this._userlist = userlist;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get msg => _msg;
  set msg(String msg) => _msg = msg;
  List<UserModel> get userlist => _userlist;
  set userlist(List<UserModel> userlist) => _userlist = userlist;

  userentity.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['userlist'] != null) {
      _userlist = new List<UserModel>();
      json['userlist'].forEach((v) {
        _userlist.add(new UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['msg'] = this._msg;
    if (this._userlist != null) {
      data['userlist'] = this._userlist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModel {
  int _id;
  String _usercode;
  String _username;
  String _userpwd;
  int _sex;
  String _tel;
  String _phone;
  String _address;
  String _birthdate;
  int _status;
  String _headimg;

  UserModel(
      {int id,
      String usercode,
      String username,
      String userpwd,
      int sex,
      String tel,
      String phone,
      String address,
      String birthdate,
      int status,
      String headimg}) {
    this._id = id;
    this._usercode = usercode;
    this._username = username;
    this._userpwd = userpwd;
    this._sex = sex;
    this._tel = tel;
    this._phone = phone;
    this._address = address;
    this._birthdate = birthdate;
    this._status = status;
    this._headimg = headimg;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get usercode => _usercode;
  set usercode(String usercode) => _usercode = usercode;
  String get username => _username;
  set username(String username) => _username = username;
  String get userpwd => _userpwd;
  set userpwd(String userpwd) => _userpwd = userpwd;
  int get sex => _sex;
  set sex(int sex) => _sex = sex;
  String get tel => _tel;
  set tel(String tel) => _tel = tel;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get address => _address;
  set address(String address) => _address = address;
  String get birthdate => _birthdate;
  set birthdate(String birthdate) => _birthdate = birthdate;
  int get status => _status;
  set status(int status) => _status = status;
  String get headimg => _headimg;
  set headimg(String headimg) => _headimg = headimg;

  UserModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _usercode = json['usercode'];
    _username = json['username'];
    _userpwd = json['userpwd'];
    _sex = json['sex'];
    _tel = json['tel'];
    _phone = json['phone'];
    _address = json['address'];
    _birthdate = json['birthdate'];
    _status = json['status'];
    _headimg = json['headimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['usercode'] = this._usercode;
    data['username'] = this._username;
    data['userpwd'] = this._userpwd;
    data['sex'] = this._sex;
    data['tel'] = this._tel;
    data['phone'] = this._phone;
    data['address'] = this._address;
    data['birthdate'] = this._birthdate;
    data['status'] = this._status;
    data['headimg'] = this._headimg;
    return data;
  }
}
