import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/screens/Customer_screens/Donate/thanks_screen.dart';

import '../../../Constants/color_constants.dart';
import '../../../Constants/firebase_consts.dart';
import '../../../Constants/font_styles.dart';
import '../../../models/DonationModel.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_elevated_button.dart';

class DonateThobePickup extends StatefulWidget {
  const DonateThobePickup({
    super.key,
    required this.pId,
  });
  final dynamic pId;

  @override
  State<DonateThobePickup> createState() => _DonateThobePickupState();
}

class _DonateThobePickupState extends State<DonateThobePickup> {
  List<DropdownMenuItem<Object>> items = [];
  @override
  Widget build(BuildContext context) {
    print("prod Id:: ${widget.pId}");
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
          title: Text(
            "Donate Thobe",
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
                              Spaces.y5,
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

                                        return GestureDetector(
                                          onTap: () {},
                                          child: ProductCard(
                                            donatedProd: donation,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }
                                  }),
                              Spaces.y5,
                              Image.asset("assets/images/completed.png"),
                              Spaces.y2,
                              Text("We will call you once we arrive",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.green)),
                              Text("We cannot wait!",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.primaryColor)),
                              Spaces.y3,
                              CustomElevatedButton(
                                onPress: () async {
                                  Get.to(ThanksScreen(
                                    pId: widget.pId,
                                  ));
                                },
                                height: 6.5.h,
                                title: "Proceed",
                                titleColor: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                bgColor: ColorConstants.primaryColor,
                                borderRadius: 7,
                              ),
                            ]))))));
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.donatedProd,
  });
  final DonationModel donatedProd;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 30.h,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.primaryColor),
          borderRadius: BorderRadius.circular(8.sp)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 30.w,
                  height: 30.h,
                  child: Image.network(
                    donatedProd.prodImg[0],
                    fit: BoxFit.cover,
                  )),
              Spaces.x3,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name:",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.primaryColor,
                            fontWeight: FontWeight.w500,
                          )),
                      // SizedBox(width: 25.w),
                      Spaces.x4,
                      Text("${donatedProd.prodName}",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.primaryColor,
                          )),
                    ],
                  ),
                  Spaces.y2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Color:",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.primaryColor,
                            fontWeight: FontWeight.w500,
                          )),
                      //SizedBox(width: 25.w),
                      Spaces.x5,
                      Text(
                        "${donatedProd.color}",
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Spaces.y2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Category:",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.primaryColor,
                            fontWeight: FontWeight.w500,
                          )),
                      //SizedBox(width: 25.w),
                      Spaces.x5,
                      Text(
                        "${donatedProd.category}",
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Spaces.y2,
                ],
              )
            ]),
      ),
    );
  }
}
