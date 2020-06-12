class User {
  String uid;
  String email;
  String token;

  User({this.uid, this.email, this.token});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
