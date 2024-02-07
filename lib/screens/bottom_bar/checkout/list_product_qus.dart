import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/screens/bottom_bar/checkout/list_your_product_view.dart';

import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../notifications_screen.dart';

class ListYourProductQus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 9.h,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back)),
                    Text(
                      "List Your Product",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.to(NotificationsScreen());
                        },
                        child: Icon(
                          CupertinoIcons.bell_fill,
                        )),
                  ],
                ),
              ),

              ///des
              Container(
                width: double.maxFinite,
                height: 12.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                margin: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  color: ColorConstants.maroon.withOpacity(0.26),
                ),
                child: Row(
                  children: [
                    Spaces.x5,
                    Image.asset(
                      "assets/images/tag.png",
                      width: 10.w,
                    ),
                    Spaces.x8,
                    Text(
                      "Description:",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),

              Spaces.y2,

              ///ans qus
              Center(
                child: Text(
                  'Please Answer The Following Questions:',
                  style: TextStyle(
                    fontSize: 12.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Spaces.y3,

              ///brand qus
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  'What is the product brand?',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Spaces.y2,

              ///ans
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  '----------------',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Spaces.y3,

              ///time qus
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  'How many years have you used this product?',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Spaces.y2,

              ///ans
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  '----------------',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Spaces.y3,

              ///time qus
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  'Does it come with receipt/box?',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Spaces.y2,

              ///ans
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  '----------------',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Spaces.y8,

              ///save
              GestureDetector(
                onTap: () {
                  Get.to(ListYourProductView());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 7.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.3.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.whiteLevel2,
                  ),
                  child: Center(
                      child: Text(
                    'Save & Continue Later',
                    style: TextStyle(
                        color: ColorConstants.redLevel4,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
