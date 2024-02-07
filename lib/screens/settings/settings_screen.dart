import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/color_constants.dart';
import 'package:timeless/screens/settings/preferences_screen.dart';
import 'package:timeless/screens/settings/privacy_screen.dart';
import 'package:timeless/screens/settings/resolution_centre_screen.dart';
import 'package:timeless/widgets/custom_elevated_button.dart';

import '../../utils/space_values.dart';
import 'deliver_to_screen.dart';
import 'faqs_screen.dart';

class SettingsScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Spaces.x10,
                    Spaces.x3,
                    Text(
                      "Settings ",
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Spaces.y3,
              Text(
                "    My account ",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              Spaces.y3,

              ///details

              GestureDetector(
                  onTap: () {
                    Get.to(PreferencesScreen());
                  },
                  child: item("Preferences")),
              GestureDetector(
                  onTap: () {
                    Get.to(DeliverToScreen());
                  },
                  child: item("Shipping Location")),
              GestureDetector(
                  onTap: () {
                    Get.to(ResolutionCentreScreen());
                  },
                  child: item("Resolution Centre")),
              GestureDetector(
                  onTap: () {
                    Get.to(FAQsScreen());
                  },
                  child: item("Need Help?")),
              Spaces.y1,
              GestureDetector(
                onTap: () {
                  Get.to(PrivacyScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 6.w),
                  child: Row(
                    children: [
                      Text(
                        "Privacy",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_back),
                    ],
                  ),
                ),
              ),
              Spacer(),

              ///log out
              CustomElevatedButton(
                onPress: () async {
                  await GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();
                  // FacebookAuth.instance.logOut();
                  auth.signOut().then((value) {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginEmail()));
                  }).onError((error, stackTrace) {
                    Fluttertoast.showToast(msg: error.toString());
                  });
                },
                title: "Log out",
                borderRadius: 0,
                bgColor: ColorConstants.maroon,
                height: 7.h,
                fontWeight: FontWeight.w600,
              ),
              Spaces.y5,
            ],
          ),
        ),
      ),
    );
  }

  Widget item(title) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Column(
        children: [
          Spaces.y1,
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp),
                ),
                Spacer(),
                Icon(Icons.arrow_back),
              ],
            ),
          ),
          Spaces.y2,
          Container(
            height: 0.1.h,
            width: double.maxFinite,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
