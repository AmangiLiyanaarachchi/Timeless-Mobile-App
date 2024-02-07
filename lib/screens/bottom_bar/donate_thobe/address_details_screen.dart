import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/screens/bottom_bar/donate_thobe/pick_up_screen.dart';
import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/multiline_text_field.dart';
import '../notifications_screen.dart';

class AddressDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ///bg
              Image.asset(
                "assets/images/home_bg.png",
                height: double.maxFinite,
                width: double.maxFinite,
                fit: BoxFit.fill,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///top bar
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      color: ColorConstants.yellowLevel1,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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

                              ///Drop off
                              Container(
                                height: 5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Center(
                                    child: Text(
                                  "Drop off",
                                  style: TextStyle(fontSize: 13.sp),
                                )),
                              ),
                              Spaces.y2,

                              ///Pick up
                              GestureDetector(
                                onTap: () {
                                  Get.to(PickUpScreen());
                                },
                                child: Container(
                                  height: 5.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: Colors.white),
                                  child: Center(
                                      child: Text(
                                    "Pick up",
                                    style: TextStyle(fontSize: 13.sp),
                                  )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Spaces.y2,

                      ///number
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.none,
                        onTextChange: (val) {},
                        hasMargin: false,
                        title: "Number:",
                        hint: "+974",
                        height: 6.h,
                        borderColor: ColorConstants.grayLevel15,
                        paddingHor: 3.w,
                      ),
                      Spaces.y2,

                      ///address:
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.sentences,
                        onTextChange: (val) {},
                        hasMargin: false,
                        title: "Address::",
                        hint: "Street",
                        height: 6.h,
                        borderColor: ColorConstants.grayLevel15,
                        paddingHor: 3.w,
                      ),

                      ///House:
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.sentences,
                        onTextChange: (val) {},
                        hasMargin: false,
                        hint: "House",
                        height: 6.h,
                        borderColor: ColorConstants.grayLevel15,
                        paddingHor: 3.w,
                      ),

                      ///Post Code:
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.none,
                        onTextChange: (val) {},
                        hasMargin: false,
                        hint: "Post Code",
                        height: 6.h,
                        borderColor: ColorConstants.grayLevel15,
                        paddingHor: 3.w,
                      ),
                      Spaces.y2,

                      ///Pick up time
                      Text(
                        "Pick up time:",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),

                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.none,
                        onTextChange: (val) {},
                        hasMargin: false,
                        hint: "Eg. 14:30",
                        height: 6.h,
                        borderColor: ColorConstants.grayLevel15,
                        paddingHor: 3.w,
                      ),
                      Spaces.y4,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
