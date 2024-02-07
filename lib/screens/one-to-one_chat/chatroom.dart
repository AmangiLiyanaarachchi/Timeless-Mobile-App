import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import '../../../../Constants/color_constants.dart';
import '../../../../Constants/font_styles.dart';
import '../../../../controllers/call_controllers.dart';
import '../../../../models/MessageModel.dart';
import '../../../../utils/space_values.dart';
import '../../../../utils/utility_const.dart';
import '../../models/ChatRoomModel.dart';
import '../../widgets/custom_drawer.dart';
import '../bottom_bar/notifications_screen.dart';

class CustChatroomScreen extends StatefulWidget {
  const CustChatroomScreen({super.key});

  @override
  State<CustChatroomScreen> createState() => _CustChatroomScreenState();
}

class _CustChatroomScreenState extends State<CustChatroomScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    ChatRoomModel? chatroom = await chatController
        .getChatroomForCustomer(); //keep same admin id - replace with original
    chatController.chatroomId.value = chatroom?.chatroomid ?? "";
    await chatController.getAdminData(adminId);
  }

  final message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          "Customer Support",
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () {
                Get.to(NotificationsScreen());
              },
              child: Icon(
                Icons.notifications,
                color: ColorConstants.primaryColor,
                size: 30,
              ),
            ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Obx(
        () => chatController.chatroomId.value.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: StreamBuilder(
                            stream: firestore
                                .collection("chatroom")
                                .doc(chatController.chatroomId.value)
                                .collection("messages")
                                .orderBy('sentOn', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.isNotEmpty) {
                                  List<MessageModel> messageList = [];
                                  for (var doc in snapshot.data!.docs) {
                                    messageList
                                        .add(MessageModel.fromMap(doc.data()));
                                  }
                                  return ListView.builder(
                                    itemCount: messageList.length,
                                    reverse: true,
                                    itemBuilder: (ctx, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                messageList[index].sender ==
                                                        auth.currentUser!.uid
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                            children: [
                                              messageList[index].sender ==
                                                      auth.currentUser!.uid
                                                  ? const SizedBox.shrink()
                                                  : Obx(
                                                      () => chatController.img
                                                              .value.isNotEmpty
                                                          ? CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      chatController
                                                                          .img
                                                                          .value),
                                                              radius: 1.h,
                                                            )
                                                          : CircleAvatar(
                                                              backgroundImage:
                                                                  const AssetImage(
                                                                      "assets/images/user.jpg"),
                                                              radius: 1.h,
                                                            ),
                                                    ),
                                              Spaces.x1,
                                              messageList[index].sender ==
                                                      auth.currentUser!.uid
                                                  ? Padding(
                                                      //for send bubble
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 1.h,
                                                      ),
                                                      child:
                                                          messageList[index]
                                                                  .text
                                                                  .isEmpty
                                                              ? ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            16.0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            16.0),
                                                                  ),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      Get.toNamed(
                                                                          '/img_view',
                                                                          arguments: {
                                                                            "name":
                                                                                "You",
                                                                            "img":
                                                                                messageList[index].img,
                                                                          });
                                                                    },
                                                                    child: Image
                                                                        .network(
                                                                      messageList[
                                                                              index]
                                                                          .img,
                                                                      width:
                                                                          60.w,
                                                                      height:
                                                                          20.h,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                )
                                                              : ChatBubble(
                                                                  elevation: 0,
                                                                  backGroundColor:
                                                                      ColorConstants
                                                                          .primaryColor,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 2,
                                                                      bottom: 5,
                                                                      left: 10,
                                                                      right:
                                                                          25),
                                                                  clipper: ChatBubbleClipper5(
                                                                      type: BubbleType
                                                                          .sendBubble),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        ConstrainedBox(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                              maxWidth: 60.w),
                                                                      child:
                                                                          Text(
                                                                        messageList[index]
                                                                            .text,
                                                                        style: FontStyles
                                                                            .whiteBodyText,
                                                                        maxLines:
                                                                            500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                    )
                                                  : Padding(
                                                      //for reciever bubble
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 1.h,
                                                      ),
                                                      child:
                                                          messageList[index]
                                                                  .text
                                                                  .isEmpty
                                                              ? ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            16.0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            16.0),
                                                                  ),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      Get.toNamed(
                                                                          '/img_view',
                                                                          arguments: {
                                                                            "name":
                                                                                chatController.name.value,
                                                                            "img":
                                                                                messageList[index].img,
                                                                          });
                                                                    },
                                                                    child: Image
                                                                        .network(
                                                                      messageList[
                                                                              index]
                                                                          .img,
                                                                      width:
                                                                          60.w,
                                                                      height:
                                                                          20.h,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                )
                                                              : ChatBubble(
                                                                  elevation: 0,
                                                                  backGroundColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 2,
                                                                      bottom: 5,
                                                                      left: 25,
                                                                      right:
                                                                          10),
                                                                  clipper: ChatBubbleClipper5(
                                                                      type: BubbleType
                                                                          .receiverBubble),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        ConstrainedBox(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                              maxWidth: 45.w),
                                                                      child:
                                                                          Text(
                                                                        messageList[index]
                                                                            .text,
                                                                        style: FontStyles
                                                                            .blackBodyText,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                    ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                messageList[index].sender ==
                                                        auth.currentUser!.uid
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                            children: [
                                              messageList[index]
                                                      .sentOn
                                                      .day
                                                      .isEqual(
                                                          DateTime.now().day)
                                                  ? Text(
                                                      "${messageList[index].sentOn.hour.toString().padLeft(2, '0')}:${messageList[index].sentOn.minute.toString().padLeft(2, '0')}",
                                                      style: FontStyles
                                                          .smallGreyBodyText
                                                          .copyWith(
                                                              fontSize: 8.sp),
                                                    )
                                                  : Text(
                                                      "${messageList[index].sentOn.day}/${messageList[index].sentOn.month}/${messageList[index].sentOn.year}",
                                                      style: FontStyles
                                                          .smallGreyBodyText
                                                          .copyWith(
                                                              fontSize: 8.sp)),
                                              Spaces.x4,
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Text("How may we help you?",
                                        style: FontStyles.blackBodyText),
                                  );
                                }
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.primaryColor,
                                ),
                              );
                            }),
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: message,
                        decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: 1.5.h, left: 2.w, right: 2.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 1.5.h,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            String imgUrl =
                                                await imagePickerController
                                                    .pickSingleImage(
                                                        ImageSource.camera);
                                            if (imgUrl.isNotEmpty) {
                                              await sendMedia(imgUrl);
                                              Get.back();
                                            } else {
                                              Get.back();

                                              showErrorSnack("Attention!",
                                                  "No media is selected");
                                            }
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                radius: 3.5.h,
                                                backgroundColor: Colors.pink,
                                                child: const Icon(
                                                  Icons.camera,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Spaces.y1,
                                              Text(
                                                "Camera",
                                                style: FontStyles.blackBodyText,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spaces.x5,
                                        GestureDetector(
                                          onTap: () async {
                                            String imgUrl =
                                                await imagePickerController
                                                    .pickSingleImage(
                                                        ImageSource.gallery);
                                            if (imgUrl.isNotEmpty) {
                                              await sendMedia(imgUrl);
                                              Get.back();
                                            } else {
                                              Get.back();

                                              showErrorSnack("Attention!",
                                                  "No media is selected");
                                            }
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircleAvatar(
                                                radius: 3.5.h,
                                                backgroundColor: Colors.purple,
                                                child: const Icon(
                                                  Icons.photo,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Spaces.y1,
                                              Text(
                                                "Gallery",
                                                style: FontStyles.blackBodyText,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spaces.y3,
                                      ]),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.attachment_outlined,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () async {
                              // print("customer val ${}");
                              await chatController.sendMessagetoAdmin(
                                message.text.trim(),
                                "",
                              );
                              message.clear();
                            },
                            child: const Icon(
                              Icons.send,
                              color: ColorConstants.primaryColor,
                            ),
                          ),
                          hintText: "Type message...",
                          border: InputBorder.none,
                        ),
                      ),
                      Spaces.y2,
                    ]),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.primaryColor,
                ),
              ),
      ),
    );
  }

  Future<void> sendMedia(String imgPath) async {
    try {
      setLoading();
      String downloadUrl =
          await imagePickerController.uploadMediatoStorage(File(imgPath));
      if (downloadUrl.isNotEmpty) {
        await chatController.sendMessagetoAdmin(
          "",
          downloadUrl,
        );
        imagePickerController.mediaPath.value = "";
        hideLoading();
      } else {
        hideLoading();
        showErrorSnack("Oops!", "Error occured");
      }
    } catch (e) {
      hideLoading();
      showErrorSnack("Oops!", "Error occured");
    }
  }
}
