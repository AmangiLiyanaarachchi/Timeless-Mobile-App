import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/screens/settings/settings_screen.dart';

import '../../utils/space_values.dart';
import 'notifications_screen.dart';

class SaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spaces.y1,

          ///top bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(NotificationsScreen());
                    },
                    child: Icon(
                      CupertinoIcons.bell_fill,
                      color: Colors.black,
                    )),
                GestureDetector(
                    onTap: () {
                      Get.to(SettingsScreen());
                    },
                    child: Icon(Icons.settings)),
              ],
            ),
          ),

          ///tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Shop',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Like',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Saved',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Review',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Spaces.y1,

          ///divider
          Stack(
            children: [
              Container(
                width: 100.w,
                height: 1,
                color: Colors.black,
              ),
              Container(
                width: 24.w,
                height: 2,
                color: Colors.black,
              ),
            ],
          ),

          Spaces.y3,

          ///detailer
          Row(
            children: [
              Spaces.x5,
              Image.asset(
                'assets/images/men.png',
                width: 24.w,
              ),
              Spaces.x3,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Pelebigfan',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: Colors.black),
                      ),
                      Spaces.x8,
                      Image.asset(
                        'assets/images/verify.png',
                        width: 8.w,
                      ),
                      Spaces.x8,
                      Image.asset(
                        'assets/images/fav.png',
                        width: 7.w,
                      ),
                    ],
                  ),
                  //Spaces.y1,

                  Text(
                    '@shopfootball',
                    style: TextStyle(fontSize: 8.sp, color: Colors.black),
                  ),
                  Spaces.y1,

                  Row(
                    children: [
                      Image.asset(
                        'assets/images/stars.png',
                        width: 17.w,
                      ),
                      Spaces.x3,
                      Text('(100)')
                    ],
                  )
                ],
              )
            ],
          ),
          Spaces.y3,

          ///oline today
          Row(
            children: [
              Spaces.x7,
              Text(
                'ONLINE TODAY',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                'You have bought from this seller\nbefore!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500),
              ),
              Spaces.x7,
            ],
          ),
          Spaces.y2,

          ///followers
          Row(
            children: [
              Spaces.x7,
              Text(
                '2000\nFollowers',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500),
              ),
              Spaces.x9,
              Text(
                '100\nFollowing',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500),
              ),
              Spaces.x7,
            ],
          ),
          Spaces.y2,

          ///images
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              shrinkWrap: true,
              children: List.generate(
                20,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      child: Image.asset('assets/images/shirt1.png'),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
