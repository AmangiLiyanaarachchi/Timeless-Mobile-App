import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/screens/bottom_bar/checkout/list_product_qus.dart';

import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../notifications_screen.dart';

class ListYourProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: Image.asset(
                "assets/images/bg3.png",
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
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
                              child: Icon(
                                Icons.arrow_back,
                              )),
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
                    Container(
                      child: Column(
                        children: [
                          Spaces.y2,
                          Image.asset(
                            "assets/images/coat.png",
                            width: 40.w,
                          ),
                          Spaces.y1,
                        ],
                      ),
                    ),
                    Spaces.y7,
                    Container(
                      width: double.maxFinite,
                      height: 12.h,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15.0),
                            topRight: Radius.circular(15.0)),
                        color: ColorConstants.greenLevel2,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.person,
                          ),
                          Spaces.x5,
                          Text(
                            "Name  :",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Spacer(),
                          Text(
                            "Prada Slim Puffer",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Spaces.x5,
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 12.h,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        color: ColorConstants.greenLevel2,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.money_dollar_circle,
                          ),
                          Spaces.x5,
                          Text(
                            "Price  :",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Spacer(),
                          Text(
                            "1500 QAR",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Spaces.x5,
                        ],
                      ),
                    ),
                    Spaces.y2,

                    ///category
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 1.3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.whiteLevel2,
                      ),
                      child: Row(
                        children: [
                          Text('Catgory'),
                          Spacer(),
                          Icon(Icons.arrow_drop_down_sharp)
                        ],
                      ),
                    ),

                    Spaces.y2,

                    ///des
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 17.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 4.5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.greenLevel2,
                      ),
                      child: Center(
                          child: Text(
                        'Description:',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )),
                    ),

                    Spaces.y4,

                    ///save
                    GestureDetector(
                      onTap: () {
                        Get.to(ListYourProductQus());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 22.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.3.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Center(
                            child: Text(
                          'List!',
                          style: TextStyle(
                              color: ColorConstants.whiteColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    ),

                    Spaces.y3,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
