import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../notifications_screen.dart';
import 'drop_or_pick.dart';

class DonateThobeScreen extends StatelessWidget {
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
                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            onTap: (){
                              Get.to(NotificationsScreen());
                            },
                            child: Icon(CupertinoIcons.bell_fill, ))
                      ],
                    ),
                    Spaces.y1,
                    Text(
                      "Thank you *user name* for donating your thobe.",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Spaces.y4,
                    GestureDetector(
                      onTap: (){
                        Get.to(DropOrPick());
                      },
                      child: Image.asset(
                        "assets/images/thobe.png",height: 65.h,
                      ),
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
