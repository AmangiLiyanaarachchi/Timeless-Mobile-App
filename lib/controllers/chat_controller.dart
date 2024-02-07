import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/models/AdminModel.dart';
import '../main.dart';
import '../models/ChatRoomModel.dart';
import '../models/MessageModel.dart';
import '../utils/notification_services.dart';

class ChatController extends GetxController {
  NotificationServices notificationServices = NotificationServices();

  var name = "".obs,
      uid = "".obs,
      img = "".obs,
      chatroomId = "".obs,
      token = "".obs;
  RxBool isKeyboardVisible = false.obs;
  ChatRoomModel? chatroom;
  var groupName = TextEditingController(), groupBio = TextEditingController();

  ///both send methods are different due to the recipient id -
  ///becuase its 1-many chat from admin and
  ///may-1 from customer side and
  ///admin id is always same
  Future<ChatRoomModel?> getChatroom(String targetUid) async {
    QuerySnapshot snapshot = await firestore
        .collection("chatroom")
        .where('participants.$adminId', isEqualTo: true)
        .where('participants.$targetUid', isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      ChatRoomModel existingChatroom = ChatRoomModel.fromMap(
          snapshot.docs[0].data() as Map<String, dynamic>);
      chatroom = existingChatroom;
    } else {
      ChatRoomModel newChatroom = ChatRoomModel(
          chatroomid: uuid.v4(),
          participants: {
            adminId: true,
            targetUid: true,
          },
          lastMessage: ""); // store id of last msg

      await firestore
          .collection("chatroom")
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());
      chatroom = newChatroom;
    }

    return chatroom;
  }

  Future<ChatRoomModel?> getChatroomForCustomer() async {
    QuerySnapshot snapshot = await firestore
        .collection("chatroom")
        .where('participants.$adminId', isEqualTo: true)
        .where('participants.${auth.currentUser!.uid}', isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      ChatRoomModel existingChatroom = ChatRoomModel.fromMap(
          snapshot.docs[0].data() as Map<String, dynamic>);
      chatroom = existingChatroom;
    } else {
      ChatRoomModel newChatroom = ChatRoomModel(
          chatroomid: uuid.v4(),
          participants: {
            adminId: true,
            auth.currentUser!.uid: true,
          },
          lastMessage: ""); // store id of last msg

      await firestore
          .collection("chatroom")
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());
      chatroom = newChatroom;
    }

    return chatroom;
  }

  ///both send methods are different due to the sender id -
  ///becuase its 1-many chat from admin and
  ///may-1 from customer side and
  ///admin id is always same
  sendMessagetoAdmin(
    String message,
    String media,
  ) async {
    MessageModel messageModel = MessageModel(
        id: uuid.v4(),
        text: message,
        sender: auth.currentUser!.uid,
        sentOn: DateTime.now(),
        img: media,
        isRead: false);

    await firestore
        .collection("chatroom")
        .doc(chatroomId.value)
        .collection("messages")
        .doc(messageModel.id)
        .set(messageModel.toMap());

    var msg = message.isNotEmpty
        ? message
        : media.isNotEmpty
            ? "Image"
            : "";
    await firestore.collection("chatroom").doc(chatroomId.value).update({
      "lastMsg": msg,
    });

    notificationServices.sendNotification(
      "Timeless",
      token.value,
      message.isNotEmpty ? "You Got a Message!" : "Image",
      uid.value,
      chatroomId.value,
    );
  }

  sendMessagetoCustomer(
    String message,
    String media,
  ) async {
    MessageModel messageModel = MessageModel(
        id: uuid.v4(),
        text: message,
        sender: adminId,
        sentOn: DateTime.now(),
        img: media,
        isRead: false);

    await firestore
        .collection("chatroom")
        .doc(chatroomId.value)
        .collection("messages")
        .doc(messageModel.id)
        .set(messageModel.toMap());

    var msg = message.isNotEmpty
        ? message
        : media.isNotEmpty
            ? "Image"
            : "";
    await firestore.collection("chatroom").doc(chatroomId.value).update({
      "lastMsg": msg,
    });

    notificationServices.sendNotification(
      "Customer Support",
      token.value,
      message.isNotEmpty ? "You Got a Message!" : "Image",
      uid.value,
      chatroomId.value,
    );
  }

  updateStatus(String chatroomId) async {
    final messagesRef =
        firestore.collection("chatroom").doc(chatroomId).collection("messages");

    final messagesSnapshot = await messagesRef.get();

    for (var doc in messagesSnapshot.docs) {
      firestore
          .collection("chatroom")
          .doc(chatroomId)
          .collection("messages")
          .doc(doc['id'])
          .update({"isRead": true});
    }
  }

  getAdminData(String aid) async {
    DocumentSnapshot snapshot =
        await firestore.collection("Admins").doc(aid).get();
    if (snapshot.exists) {
      AdminModel adminModel =
          AdminModel.fromMap(snapshot.data() as Map<String, dynamic>);
      name.value = adminModel.fullname;
      img.value = adminModel.profilepic;
      uid.value = adminModel.uid;
      token.value = adminModel.token;
    }
  }
}
