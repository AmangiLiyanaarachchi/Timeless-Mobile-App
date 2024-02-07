import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/Constants/firebase_consts.dart';
import 'package:timeless/models/OrderModel.dart';
import 'package:timeless/models/UserModel.dart';
import 'package:timeless/models/notification_model.dart';
import 'package:timeless/screens/Customer_screens/BottomBarNew/bottom_bar.dart';
import 'package:timeless/screens/Customer_screens/Orders/order_history/order_detail.dart';
import 'package:timeless/screens/Customer_screens/Orders/order_history/order_screen.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/Donations.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/one-to-one_chat/chatroom.dart';
import '../../Constants/color_constants.dart';
import '../../Constants/font_styles.dart';
import '../../controllers/call_controllers.dart';
import '../../models/ChatRoomModel.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future<List<NotificationModel>> fetchNotifications() async {
    List<NotificationModel> notifications = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection("Notifications").get();

    querySnapshot.docs.forEach((doc) {
      notifications.add(NotificationModel.fromMap(doc.data()));
    });

    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
        title: Text(
          "Notifications",
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Wrap(children: [
            Container(
              child: StreamBuilder(
                stream: firestore
                    .collection("Notifications")
                    .where("receiverId", isEqualTo: auth.currentUser!.uid)
                    .orderBy('time', descending: true)
                    .snapshots(),
                //       auth.currentUser!.uid == adminId ? firestore.collection("Notifications").snapshots():
                // firestore.collection("Notifications").where("recieverId", isEqualTo: loginController.userModel.value.uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No Notifications to show'));
                  } else {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        NotificationModel notification =
                            NotificationModel.fromMap(
                                snapshot.data!.docs[index].data());
                        //MessageModel messages = MessageModel.fromMap(snapshot.data!.docs[index].data());
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 1.h, left: 2.w, right: 2.w),
                              // padding: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ColorConstants.primaryColor
                                              .withOpacity(0.1)))),
                              child: StreamBuilder(
                                stream: auth.currentUser!.uid == adminId
                                    ? FirebaseFirestore.instance
                                        .collection('Customers')
                                        .doc(notification.senderId)
                                        .snapshots()
                                    : FirebaseFirestore.instance
                                        .collection('Admins')
                                        .doc(notification.senderId)
                                        .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const SizedBox
                                        .shrink(); // Show a loading indicator while fetching data.
                                  }

                                  final userData = snapshot.data?.data();
                                  final userName =
                                      userData?["fullname"] == "Timeless Admin"
                                          ? "Customer Support"
                                          : userData?["fullname"];
                                  final userProfilePicture =
                                      userData?["profilepic"];

                                  return ListTile(
                                    onTap: () async {
                                      if (notification.message ==
                                              "You Got a Message!" &&
                                          auth.currentUser!.uid == adminId) {
                                        UserModel userModel = UserModel.fromMap(
                                            snapshot.data!.data()
                                                as Map<String, dynamic>);

                                        ChatRoomModel? chatroom =
                                            await chatController
                                                .getChatroom(userModel.uid);
                                        chatController.name.value =
                                            userModel.fullname;
                                        chatController.img.value =
                                            userModel.profilepic;
                                        chatController.uid.value =
                                            userModel.uid;
                                        chatController.chatroomId.value =
                                            chatroom?.chatroomid ?? "";
                                        chatController.token.value =
                                            userModel.token;

                                        Get.to(ChatroomScreen());
                                      } else if (notification.message ==
                                              "You Got a Message!" &&
                                          auth.currentUser!.uid ==
                                              loginController
                                                  .userModel.value.uid) {
                                        ChatRoomModel? chatroom =
                                            await chatController
                                                .getChatroomForCustomer(); //keep same admin id - replace with original
                                        chatController.chatroomId.value =
                                            chatroom?.chatroomid ?? "";
                                        await chatController
                                            .getAdminData(adminId);
                                        bottombarController
                                            .selectedIndex.value = 1;
                                        Get.off(BottomBarScreen1());
                                      } else if (notification.message ==
                                              "Someone Purchased Your Listed Product" &&
                                          auth.currentUser!.uid == adminId) {
                                        Get.to(OrderScreen());
                                      } else if (notification.message ==
                                              "Your order against order Id: ${notification.navigationId} has been shipped" ||
                                          notification.message ==
                                              "Your order against order Id: ${notification.navigationId} has been declined") {
                                        DocumentSnapshot snapshot =
                                            await firestore
                                                .collection("Orders")
                                                .doc(notification.navigationId)
                                                .get();
                                        OrderModel order = OrderModel.fromMap(
                                            snapshot.data()
                                                as Map<String, dynamic>);

                                        DocumentSnapshot snapshotCust =
                                            await firestore
                                                .collection("Customers")
                                                .doc(notification.receiverId)
                                                .get();
                                        UserModel userModel = UserModel.fromMap(
                                            snapshotCust.data()
                                                as Map<String, dynamic>);
                                        Get.to(OrderDetailWScreen(
                                            order: order, user: userModel));

                                        print("Order details");
                                      } else if (notification.message ==
                                          "Someone sent a donation!") {
                                        Get.to(Donations());
                                      }
                                      setState(() {
                                        firestore
                                            .collection("Notifications")
                                            .doc(notification.uid)
                                            .delete();
                                      });
                                    },
                                    minLeadingWidth: 11.w,
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(userProfilePicture),
                                    ),
                                    title: Text("$userName",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: FontStyles.boldBlackBodyText),
                                    subtitle: Text(
                                      notification.message,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      // style: FontStyles.blackBodyText,
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // InkWell(
                                        //     onTap: () {
                                        //       setState(() {
                                        //         firestore
                                        //             .collection(
                                        //                 "Notifications")
                                        //             .doc(notification.uid)
                                        //             .delete();
                                        //       });
                                        //     },
                                        //     child: Icon(Icons.delete)),
                                        // Spaces.y1,
                                        Text(
                                          notification.time.day ==
                                                      DateTime.now().day &&
                                                  notification.time.month ==
                                                      DateTime.now().month &&
                                                  notification.time.year ==
                                                      DateTime.now().year
                                              ? "${notification.time.hour.toString().padLeft(2, '0')}:${notification.time.minute.toString().padLeft(2, '0')}"
                                              : "${notification.time.day.toString().padLeft(2, '0')}/"
                                                  "${notification.time.month.toString().padLeft(2, '0')}/${notification.time.year.toString().padLeft(2, '0')} ",
                                          style: FontStyles.smallGreyBodyText,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
