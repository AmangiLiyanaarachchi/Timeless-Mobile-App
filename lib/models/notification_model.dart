class NotificationModel {
  late String uid;
  late String senderId;
  late String receiverId;
  late String message;
  late String navigationId;
  late String? productId;
  late DateTime time;

  NotificationModel({
    required this.uid,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.time,
    required this.navigationId,
     this.productId,

  });

  NotificationModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    senderId = map["senderId"];
    receiverId = map["receiverId"];
    message = map["message"];
    navigationId = map['navigationId'];
    productId = map['productId'];
    time = map["time"].toDate();
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "navigationId": navigationId,
      "productId": productId,
      "time": time,
    };
  }
}
