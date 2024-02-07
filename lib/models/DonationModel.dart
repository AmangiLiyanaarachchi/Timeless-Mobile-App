class DonationModel {
  late String uid;
  late String donorId;
  late List prodImg;
  late String prodName;
  late String prodBrand;
  late String prodDisc;
  late String size;
  late String category;
  late String color;
  late String usedDuration;
  late String receipt;
  DateTime? createdOn;
  late String deliveryMode;

  DonationModel({
    required this.uid,
    required this.donorId,
    required this.prodImg,
    required this.prodName,
    required this.prodBrand,
    required this.prodDisc,
    required this.category,
    required this.receipt,
    required this.color,
    required this.usedDuration,
    required this.size,
    this.createdOn,
    required this.deliveryMode,
  });

  DonationModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    donorId = map["donorId"];
    prodImg = map["productImg"];
    prodName = map["productName"];
    color = map["color"];
    size = map["size"];
    category = map["category"];
    prodBrand = map["brand"];
    prodDisc = map["description"];
    receipt = map["receipt"];
    usedDuration = map["usedduration"];
    createdOn = map["createdOn"].toDate();
    deliveryMode = map["deliveryMode"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "donorId": donorId,
      "category": category,
      "productName": prodName,
      "description": prodDisc,
      "productImg": prodImg,
      "size" : size,
      "color": color,
      "brand": prodBrand,
      "receipt": receipt,
      "usedduration" : usedDuration,
      "createdOn": createdOn,
      "deliveryMode": deliveryMode
    };
  }
}
