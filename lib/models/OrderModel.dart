class OrderModel {
  late String uid;
  late List cartIds;
  late String orderedBy;
  late int subTotal;
  late int totalBill;
  late String recepName;
  late String recepAddr;
  late String recepPhone;
  late String orderStatus;
  late DateTime orderDate;

  OrderModel({
    required this.uid,
    required this.orderDate,
    required this.orderedBy,
    required this.cartIds,
    required this.recepAddr,
    required this.recepName,
    required this.subTotal,
    required this.recepPhone,
    required this.totalBill,
    required this.orderStatus,
  });

  // Named constructor to create an OrderModel instance from a map
  OrderModel.fromMap(Map<String, dynamic> map) {
    cartIds = map['cartId'];
    orderedBy = map['custId'];
    recepAddr = map['addr'];
    recepName = map['name'];
    recepPhone = map['phone'];
    subTotal = map['subTot'];
    uid = map['uid'];
    orderDate = map['orderDate'].toDate();
    totalBill = map['totalBill'];
    orderStatus = map['orderStatus'];
  }

  // Method to convert an OrderModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'cartId': cartIds,
      'custId': orderedBy,
      'addr': recepAddr,
      'name': recepName,
      'phone': recepPhone,
      'subTot': subTotal,
      'uid': uid,
      'orderDate': orderDate,
      'totalBill': totalBill,
      'orderStatus': orderStatus,
    };
  }
}
