import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../BottomBarNew/bottom_bar.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late Timer timer;
  final auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    user!.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer.cancel();
      Get.to(BottomBarScreen1());

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return SelectCategory();
      //   }),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/animations/send_email.json"),
              Spaces.y3,
              Text(
                "An email has been sent to ${user!.email}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.primaryColor),
                textAlign: TextAlign.center,
              ),
              Spaces.y1,
              Text(
                "Please verify to continue!!",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.primaryColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
