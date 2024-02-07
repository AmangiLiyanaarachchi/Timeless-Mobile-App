import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/space_values.dart';

class DeliverToScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:

          ///top bar
          Column(
        children: [
          Spaces.y2,
          Row(
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
                "Deliver To",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spaces.y3,
          Container(
            height: 0.2.h,
            width: double.maxFinite,
            color: Colors.black,
          ),
          Spaces.y3,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/qatar.png",
                  width: 18.w,
                ),
                Spaces.x5,
                Text(
                  "Qatar",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
