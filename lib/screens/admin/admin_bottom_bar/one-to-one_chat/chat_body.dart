import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../controllers/call_controllers.dart';
import '../../../../Constants/color_constants.dart';
import '../../../../Constants/font_styles.dart';
import '../../../../constants/firebase_consts.dart';
import '../../../../models/ChatRoomModel.dart';
import '../../../../models/MessageModel.dart';
import '../../../../models/UserModel.dart';
import '../../../../utils/space_values.dart';
import '../../../bottom_bar/notifications_screen.dart';
import '../Donations.dart';
import 'chatroom.dart';

class ChatBodyScreen extends StatefulWidget {
  const ChatBodyScreen({super.key});

  @override
  State<ChatBodyScreen> createState() => _ChatBodyScreenState();
}

class _ChatBodyScreenState extends State<ChatBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 10.w,
        leading: InkWell(
            onTap: () {
              Get.to(Donations());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 3.0.w),
              child: Image.asset(
                "assets/images/donate1.png",
                color: ColorConstants.primaryColor,
              ),
            )),
        title: Text(
          "Messages",
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.0.w),
            child: InkWell(
                onTap: () {
                  Get.to(NotificationsScreen());
                },
                child: Icon(
                  Icons.notifications,
                  color: ColorConstants.primaryColor,
                  size: 22.sp,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, bottom: 1.h),
                  child: Text("All the messages from customers",
                      style: FontStyles.blackBodyText),
                )),
            StreamBuilder(
                stream: firestore
                    .collection("chatroom")
                    .where("participants.${auth.currentUser!.uid}",
                        isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ChatRoomModel> allChats = [];
                    for (var doc in snapshot.data!.docs) {
                      allChats.add(ChatRoomModel.fromMap(doc.data()));
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allChats.length,
                        itemBuilder: (ctx, index) {
                          String targetUid = allChats[index]
                              .participants
                              .keys
                              .where((element) =>
                                  element != adminId) //change admin id
                              .toString()
                              .replaceAll('(', '')
                              .replaceAll(')', '');
                          return StreamBuilder(
                              stream: firestore
                                  .collection("Customers")
                                  .doc(targetUid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox.shrink();
                                } else {
                                  if (snapshot.data!.exists) {
                                    UserModel userModel = UserModel.fromMap(
                                        snapshot.data!.data()
                                            as Map<String, dynamic>);
                                    return StreamBuilder(
                                        stream: firestore
                                            .collection("chatroom")
                                            .doc(allChats[index].chatroomid)
                                            .collection("messages")
                                            .orderBy('sentOn', descending: true)
                                            .limit(1)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const SizedBox.shrink();
                                          } else {
                                            if (snapshot
                                                .data!.docs.isNotEmpty) {
                                              MessageModel lastMsg =
                                                  MessageModel.fromMap(snapshot
                                                      .data!.docs[0]
                                                      .data());
                                              return ListTile(
                                                onTap: () async {
                                                  ChatRoomModel? chatroom =
                                                      await chatController
                                                          .getChatroom(
                                                              userModel.uid);
                                                  chatController.name.value =
                                                      userModel.fullname;
                                                  chatController.img.value =
                                                      userModel.profilepic;
                                                  chatController.uid.value =
                                                      userModel.uid;
                                                  chatController
                                                          .chatroomId.value =
                                                      chatroom?.chatroomid ??
                                                          "";
                                                  chatController.token.value =
                                                      userModel.token;

                                                  await chatController
                                                      .updateStatus(
                                                          chatroom!.chatroomid);
                                                  Get.to(ChatroomScreen());
                                                },
                                                leading:
                                                    userModel.profilepic.isEmpty
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                const AssetImage(
                                                                    "assets/images/user.jpg"),
                                                            radius: 1.h,
                                                          )
                                                        : CircleAvatar(
                                                            radius: 3.h,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    userModel
                                                                        .profilepic),
                                                          ),
                                                title: Text(
                                                  userModel.fullname,
                                                  style: FontStyles
                                                      .boldBlackBodyText,
                                                ),
                                                subtitle:
                                                    lastMsg.text.isNotEmpty
                                                        ? Text(
                                                            lastMsg.text,
                                                            maxLines: 1,
                                                            style: FontStyles
                                                                .smallBlackBodyText,
                                                          )
                                                        : Row(children: [
                                                            Icon(
                                                              Icons.camera_alt,
                                                              color: Colors.grey
                                                                  .shade400,
                                                              size: 2.h,
                                                            ),
                                                            Spaces.x1,
                                                            Text(
                                                              "Image",
                                                              style: FontStyles
                                                                  .smallBlackBodyText,
                                                            ),
                                                          ]),
                                                trailing: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    StreamBuilder(
                                                        stream: firestore
                                                            .collection(
                                                                "chatroom")
                                                            .doc(allChats[index]
                                                                .chatroomid)
                                                            .collection(
                                                                "messages")
                                                            .where("isRead",
                                                                isEqualTo:
                                                                    false)
                                                            .where("sender",
                                                                isNotEqualTo: auth
                                                                    .currentUser!
                                                                    .uid)
                                                            .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            if (snapshot
                                                                .data!
                                                                .docs
                                                                .isNotEmpty) {
                                                              print(
                                                                  "check found somethin ${snapshot.data!.docs.isNotEmpty}");

                                                              return CircleAvatar(
                                                                radius: 0.7.h,
                                                                backgroundColor:
                                                                    Colors
                                                                        .lightGreen,
                                                              );
                                                            } else {
                                                              return const SizedBox
                                                                  .shrink();
                                                            }
                                                          }
                                                          return const SizedBox
                                                              .shrink();
                                                        }),
                                                    Spaces.y1,
                                                    Text(
                                                      lastMsg.sentOn.day
                                                              .isEqual(
                                                                  DateTime.now()
                                                                      .day)
                                                          ? "${lastMsg.sentOn.hour.toString().padLeft(2, '0')}:${lastMsg.sentOn.minute.toString().padLeft(2, '0')}"
                                                          : lastMsg.sentOn.day.isEqual(
                                                                  DateTime.now()
                                                                          .day -
                                                                      1)
                                                              ? "Yesterday"
                                                              : "${lastMsg.sentOn.day.toString().padLeft(2, '0')}/${lastMsg.sentOn.month.toString().padLeft(2, '0')}/${lastMsg.sentOn.year.toString().padLeft(2, '0')}",
                                                      style: FontStyles
                                                          .smallGreyBodyText,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else
                                              return const SizedBox.shrink();
                                          }
                                        });
                                  }
                                }
                                return const SizedBox.shrink();
                              });
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.primaryColor,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
