import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../notifications_screen.dart';
import 'address_details_screen.dart';
import 'drop_off_screen.dart';

class DropOrPick extends StatelessWidget {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
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

                            ///Drop off
                            GestureDetector(
                              onTap: () {
                                Get.to(DropOofScreen());
                              },
                              child: Container(
                                height: 5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: Colors.white),
                                child: Center(
                                    child: Text(
                                  "Drop off",
                                  style: TextStyle(fontSize: 13.sp),
                                )),
                              ),
                            ),
                            Spaces.y2,

                            ///Pick up
                            GestureDetector(
                              onTap: () {
                                Get.to(AddressDetailsScreen());
                              },
                              child: Container(
                                height: 5.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
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
                    Spacer(),

                    Container(
                      width: 80.w,
                      height: 35.h,
                      child: GoogleMap(
                        initialCameraPosition: _kGooglePlex,
                        onTap: (latlng) {
                          //Get.to(LocationListScreen());
                        },
                        onMapCreated: (GoogleMapController controller) {},
                      ),
                    ),
                    Spaces.y5,
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
