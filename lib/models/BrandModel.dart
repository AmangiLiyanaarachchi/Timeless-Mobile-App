class BrandModel {
  late String uid;
  late String title;

  BrandModel({
    required this.uid,
    required this.title,
  });

  BrandModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    title = map["title"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "title": title,
    };
  }
}
