class Usernav {
  String title;
  String icon;
  bool isopen;
  List<ChildListBean> child;

  Usernav({this.title, this.icon, this.isopen, this.child});

  Usernav.fromJson(Map<String, dynamic> json) {    
    this.title = json['title'];
    this.icon = json['icon'];
    this.isopen = json['isopen'];
    this.child = (json['child'] as List)!=null?(json['child'] as List).map((i) => ChildListBean.fromJson(i)).toList():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['isopen'] = this.isopen;
    data['child'] = this.child != null?this.child.map((i) => i.toJson()).toList():null;
    return data;
  }

}

class ChildListBean {
  String title;
  String icon;

  ChildListBean({this.title, this.icon});

  ChildListBean.fromJson(Map<String, dynamic> json) {    
    this.title = json['title'];
    this.icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    return data;
  }
}
