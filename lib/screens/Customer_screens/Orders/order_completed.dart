import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeless/screens/Customer_screens/BottomBarNew/bottom_bar.dart';
import '../../../Constants/color_constants.dart';
import '../../../constants/font_styles.dart';
import '../../../controllers/call_controllers.dart';
import '../../../utils/space_values.dart';

class OrderCompleted extends StatefulWidget {
  const OrderCompleted({super.key});

  @override
  State<OrderCompleted> createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () async {
              bottombarController.selectedIndex.value = 0;
              Get.offAll(BottomBarScreen1());
            },
            icon: Icon(Icons.arrow_back)),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
        title: Text(
          "Order Completed",
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
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/completed.png"),
            Spaces.y1,
            Text(
                "Your Purchase is Complete! Please Get in Touch With The Seller to Claim Your Products",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.green)),
            Spaces.y1,
            InkWell(
              onTap: () async {
                bottombarController.selectedIndex.value = 0;
                Get.offAll(BottomBarScreen1());
              },
              child: Text(
                "Go to Products Page",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.primaryColor,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
