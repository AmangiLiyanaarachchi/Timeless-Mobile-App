class CategoryModel {
  late String uid;
  late String title;
  late String imgUrl;
  late bool enabled;

  CategoryModel({
    required this.uid,
    required this.title,
    required this.imgUrl,
    required this.enabled,
  });

  CategoryModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    title = map["title"];
    imgUrl = map["imgUrl"];
    enabled = map["enabled"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "title": title,
      "imgUrl": imgUrl,
      "enabled": enabled,
    };
  }
}
