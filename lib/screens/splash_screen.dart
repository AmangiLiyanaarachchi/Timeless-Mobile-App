import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/models/AdminModel.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/bottom_bar_screen.dart';
import 'package:timeless/screens/Customer_screens/auth/signin_customer.dart';
import '../controllers/call_controllers.dart';
import '../models/UserModel.dart';
import 'Customer_screens/BottomBarNew/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.off(CustomerSignIn());
      } else {
        DocumentSnapshot adminData = await FirebaseFirestore.instance
            .collection('Admins')
            .doc(auth.currentUser!.uid)
            .get();
        if (adminData.exists) {
          loginController.activeAdmin.value =
              AdminModel.fromMap(adminData.data() as Map<String, dynamic>);
          Get.offAll(BottomBarScreenAdmin());
        } else {
          DocumentSnapshot custData = await FirebaseFirestore.instance
              .collection('Customers')
              .doc(auth.currentUser!.uid)
              .get();
          if (custData.exists && auth.currentUser!.emailVerified) {
            loginController.userModel.value =
                UserModel.fromMap(custData.data() as Map<String, dynamic>);
            bottombarController.selectedIndex.value = 0;
            Get.offAll(BottomBarScreen1());
          }
          else {
            Get.to(CustomerSignIn());
          }
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[
              Color(0xff5C1616),
              Color(0xff703333),
              Color(0xff937070),
              Color(0xff9F8787),
            ],
          ),
        ),
        child: Stack(children: [
          Image.asset("assets/images/Rectangle46.png"),
          Padding(
            padding: const EdgeInsets.only(left: 38.0, top: 68),
            child: Image.asset("assets/images/Rectangle54.png"),
          ),
          Center(child: Image.asset("assets/images/timelesslogo1.png")),
          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset("assets/images/Rectangle55.png")),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 128.0),
                child: Image.asset("assets/images/Rectangle56.png"),
              )),
        ]),
      )),
    );
  }
}
