class CartModel {
  late String cartId;
  late String custId;
  late String prodId;
  late int prodQuant;
  late int subTot;
  late String status;
  late String size;
  late String color;

  CartModel({
    required this.cartId,
    required this.custId,
    required this.prodId,
    required this.prodQuant,
    required this.subTot,
    required this.status,
    required this.size,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'custId': custId,
      'prodId': prodId,
      'prodQuant': prodQuant,
      'subTot': subTot,
      'status': status,
      'size': size,
      'color': color,
    };
  }

  CartModel.fromMap(Map<String, dynamic> map)
      : cartId = map['cartId'],
        custId = map['custId'],
        prodId = map['prodId'],
        prodQuant = map['prodQuant'],
        subTot = map['subTot'],
        status = map['status'],
        size = map['size'],
        color = map['color'];
}
