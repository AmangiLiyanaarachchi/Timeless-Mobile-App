import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/main.dart';
import 'package:timeless/models/AdminModel.dart';
import 'package:timeless/models/CartModel.dart';
import 'package:timeless/models/OrderModel.dart';
import 'package:timeless/models/UserModel.dart';
import 'package:timeless/screens/Customer_screens/Orders/order_completed.dart';
import 'package:timeless/utils/utility_const.dart';

import '../utils/notification_services.dart';

class OrderController extends GetxController {
  NotificationServices notificationServices = NotificationServices();

  RxInt quant = 1.obs;
  RxString selSize = "XS".obs;
  RxString selShoeSize = "05".obs;

  RxString selColor = "".obs;
  int subTotal = 1;
  var cityController = TextEditingController(),
      nameController = TextEditingController(),
      stateController = TextEditingController(),
      addressController = TextEditingController(),
      zipcodeController = TextEditingController(),
      phoneNo = '';

  addToCart(String productId, int prodPrice) async {
    try {
      setLoading();
      String cartId = uuid.v4();
      int subTotal = quant.value * prodPrice;
      CartModel cartModel = CartModel(
        cartId: cartId,
        custId: auth.currentUser!.uid,
        prodId: productId,
        prodQuant: quant.value,
        subTot: subTotal,
        status: "active",
        color: selColor.value,
        size: selSize.value.isNotEmpty ? selSize.value : selShoeSize.value,
      );
      await firestore.collection("Cart").doc(cartId).set(cartModel.toMap());
      hideLoading();
    } catch (e) {
      hideLoading();
    }
  }

  updateQuantity(int quant, int subTotal, String uid) {
    int subTot = quant * subTotal;
    firestore
        .collection("Cart")
        .doc(uid)
        .set({"prodQuant": quant, "subTot": subTot}, SetOptions(merge: true));
  }

  deleteFromCart(String uid) {
    firestore.collection("Cart").doc(uid).delete();
  }

  placeOrder(List<CartModel> cartItems, total) async {
    try {
      setLoading();
      List cartIds = [];
      for (var cart in cartItems) {
        cartIds.add(cart.cartId);
      }
      String orderId = generateOrderId();

      OrderModel orderModel = OrderModel(
          uid: orderId,
          orderDate: DateTime.now(),
          orderedBy: auth.currentUser!.uid,
          cartIds: cartIds,
          recepAddr: addressController.text,
          recepName: nameController.text,
          subTotal: total - 200, //200 delivery charges
          recepPhone: phoneNo,
          totalBill: total,
          orderStatus: "pending");

      await firestore
          .collection("Orders")
          .doc(orderModel.uid)
          .set(orderModel.toMap());

      for (var item in cartItems) {
        await firestore
            .collection("Cart")
            .doc(item.cartId)
            .update({"status": "inactive"});

        await firestore
            .collection("Products")
            .doc(item.prodId)
            .get()
            .then((value) {
          var quant = value.data()!['quantity'] - 1;
          firestore
              .collection("Products")
              .doc(item.prodId)
              .update({"quantity": quant});
        });
        DocumentSnapshot snapshot =
            await firestore.collection("Admins").doc(adminId).get();
        AdminModel admin =
            AdminModel.fromMap(snapshot.data() as Map<String, dynamic>);
        notificationServices.sendNotification(
          "Timeless",
          admin.token,
          "Someone Purchased Your Listed Product",
          admin.uid,
          orderId,
        );
      }
      resetParams();
      hideLoading();
      Get.to(OrderCompleted());
    } catch (e) {
      hideLoading();
      print("errror $e");
    }
  }

  String generateOrderId() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String orderId = String.fromCharCodes(
      Iterable.generate(
        8,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
    return orderId;
  }

  resetParams() {
    cityController.clear();
    nameController.clear();
    stateController.clear();
    addressController.clear();
    zipcodeController.clear();
    phoneNo = '';
  }

  approveOrder(String orderID) async {
    firestore
        .collection("Orders")
        .doc(orderID)
        .update({"orderStatus": "approved"});

    print("check data ${loginController.userModel.value.uid}");
    DocumentSnapshot snapshot =
        await firestore.collection("Orders").doc(orderID).get();
    OrderModel order =
        OrderModel.fromMap(snapshot.data() as Map<String, dynamic>);

    DocumentSnapshot custSnapshot =
        await firestore.collection("Customers").doc(order.orderedBy).get();
    UserModel cust =
        UserModel.fromMap(custSnapshot.data() as Map<String, dynamic>);
    notificationServices.sendNotification(
      "Timeless",
      cust.token,
      "Your order against order Id: ${orderID} has been shipped",
      cust.uid,
      orderID,
    );
  }

  cancelOrder(String orderID) async {
    firestore
        .collection("Orders")
        .doc(orderID)
        .update({"orderStatus": "declined"});

    print("check data ${loginController.userModel.value.uid}");
    DocumentSnapshot snapshot =
        await firestore.collection("Orders").doc(orderID).get();
    OrderModel order =
        OrderModel.fromMap(snapshot.data() as Map<String, dynamic>);

    DocumentSnapshot custSnapshot =
        await firestore.collection("Customers").doc(order.orderedBy).get();
    UserModel cust =
        UserModel.fromMap(custSnapshot.data() as Map<String, dynamic>);
    notificationServices.sendNotification(
      "Timeless",
      cust.token,
      "Your order against order Id: ${orderID} has been declined",
      cust.uid,
      orderID,
    );
  }
}
