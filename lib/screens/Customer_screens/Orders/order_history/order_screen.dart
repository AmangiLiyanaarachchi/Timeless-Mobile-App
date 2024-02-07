import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/controllers/call_controllers.dart';
import '../../../../Constants/color_constants.dart';
import '../../../../Constants/firebase_consts.dart';
import '../../../../Constants/font_styles.dart';
import '../../../../models/OrderModel.dart';
import '../../../../models/UserModel.dart';
import '../../../../utils/space_values.dart';
import '../../../../widgets/dialogs/confirmation_dialog.dart';
import 'order_detail.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  DateTime? selectedDate;
  final DateTime threeDaysAgo =
      DateTime.now().subtract(const Duration(days: 3));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              iconTheme:
                  const IconThemeData(color: Color.fromARGB(255, 67, 23, 23)),
              backgroundColor: Theme.of(context).canvasColor,
              scrolledUnderElevation: 0,
              elevation: 0,
              title: Text(
                "Orders History",
                style: FontStyles.appBarStyleBlack,
              ),
              centerTitle: true,
              actions: [
                GestureDetector(
                    onTap: () async {
                      await selectDate(context);
                      print("data is ${selectedDate}");
                    },
                    child: Icon(
                      Icons.calendar_month,
                      size: 2.5.h,
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = null;
                      });
                    },
                    tooltip: "Reset ",
                    icon: Icon(
                      Icons.replay,
                      size: 2.5.h,
                    ))
              ],
              bottom: TabBar(
                  indicatorColor: ColorConstants.primaryColor,
                  labelColor: ColorConstants.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text(
                        "Recent",
                        style: FontStyles.blackBodyText,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Pending",
                        style: FontStyles.blackBodyText,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Delivered",
                        style: FontStyles.blackBodyText,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Declined",
                        style: FontStyles.blackBodyText,
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(
              children: [
                StreamBuilder(
                    stream: adminId == auth.currentUser!.uid
                        ? firestore
                            .collection('Orders')
                            .where('orderDate',
                                isGreaterThanOrEqualTo: threeDaysAgo)
                            .snapshots()
                        : firestore
                            .collection('Orders')
                            .where("custId", isEqualTo: auth.currentUser!.uid)
                            .where('orderDate',
                                isGreaterThanOrEqualTo: threeDaysAgo)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          List<OrderModel> orders = [];

                          for (var doc in snapshot.data!.docs) {
                            orders.add(OrderModel.fromMap(doc.data()));
                          }
                          print(
                            "$selectedDate, ${DateTime.now()}",
                          );
                          return selectedDate == null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orders.length,
                                  itemBuilder: (c, ind) {
                                    return AllOrderCard(
                                      order: orders[ind],
                                    );
                                  })
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orders.length,
                                  itemBuilder: (c, ind) {
                                    if (orders[ind].orderDate.day ==
                                            selectedDate!.day &&
                                        orders[ind].orderDate.month ==
                                            selectedDate!.month &&
                                        orders[ind].orderDate.year ==
                                            selectedDate!.year) {
                                      return AllOrderCard(
                                        order: orders[ind],
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  });
                        } else {
                          return Center(
                            child: Text(
                              "No records",
                              style: FontStyles.blackBodyText,
                            ),
                          );
                        }
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                StreamBuilder(
                    stream: adminId == auth.currentUser!.uid
                        ? firestore
                            .collection('Orders')
                            .where('orderStatus', isEqualTo: 'pending')
                            .snapshots()
                        : firestore //if customer is login show all his orders
                            .collection('Orders')
                            .where("custId", isEqualTo: auth.currentUser!.uid)
                            .where('orderStatus', isEqualTo: 'pending')
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          List<OrderModel> orders = [];

                          for (var doc in snapshot.data!.docs) {
                            orders.add(OrderModel.fromMap(doc.data()));
                          }

                          return selectedDate == null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orders.length,
                                  itemBuilder: (c, ind) {
                                    return OrderCard(
                                      order: orders[ind],
                                      press: () =>
                                          approveOrder(context, ind, orders),
                                      cancel: () =>
                                          declineOrder(context, ind, orders),
                                    );
                                  })
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orders.length,
                                  itemBuilder: (c, ind) {
                                    if (orders[ind].orderDate.day ==
                                            selectedDate!.day &&
                                        orders[ind].orderDate.month ==
                                            selectedDate!.month &&
                                        orders[ind].orderDate.year ==
                                            selectedDate!.year) {
                                      return OrderCard(
                                        order: orders[ind],
                                        press: () =>
                                            approveOrder(context, ind, orders),
                                        cancel: () =>
                                            declineOrder(context, ind, orders),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  });
                        } else {
                          return Center(
                            child: Text(
                              "No records",
                              style: FontStyles.blackBodyText,
                            ),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                StreamBuilder(
                    stream: adminId == auth.currentUser!.uid
                        ? firestore
                            .collection('Orders')
                            .where('orderStatus', isEqualTo: 'approved')
                            .snapshots()
                        : firestore
                            .collection("Orders")
                            .where("custId", isEqualTo: auth.currentUser!.uid)
                            .where('orderStatus', isEqualTo: 'approved')
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          List<OrderModel> orders = [];

                          for (var doc in snapshot.data!.docs) {
                            orders.add(OrderModel.fromMap(doc.data()));
                          }

                          return selectedDate == null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orders.length,
                                  itemBuilder: (c, ind) {
                                    return ApprovedOrders(order: orders[ind]);
                                  })
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orders.length,
                                  itemBuilder: (c, ind) {
                                    print(
                                        "check data ${orders[ind].orderDate.day == selectedDate?.day}, ${orders[ind].orderDate.month == selectedDate?.month}, ${orders[ind].orderDate.year == selectedDate?.year}");
                                    if (orders[ind].orderDate.day ==
                                            selectedDate!.day &&
                                        orders[ind].orderDate.month ==
                                            selectedDate!.month &&
                                        orders[ind].orderDate.year ==
                                            selectedDate!.year) {
                                      return ApprovedOrders(order: orders[ind]);
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  });
                        } else {
                          return Center(
                            child: Text(
                              "No records",
                              style: FontStyles.blackBodyText,
                            ),
                          );
                        }
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                StreamBuilder(
                    stream: adminId == auth.currentUser!.uid
                        ? firestore
                            .collection('Orders')
                            .where('orderStatus', isEqualTo: 'declined')
                            .snapshots()
                        : firestore
                            .collection("Orders")
                            .where("custId", isEqualTo: auth.currentUser!.uid)
                            .where('orderStatus', isEqualTo: 'declined')
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          List<OrderModel> orders = [];

                          for (var doc in snapshot.data!.docs) {
                            orders.add(OrderModel.fromMap(doc.data()));
                          }

                          return Expanded(
                              child: selectedDate == null
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: orders.length,
                                      itemBuilder: (c, ind) {
                                        return ApprovedOrders(
                                            order: orders[ind]);
                                      })
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: orders.length,
                                      itemBuilder: (c, ind) {
                                        if (orders[ind].orderDate.day ==
                                                selectedDate!.day &&
                                            orders[ind].orderDate.month ==
                                                selectedDate!.month &&
                                            orders[ind].orderDate.year ==
                                                selectedDate!.year) {
                                          return ApprovedOrders(
                                              order: orders[ind]);
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      }));
                        } else {
                          return Center(
                            child: Text(
                              "No records",
                              style: FontStyles.blackBodyText,
                            ),
                          );
                        }
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ],
            )));
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(2023, 09),
        lastDate: DateTime(2101));

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}

