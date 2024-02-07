class UserModel {
  late String uid;
  late String fullname;
  late String email;
  late String profilepic;
  late List cat;
  late String token;

  UserModel({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.profilepic,
    required this.cat,
    required this.token,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];

    cat = map["category"];
    token = map["token"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
      "category": cat,
      "token": token,
    };
  }
}
