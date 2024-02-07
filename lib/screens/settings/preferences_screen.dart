import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/space_values.dart';

class PreferencesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ///top bar
            Container(
              width: double.maxFinite,
              height: 9.h,
              color: Colors.grey.withOpacity(0.4),
              child: Row(
                children: [
                  Spaces.x5,
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back)),
                  Spaces.x10,
                  Spaces.x10,
                  Spaces.x3,
                  Text(
                    "Preferences ",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Spaces.y5,

            Padding(
              padding: EdgeInsets.only(right: 5.w, left: 3.w),
              child: Column(
                children: [
                  ///language
                  Container(
                    height: 0.1.h,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                    margin: EdgeInsets.only(top: 1.h),
                  ),
                  Row(
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      Spacer(),
                      Text(
                        "عربي",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_drop_down, size: 8.w),
                      ),
                    ],
                  ),

                  ///currency
                  Container(
                    height: 0.1.h,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                    margin: EdgeInsets.only(top: 1.h),
                  ),
                  Row(
                    children: [
                      Text(
                        "Currency",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      Spacer(),
                      Text(
                        "QAR",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_drop_down, size: 8.w),
                      ),
                    ],
                  ),

                  ///Push Notifications
                  Container(
                    height: 0.1.h,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                    margin: EdgeInsets.only(top: 1.h),
                  ),
                  Row(
                    children: [
                      Text(
                        "Push Notifications",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      Spacer(),
                      Switch(
                        onChanged: null,
                        value: false,
                        activeColor: Colors.red,
                        activeTrackColor: Colors.red,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey.withOpacity(0.4),
                      )
                    ],
                  ),

                  ///Dark Mode
                  Container(
                    height: 0.1.h,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                    margin: EdgeInsets.only(top: 1.h),
                  ),
                  Row(
                    children: [
                      Text(
                        "Dark Mode",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      Spacer(),
                      Switch(
                        onChanged: null,
                        value: true,
                        activeColor: Colors.red,
                        activeTrackColor: Colors.red,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey.withOpacity(0.4),
                      )
                    ],
                  ),

                  ///Interests and sizes
                  Container(
                    height: 0.1.h,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                  ),
                  Spaces.y1,
                  Row(
                    children: [
                      Text(
                        "Interests and sizes",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward),
                      Spaces.x5,
                    ],
                  ),
                  Container(
                    height: 0.1.h,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
