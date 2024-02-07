class WishlistModel {
  late String uId;
  late String custId;
  late String prodId;

  WishlistModel({
    required this.uId,
    required this.custId,
    required this.prodId,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'custId': custId,
      'prodId': prodId,
    };
  }

  WishlistModel.fromMap(Map<String, dynamic> map)
      : uId = map['uId'],
        custId = map['custId'],
        prodId = map['prodId'];
}
