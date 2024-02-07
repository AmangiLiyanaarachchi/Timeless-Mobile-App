import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../notifications_screen.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Spaces.y1,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                  )),
                              Text(
                                "Timeless ",
                                style: TextStyle(
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.maroon),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(NotificationsScreen());
                                  },
                                  child: Icon(
                                    CupertinoIcons.bell_fill,
                                  ))
                            ],
                          ),
                        ),
                        Spaces.y1,
                      ],
                    ),
                    Image.asset("assets/images/girl2.png"),
                    Spaces.y2,
                    //
                    Row(
                      children: [
                        Spaces.x8,
                        Text(
                          'SELLER REVIEW',
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: ColorConstants.grayLevel17),
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
                          style:
                              TextStyle(fontSize: 25.sp, color: Colors.black),
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
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
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
                              style: TextStyle(
                                  fontSize: 11.sp, color: Colors.black),
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
                          style:
                              TextStyle(fontSize: 11.sp, color: Colors.black),
                        ),

                        Spacer(),

                        //new btn
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.imageBackground),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.h),
                          child: Row(
                            children: [
                              Text('New in'),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
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

                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/girl3.png',
                                      width: 10.w,
                                    ),
                                    Spaces.x3,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Eleanor Summers'),
                                        Spaces.y2,
                                        RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          itemSize: 10,
                                          direction: Axis.horizontal,
                                          allowHalfRating: false,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.rectangle,
                                            color: ColorConstants.yellowLevel1,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      'Today, 16:40',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorConstants.grayLevel17),
                                    ),
                                  ],
                                ),
                                Spaces.y2,
                                Text(
                                    'Great product, I love the sound of it 😍'),
                              ],
                            ),
                          );
                        })
                  ],
                ),
                Positioned(right: 4.w, top: 10.h, child: Icon(Icons.fullscreen))
              ],
            ),
          ),
        ),
      ),
    );
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
}
