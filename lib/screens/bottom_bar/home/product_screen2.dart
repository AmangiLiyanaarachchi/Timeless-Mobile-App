import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/Constants/color_constants.dart';

import '../../../utils/space_values.dart';
import '../notifications_screen.dart';

class FirestoreDataDisplay extends StatelessWidget {
  final DocumentSnapshot itemData; // Data passed from the first screen

  FirestoreDataDisplay({required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Timeless",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ColorConstants.maroon),
          ),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back)),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.to(NotificationsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    CupertinoIcons.bell_fill,
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                itemData['image'],
                width: 400,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 10),
                child: Text(itemData['name'],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 5),
                child: Text(itemData['price'],
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ),

              Row(
                children: [
                  Spaces.x8,
                  Text(
                    'SELLER REVIEW',
                    style: TextStyle(
                        fontSize: 10.sp, color: ColorConstants.grayLevel17),
                  ),
                  Spacer(),
                  Image.asset(
                    'assets/images/heart.png',
                    width: 8.w,
                  ),
                  Spaces.x4,
                ],
              ),

              Spaces.y2,

              Row(
                children: [
                  Spaces.x8,
                  Text(
                    '4,0',
                    style: TextStyle(fontSize: 25.sp, color: Colors.black),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        itemSize: 20,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.rectangle,
                          color: ColorConstants.yellowLevel1,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Spaces.y0,
                      Text(
                        '1k Reviews',
                        style: TextStyle(fontSize: 11.sp, color: Colors.black),
                      ),
                    ],
                  ),
                  Spaces.x8,
                ],
              ),
              Spaces.y4,

              //divider
              Container(
                width: 100.w,
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),

              barGraphRating(),
              Spaces.y6,

              Row(
                children: [
                  Spaces.x8,
                  Text(
                    '1k Reviews',
                    style: TextStyle(fontSize: 11.sp, color: Colors.black),
                  ),

                  Spacer(),

                  //new btn
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.imageBackground),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: Row(
                      children: [Text('New in'), Icon(Icons.arrow_drop_down)],
                    ),
                  ),

                  Spaces.x4,
                ],
              ),
            ],
          ),
        ));
  }
}

Widget barGraphRating() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Spaces.y2,
      item('5', '55'),
      Spaces.y2,
      item('4', '16'),
      Spaces.y2,
      item('3', '14'),
      Spaces.y2,
      item('2', '1'),
      Spaces.y2,
      item('1', '14'),
    ],
  );
}

Widget item(String index, String percent) {
  return Row(
    children: [
      Spaces.x5,
      Text(index),
      Spaces.x2,
      Icon(
        Icons.rectangle,
        color: ColorConstants.yellowLevel1,
      ),
      Spaces.x5,
      Stack(
        children: [
          Expanded(
              child: Container(
            width: 63.w,
            decoration: BoxDecoration(
                color: ColorConstants.containerBorderColor,
                borderRadius: BorderRadius.circular(5)),
            height: 13,
          )),
          Container(
            height: 13,
            width: 30.w,
            decoration: BoxDecoration(
                color: ColorConstants.green,
                borderRadius: BorderRadius.circular(5)),
          )
        ],
      ),
      Spaces.x5,
      Text("$percent%"),
      // Spaces.x5,
    ],
  );
}
