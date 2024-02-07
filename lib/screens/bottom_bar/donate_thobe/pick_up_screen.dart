import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../notifications_screen.dart';

class PickUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Image.asset(
                "assets/images/home_bg.png",
                height: double.maxFinite,
                width: double.maxFinite,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Timeless ",
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.maroon),
                        ),
                        Spaces.x10,
                        Spaces.x10,
                        Spaces.x2,
                        GestureDetector(
                            onTap: () {
                              Get.to(NotificationsScreen());
                            },
                            child: Icon(
                              CupertinoIcons.bell_fill,
                            ))
                      ],
                    ),
                    Spaces.y5,

                    ///about thobe
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/thobe.png",
                          height: 27.h,
                        ),
                        Spaces.x5,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //nmbr
                            Row(
                              children: [
                                Text(
                                  "Number: ",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                Spaces.x10,
                                Spaces.x5,
                                Container(
                                  height: 6.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: ColorConstants.yellowLevel1,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "2",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13.sp),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.arrow_drop_down,
                                            size: 8.w),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Spaces.y2,

                            //color
                            Row(
                              children: [
                                Text(
                                  "Color: ",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                Spaces.x10,
                                Spaces.x10,
                                Spaces.x4,
                                Text(
                                  "White",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Spaces.y2,

                            ///choose one
                            Text(
                              "Please choose one: ",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                            Spaces.y2,
                          ],
                        )
                      ],
                    ),
                    Spaces.y3,
                    Image.asset(
                      "assets/images/check.png",
                      width: 20.w,
                    ),
                    Spaces.y3,

                    Text(
                      "We will call you once we arrive",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),

                    Spaces.y10,

                    Text(
                      "We cannot wait!",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
