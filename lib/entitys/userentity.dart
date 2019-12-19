class UserModel {
  int _id;
  String _usercode;
  int _status;
  int _sex;
  String _username;
  String _userpwd;
  String _laravelpwd;
  String _rkey;
  int _companyId;
  int _departmentId;
  String _position;
  int _loginWay;
  String _loginDate;
  String _logoutDate;
  String _addTime;
  String _modifyDate;
  String _address;
  String _tel;
  String _birthday;
  String _headimg;
  String _phone;

  UserModel(
      {int id,
      String usercode,
      int status,
      int sex,
      String username,
      String userpwd,
      String laravelpwd,
      String rkey,
      int companyId,
      int departmentId,
      String position,
      int loginWay,
      String loginDate,
      String logoutDate,
      String modifyDate,
      String address,
      String tel,
      String birthday,
      String headimg,
      String phone}) {
    this._id = id;
    this._usercode = usercode;
    this._status = status;
    this._sex = sex;
    this._username = username;
    this._userpwd = userpwd;
    this._laravelpwd = laravelpwd;
    this._rkey = rkey;
    this._companyId = companyId;
    this._departmentId = departmentId;
    this._position = position;
    this._loginWay = loginWay;
    this._loginDate = loginDate;
    this._logoutDate = logoutDate;
    this._modifyDate = modifyDate;
    this._address = address;
    this._tel = tel;
    this._birthday = birthday;
    this._headimg = headimg;
    this._phone = phone;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get usercode => _usercode;
  set usercode(String usercode) => _usercode = usercode;
  int get status => _status;
  set status(int status) => _status = status;
  int get sex => _sex;
  set sex(int sex) => _sex = sex;
  String get username => _username;
  set username(String username) => _username = username;
  String get userpwd => _userpwd;
  set userpwd(String userpwd) => _userpwd = userpwd;
  String get laravelpwd => _laravelpwd;
  set laravelpwd(String laravelpwd) => _laravelpwd = laravelpwd;
  String get rkey => _rkey;
  set rkey(String rkey) => _rkey = rkey;
  int get companyId => _companyId;
  set companyId(int companyId) => _companyId = companyId;
  int get departmentId => _departmentId;
  set departmentId(int departmentId) => _departmentId = departmentId;
  String get position => _position;
  set position(String position) => _position = position;
  int get loginWay => _loginWay;
  set loginWay(int loginWay) => _loginWay = loginWay;
  String get loginDate => _loginDate;
  set loginDate(Null loginDate) => _loginDate = loginDate;
  String get logoutDate => _logoutDate;
  set logoutDate(String logoutDate) => _logoutDate = logoutDate;
  String get addTime => _addTime;
  set addTime(Null addTime) => _addTime = addTime;
  String get modifyDate => _modifyDate;
  set modifyDate(String modifyDate) => _modifyDate = modifyDate;
  String get address => _address;
  set address(String address) => _address = address;
  String get tel => _tel;
  set tel(String tel) => _tel = tel;
  String get birthday => _birthday;
  set birthday(String birthday) => _birthday = birthday;
  String get headimg => _headimg;
  set headimg(String headimg) => _headimg = headimg;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;

  UserModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _usercode = json['usercode'];
    _status = json['status'];
    _sex = json['sex'];
    _username = json['username'];
    _userpwd = json['userpwd'];
    _laravelpwd = json['laravelpwd'];
    _rkey = json['rkey'];
    _companyId = json['company_id'];
    _departmentId = json['department_id'];
    _position = json['position'];
    _loginWay = json['login_way'];
    _loginDate = json['login_date'];
    _logoutDate = json['logout_date'];
    _modifyDate = json['modify_date'];
    _address = json['address'];
    _tel = json['tel'];
    _birthday = json['birthday'];
    _headimg = json['headimg'];
    _phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['usercode'] = this._usercode;
    data['status'] = this._status;
    data['sex'] = this._sex;
    data['username'] = this._username;
    data['userpwd'] = this._userpwd;
    data['laravelpwd'] = this._laravelpwd;
    data['rkey'] = this._rkey;
    data['company_id'] = this._companyId;
    data['department_id'] = this._departmentId;
    data['position'] = this._position;
    data['login_way'] = this._loginWay;
    data['login_date'] = this._loginDate;
    data['logout_date'] = this._logoutDate;
    data['modify_date'] = this._modifyDate;
    data['address'] = this._address;
    data['tel'] = this._tel;
    data['birthday'] = this._birthday;
    data['headimg'] = this._headimg;
    data['phone'] = this._phone;
    return data;
  }
}
