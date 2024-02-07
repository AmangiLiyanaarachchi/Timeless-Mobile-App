class ChatRoomModel{
  late String chatroomid;
  late Map participants;
  late String lastMessage;

  ChatRoomModel({required this.chatroomid, required this.participants, required this.lastMessage});

  ChatRoomModel.fromMap(Map<String, dynamic>map){
    chatroomid = map["chatroomid"];
    participants = map["participants"];
    lastMessage = map["lastmessage"];
  }
    Map<String, dynamic> toMap(){
      return{
        "chatroomid": chatroomid,
        "participants": participants,
        "lastmessage": lastMessage

      };
    }
  }
