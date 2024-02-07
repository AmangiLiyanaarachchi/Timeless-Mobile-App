class ColorModel {
  final String uid;
  final String title;
  final String hexcode;

  ColorModel(this.uid, this.title, this.hexcode);

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'hexcode': hexcode,
    };
  }

  ColorModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        title = map['title'],
        hexcode = map['hexcode'];
}