Future<dynamic> approveOrder(
    BuildContext context, int index, List<OrderModel> orders) {
  return showDialog(
    context: context,
    builder: (context) {
      return ConfirmationDialog(
        title: "Approve Order",
        message: "Approving the order ${orders[index].uid}...",
        onConfirm: () async {
          await orderController.approveOrder(orders[index].uid);
          orders.removeAt(index);
          // Get.back();
          Navigator.pop(context); // Close the dialog after successful delete
        },
        onCancel: () {
          Navigator.pop(context);
          //Get.back(); // Close the dialog after successful delete
        },
      );
    },
  );
}

Future<dynamic> declineOrder(
    BuildContext context, int index, List<OrderModel> orders) {
  return showDialog(
    context: context,
    builder: (context) {
      return ConfirmationDialog(
        title: "Cancel Order",
        message: "Are you sure to decline the order ${orders[index].uid}?",
        onConfirm: () async {
          await orderController.cancelOrder(orders[index].uid);
          orders.removeAt(index);
          // Get.back(); // Close the dialog after successful delete
          Navigator.pop(context);
        },
        onCancel: () {
          // Get.back(); // Close the dialog after successful delete
          Navigator.pop(context);
        },
      );
    },
  );
}

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.order,
      required this.press,
      required this.cancel});
  final OrderModel order;
  final VoidCallback press;
  final VoidCallback cancel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            firestore.collection("Customers").doc(order.orderedBy).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = UserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return ListTile(
              onTap: () {
                Get.to(OrderDetailWScreen(
                  order: order,
                  user: userModel,
                ));
              },
              shape: Border.all(color: Colors.grey.shade200),
              leading: userModel.profilepic.isNotEmpty
                  ? Image.network(
                      userModel.profilepic,
                      width: 12.w,
                      height: 6.h,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      width: 12.w,
                      height: 6.h,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 6.h,
                      ),
                    ),
              title: Row(
                children: [
                  Flexible(
                    child: Text(
                      userModel.fullname,
                      style: FontStyles.blackBodyText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spaces.x0,
                  Flexible(
                    child: Text(
                      '(${order.cartIds.length} items)',
                      style: FontStyles.smallBlackBodyText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                'Ordered on: ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                style: FontStyles.smallGreyBodyText,
              ),
              trailing: Obx(
                () => loginController.activeAdmin.value.uid ==
                        auth.currentUser!.uid
                    ? Wrap(runSpacing: 1.h, children: [
                        IconButton.filledTonal(
                            padding: EdgeInsets.zero,
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.lightGreen),
                            onPressed: press,
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                            )),
                        IconButton.filledTonal(
                            padding: EdgeInsets.zero,
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.redAccent),
                            onPressed: cancel,
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ))
                      ])
                    : const SizedBox.shrink(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        });
  }
}

