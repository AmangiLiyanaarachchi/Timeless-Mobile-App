import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/main.dart';
import 'package:timeless/models/WishlistModel.dart';
import '../screens/Customer_screens/product_details/wishlist_screen.dart';
import '../utils/utility_const.dart';

class WishlistController extends GetxController {
  addItemtoWishlist(String prodId) async {
    WishlistModel wishlist = WishlistModel(
        uId: uuid.v4(), custId: auth.currentUser!.uid, prodId: prodId);
    await firestore
        .collection("Wishlist")
        .doc(wishlist.uId)
        .set(wishlist.toMap());
    hideLoading();

    Get.snackbar("Success!", "A new product added to your wishlist",
        backgroundColor: Colors.white,
        borderWidth: 2,
        borderColor: Colors.lightGreen,
        colorText: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        padding: EdgeInsets.symmetric(
          vertical: 1.5.h,
          horizontal: 2.w,
        ),
        mainButton: TextButton(
            onPressed: () {
              Get.to(WishlistScreen());
            },
            child: Text(
              "View",
              style: TextStyle(color: Colors.lightGreen),
            )),
        margin: EdgeInsets.only(bottom: 1.h, left: 3.w, right: 3.w));
  }

  removeItemfromWishlist(String prodId) async {
    QuerySnapshot snapshot = await firestore
        .collection("Wishlist")
        .where("prodId", isEqualTo: prodId)
        .get();

    WishlistModel wishlistModel =
        WishlistModel.fromMap(snapshot.docs[0].data() as Map<String, dynamic>);
    firestore.collection("Wishlist").doc(wishlistModel.uId).delete();
  }
}
