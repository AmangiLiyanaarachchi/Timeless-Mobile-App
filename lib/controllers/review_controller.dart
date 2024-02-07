import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeless/Constants/firebase_consts.dart';
import 'package:timeless/models/ReviewModel.dart';

import '../main.dart';

class ReviewController extends GetxController {
  double selRating = 0.0;
  TextEditingController reviewController = TextEditingController();

  void createReview(
    BuildContext context,
    String prodId,
  ) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    print(formattedTime);
    print(formattedDate);

    String productId = prodId;
    String id = uuid.v4();
    print("check data ${reviewController.text}, $selRating");
    ReviewModel newData = ReviewModel(
      id: id,
      productId: productId,
      review: reviewController.text.trim(),
      rating: selRating,
      creatorId: auth.currentUser!.uid,
      createdOn: DateTime.now(),
    );
    await firestore
        .collection("ProductReviews")
        .doc(id)
        .set(newData.toMap())
        .then(
          (value) => debugPrint("Review Given"),
        );
    reviewController.clear();
    selRating = 0.0;
    //Get.offNamed('/viewProduct');
  }
}
