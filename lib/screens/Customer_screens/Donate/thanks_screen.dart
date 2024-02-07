import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/Constants/firebase_consts.dart';
import 'package:timeless/screens/Customer_screens/BottomBarNew/bottom_bar.dart';

import '../../../Constants/color_constants.dart';
import '../../../Constants/font_styles.dart';
import '../../../models/DonationModel.dart';
import '../../../utils/space_values.dart';

class ThanksScreen extends StatefulWidget {
  const ThanksScreen({super.key, required this.pId});
  final dynamic pId;

  @override
  State<ThanksScreen> createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen> {
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      Get.to(BottomBarScreen1());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
          title: Text(
            "Timeless",
            style: FontStyles.appBarStylePC,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.notifications,
                color: ColorConstants.primaryColor,
                size: 30,
              ),
            )
          ],
        ),
        body: SizedBox(
            child: SingleChildScrollView(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spaces.y7,
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Customers')
                                    .doc(auth.currentUser!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Show a loading indicator while fetching data.
                                  }

                                  if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return Text(
                                        "User not found"); // Handle the case when user data is not found.
                                  }

                                  final userData = snapshot.data?.data();
                                  final userName = userData?["fullname"];
                                  // final userProfilePicture =
                                  // userData?["profilepic"];

                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 55.0),
                                    child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "Thank you ",
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColor,
                                                  fontSize: 17)),
                                          TextSpan(
                                              text: "${userName} ",
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                          TextSpan(
                                              text: "for donating your thobe",
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColor,
                                                  fontSize: 17)),
                                        ])),
                                  );
                                  //Text("Thank you ${userName} for donating your thobe" );
                                },
                              ),
                              Spaces.y9,
                              StreamBuilder(
                                  stream: firestore
                                      .collection("Donations")
                                      .doc(widget.pId)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    } else {
                                      if (snapshot.data!.exists) {
                                        DonationModel donation =
                                            DonationModel.fromMap(
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>);

                                        return Container(
                                            width: 75.w,
                                            height: 50.h,
                                            child: Image.network(
                                              donation.prodImg[0],
                                              fit: BoxFit.cover,
                                            ));
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }
                                  }),
                            ]))))));
  }
}
