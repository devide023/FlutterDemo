class useraction {
  int _code;
  String _msg;
  List<Actions> _actions;

  useraction({int code, String msg, List<Actions> actions}) {
    this._code = code;
    this._msg = msg;
    this._actions = actions;
  }

  int get code => _code;
  set code(int code) => _code = code;
  String get msg => _msg;
  set msg(String msg) => _msg = msg;
  List<Actions> get actions => _actions;
  set actions(List<Actions> actions) => _actions = actions;

  useraction.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['actions'] != null) {
      _actions = new List<Actions>();
      json['actions'].forEach((v) {
        _actions.add(new Actions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['msg'] = this._msg;
    if (this._actions != null) {
      data['actions'] = this._actions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Actions {
  String _title;
  String _code;
  String _icon;

  Actions({String title, String code, String icon}) {
    this._title = title;
    this._code = code;
    this._icon = icon;
  }

  String get title => _title;
  set title(String title) => _title = title;
  String get code => _code;
  set code(String code) => _code = code;
  String get icon => _icon;
  set icon(String icon) => _icon = icon;

  Actions.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _code = json['code'];
    _icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['code'] = this._code;
    data['icon'] = this._icon;
    return data;
  }
}
