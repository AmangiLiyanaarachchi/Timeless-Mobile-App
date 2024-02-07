class ProductModel {
  //id
  late String uid;
  late String productname;
  late int quantity;
  late int price;
  late List productimage;
  late List availablecolors;
  late String sku;
  late List size;
  late String catId;
  late String brand;
  DateTime? createdOn;

  ProductModel({
    required this.uid,
    required this.productname,
    required this.quantity,
    required this.price,
    required this.productimage,
    required this.availablecolors,
    required this.size,
    required this.sku,
    required this.brand,
    required this.catId,
    this.createdOn,
  });

  ProductModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    productname = map["productname"];
    quantity = map["quantity"];
    price = map["price"];
    productimage = map["profilepic"];
    availablecolors = map["availablecolors"];
    catId = map["catId"];
    sku = map["sku"];
    size = map["size"];
    brand = map["brand"];
    createdOn = map["createdOn"].toDate();
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "productname": productname,
      "quantity": quantity,
      "price": price,
      "profilepic": productimage,
      "availablecolors": availablecolors,
      "catId": catId,
      "sku": sku,
      "size": size,
      "brand": brand,
      "createdOn": createdOn,
    };
  }
}