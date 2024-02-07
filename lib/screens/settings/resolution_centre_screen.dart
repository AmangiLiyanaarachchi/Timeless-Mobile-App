import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_constants.dart';
import '../../utils/space_values.dart';
import '../../widgets/multiline_text_field.dart';

class ResolutionCentreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Spaces.x8,
                    Text(
                      "Resolution Centre ",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Spaces.y2,

              Center(
                child: Text("Have an issue with the app?",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    )),
              ),
              Spaces.y5,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Enquiry
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Enquiry",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          height: 4.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: ColorConstants.redLevel4.withOpacity(0.3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("DELIVERY"),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_drop_down_sharp))
                            ],
                          ),
                        )
                      ],
                    ),

                    ///name
                    Row(
                      children: [
                        Column(
                          children: [
                            Spaces.y3,
                            Text(
                              "Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Spaces.x10,
                        CustomMultilineTextField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                          capitalization: TextCapitalization.words,
                          onTextChange: (val) {},
                          hasMargin: false,
                          height: 5.h,
                          width: 65.w,
                          borderColor: Colors.black,
                          paddingHor: 2.w,
                          paddingVer: 1.h,
                        ),
                      ],
                    ),

                    ///email
                    Row(
                      children: [
                        Column(
                          children: [
                            Spaces.y3,
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Spaces.x10,
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
                          height: 5.h,
                          width: 65.w,
                          borderColor: Colors.black,
                          paddingHor: 2.w,
                          paddingVer: 1.h,
                        ),
                      ],
                    ),
                    Spaces.y4,

                    ///Description
                    Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
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
                      // height: 20.h,
                      width: 85.w,
                      height: 40.h,
                      maxLinesDisabled: false,
                      maxLines: 8,
                      borderColor: Colors.black,
                      paddingHor: 2.w,
                      hint: "Write a brief description about your problem.",
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
