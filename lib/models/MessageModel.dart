class MessageModel {
  late String id;
  late String text;
  late String sender;
  late DateTime sentOn;
  late String img;
  late bool isRead;

  MessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.sentOn,
    required this.img,
    required this.isRead,
  });

  MessageModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    text = map['text'];
    sender = map['sender'];
    sentOn = map['sentOn'].toDate();
    img = map['img'];
    isRead = map['isRead'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'sender': sender,
      'sentOn': sentOn,
      'img': img,
      'isRead': isRead,
    };
  }
}
