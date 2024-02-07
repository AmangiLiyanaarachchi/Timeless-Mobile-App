import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../utils/space_values.dart';
import '../../widgets/custom_elevated_button.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [

              ///top bar
              Column(
                children: [
                  Spaces.y2,
                  Text(
                    "Privacy ",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Spaces.y2,
                  Container(
                    height: 0.2.h,
                    width: double.maxFinite,
                    color: Colors.black,
                  ),
                ],
              ),
              Spaces.y3,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [




                    ///p_advertising
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personalised advertising",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,)
                            ),
                            Spaces.y1,
                            Text(
                              "Allows Timeless to share my data to personalise\n my ad experience",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp),
                            ),
                          ],
                        ),
                        Spacer(),

                        Switch(
                          onChanged: null,
                          value: false,
                          activeColor: ColorConstants.maroon,
                          activeTrackColor: ColorConstants.maroon,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.withOpacity(0.4),
                        )
                      ],
                    ),
                    Spaces.y4,
                    Container(
                      height: 0.1.h,
                      width: double.maxFinite,
                      color: Colors.black,
                    ),
                    Spaces.y3,

                    ///Site customisation
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Site customisation",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,)
                            ),
                            Spaces.y1,
                            Text(
                              "Allows Timeless to use cookies to personalise my\ncontent, and remember my account and regional\npreferences",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp),
                            ),
                          ],
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
                    Spaces.y4,
                    Container(
                      height: 0.1.h,
                      width: double.maxFinite,
                      color: Colors.black,
                    ),
                    Spaces.y4,

                    ///required cookies and technology
                    Row(
                      children: [
                        Text(
                          "Required cookies & technologies",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                        Spacer(),
                        Text(
                          "Always on",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp),
                        ),
                      ],
                    ),
                    Spaces.y5,
                    Container(
                      height: 0.1.h,
                      width: double.maxFinite,
                      color: Colors.black,
                    ),
                    Spaces.y1,

                    ///SAVE
                    CustomElevatedButton(
                      title: "SAVE",
                      borderRadius: 0,
                      bgColor: ColorConstants.maroon,
                      height: 7.h,
                      fontWeight: FontWeight.w600,
                    ),
                    Spaces.y1,
                    Container(
                      height: 0.1.h,
                      width: double.maxFinite,
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
