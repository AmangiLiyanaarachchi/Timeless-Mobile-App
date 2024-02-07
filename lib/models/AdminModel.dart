class AdminModel {
  late String uid;
  late String fullname;
  late String email;
  late String profilepic;
  late String token;

  AdminModel({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.profilepic,
    required this.token,
  });

  AdminModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
    token = map['token'];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
      "token": token,
    };
  }
}