class AllOrderCard extends StatelessWidget {
  const AllOrderCard({
    super.key,
    required this.order,
  });
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            firestore.collection("Customers").doc(order.orderedBy).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = UserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return ListTile(
                onTap: () {
                  Get.to(OrderDetailWScreen(
                    order: order,
                    user: userModel,
                  ));
                },
                shape: Border.all(color: Colors.grey.shade200),
                leading: userModel.profilepic.isNotEmpty
                    ? Image.network(
                        userModel.profilepic,
                        width: 12.w,
                        height: 6.h,
                        fit: BoxFit.fill,
                      )
                    : Container(
                        color: Colors.grey.shade300,
                        width: 12.w,
                        height: 6.h,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 6.h,
                        ),
                      ),
                title: Row(
                  children: [
                    Flexible(
                      child: Text(
                        userModel.fullname,
                        style: FontStyles.blackBodyText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spaces.x0,
                    Flexible(
                      child: Text(
                        '(${order.cartIds.length} items)',
                        style: FontStyles.smallBlackBodyText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Ordered on: ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                  style: FontStyles.smallGreyBodyText,
                ),
                trailing: Wrap(spacing: 10.0, children: [
                  order.orderStatus.toLowerCase() == 'approved'
                      ? Badge(
                          largeSize: 3.h,
                          backgroundColor: Colors.lightGreen,
                          label: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 3.0),
                            child: Text(
                              "Shipped",
                              style: FontStyles.smallWhiteBodyText,
                            ),
                          ),
                        )
                      : order.orderStatus.toLowerCase() == 'pending'
                          ? Badge(
                              largeSize: 3.h,
                              backgroundColor:
                                  const Color.fromARGB(255, 223, 169, 6),
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 3.0),
                                child: Text(
                                  "Pending",
                                  style: FontStyles.smallWhiteBodyText,
                                ),
                              ),
                            )
                          : Badge(
                              largeSize: 3.h,
                              backgroundColor: Colors.redAccent,
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 2.0),
                                child: Text(
                                  "Declined",
                                  style: FontStyles.smallWhiteBodyText,
                                ),
                              ),
                            ),
                ]));
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        });
  }
}

class ApprovedOrders extends StatelessWidget {
  const ApprovedOrders({
    super.key,
    required this.order,
  });
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            firestore.collection("Customers").doc(order.orderedBy).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = UserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return ListTile(
              onTap: () {
                Get.to(OrderDetailWScreen(
                  order: order,
                  user: userModel,
                ));
              },
              shape: Border.all(color: Colors.grey.shade200),
              leading: userModel.profilepic.isNotEmpty
                  ? Image.network(
                      userModel.profilepic,
                      width: 16.w,
                      height: 6.h,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      width: 16.w,
                      height: 6.h,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 6.h,
                      ),
                    ),
              title: Row(
                children: [
                  Text(
                    userModel.fullname,
                    style: FontStyles.boldBlackBodyText,
                  ),
                  Spaces.x1,
                  Text(
                    '(${order.cartIds.length} items)',
                    style: FontStyles.blackBodyText,
                  ),
                ],
              ),
              subtitle: Text(
                'Ordered on: ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                style: FontStyles.smallGreyBodyText,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
        });
  }
}
