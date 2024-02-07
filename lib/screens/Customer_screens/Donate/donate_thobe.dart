import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/screens/Customer_screens/Donate/donate_thobe_pickup.dart';

import '../../../Constants/color_constants.dart';
import '../../../Constants/firebase_consts.dart';
import '../../../Constants/font_styles.dart';
import '../../../utils/notification_services.dart';
import '../../../utils/space_values.dart';
import '../../../utils/utility_const.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/multiline_text_field.dart';

class DonateThobe extends StatefulWidget {
  const DonateThobe({
    super.key,
  });

  @override
  State<DonateThobe> createState() => _DonateThobeState();
}

List<String> num = ["1", "2", "3"];

bool visible = false;
bool isvisible = true;

class _DonateThobeState extends State<DonateThobe> {
  NotificationServices notificationServices = NotificationServices();

  var prodId = "";
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                              Container(
                                height: 30.h,
                                width: width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorConstants.primaryColor),
                                    borderRadius: BorderRadius.circular(8.sp)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: 30.w,
                                            height: 30.h,
                                            child: Image.file(
                                              File(imagePickerController
                                                  .pickedImgPaths[0]),
                                              fit: BoxFit.cover,
                                            )),
                                        Spaces.x3,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Name:",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: ColorConstants
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                                // SizedBox(width: 25.w),
                                                Spaces.x4,
                                                Text(
                                                    "${productController.pnameController.text}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: ColorConstants
                                                          .primaryColor,
                                                    )),
                                              ],
                                            ),
                                            Spaces.y2,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Color:",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: ColorConstants
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                                //SizedBox(width: 25.w),
                                                Spaces.x5,
                                                Text(
                                                  "${productController.colorController.text}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ColorConstants
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spaces.y2,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Category:",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: ColorConstants
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                                //SizedBox(width: 25.w),
                                                Spaces.x5,
                                                Text(
                                                  "${productController.categoryController.text}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: ColorConstants
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spaces.y2,
                                            Text("Please choose one:",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: ColorConstants
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                            Spaces.y1,
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedIndex = 1;
                                                      isvisible = !isvisible;
                                                    });
                                                    if (selectedIndex == 1) {
                                                      productController
                                                              .selectedMode =
                                                          "Drop off";
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 4.h,
                                                    width: 20.w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      color: selectedIndex == 1
                                                          ? ColorConstants
                                                              .primaryColor
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Center(
                                                      child: Text("Drop off",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: selectedIndex ==
                                                                    1
                                                                ? Colors.white
                                                                : ColorConstants
                                                                    .primaryColor,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                Spaces.x3,
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      // visible = !visible;
                                                      isvisible = !isvisible;
                                                      selectedIndex = 2;
                                                    });
                                                    if (selectedIndex == 2) {
                                                      productController
                                                              .selectedMode =
                                                          "Pick up";
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 4.h,
                                                    width: 20.w,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      color: selectedIndex == 2
                                                          ? ColorConstants
                                                              .primaryColor
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Center(
                                                      child: Text("Pick up",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: selectedIndex ==
                                                                    2
                                                                ? Colors.white
                                                                : ColorConstants
                                                                    .primaryColor,
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                              Spaces.y5,
                              Visibility(
                                  visible: isvisible ? true : false,
                                  child: Image.asset("assets/images/map.png")),
                              Spaces.y1,
                              Visibility(
                                  visible: isvisible ? false : true,
                                  child: Column(
                                    children: [
                                      Spaces.y2,
                                      CustomMultilineTextField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onTextChange: (value) {},
                                        textInputType: TextInputType.name,
                                        hasMargin: false,
                                        capitalization:
                                            TextCapitalization.words,
                                        title: "Phone Number",
                                        hint:
                                            "Enter phone number with country code(e.g. +92)",
                                        backgroundColor:
                                            Color.fromRGBO(158, 119, 119, 0.2),
                                        controller:
                                            productController.numberController,
                                      ),
                                      Spaces.y1,
                                      CustomMultilineTextField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onTextChange: (value) {},
                                        textInputType: TextInputType.name,
                                        hasMargin: false,
                                        capitalization:
                                            TextCapitalization.words,
                                        title: "Address",
                                        hint: "Enter complete address",
                                        maxLines: 3,
                                        backgroundColor:
                                            Color.fromRGBO(158, 119, 119, 0.2),
                                        controller:
                                            productController.addressController,
                                      ),
                                      Spaces.y1,
                                      CustomMultilineTextField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onTextChange: (value) {},
                                        textInputType: TextInputType.text,
                                        hasMargin: false,
                                        capitalization:
                                            TextCapitalization.words,
                                        title: "Postal code",
                                        hint: "Enter your area's postal code",
                                        backgroundColor:
                                            Color.fromRGBO(158, 119, 119, 0.2),
                                        controller:
                                            productController.codeController,
                                      ),
                                      Spaces.y1,
                                    ],
                                  )),
                              Spaces.y3,
                              CustomElevatedButton(
                                onPress: () async {
                                  selectedIndex == 2
                                      ? _confirmDetails(context)
                                      : productController
                                          .donateProduct(context);
                                  // selectedIndex ==1 ? Get.to(DonateThobeDropoff()) : Get.to(DonateThobePickup());
                                },
                                height: 6.5.h,
                                title: "Donate!",
                                titleColor: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                bgColor: ColorConstants.primaryColor,
                                borderRadius: 7,
                              ),
                              Spaces.y3,
                            ]))))));
  }

  Future<void> _confirmDetails(BuildContext context) async {
    setLoading();

    if (productController.numberController.text.isEmpty ||
        productController.addressController.text.isEmpty ||
        productController.codeController.text.isEmpty) {
      hideLoading();
      showErrorSnack("Attention", "Some details are missing.");
    } else {
      setLoading();
      prodId = await productController.uploadDonation(context);
      //productController.uploadDonation(context);
      uploadData(context, prodId);
      hideLoading();
    }
  }

  uploadData(BuildContext context, String prodId) async {
    //productController.uploadDonation(context);

    String phonenumber = productController.numberController.text;
    String address = productController.addressController.text;
    String code = productController.codeController.text;
    try {
      Map<String, dynamic> userData = {
        'phoneNumber': phonenumber,
        'Address': address,
        'PostalCode': code
      };
      await firestore
          .collection("Donations")
          .doc(prodId)
          .collection("PickUp")
          .add(userData)
          .then((value) => debugPrint(""));

      //productController.uploadDonation(context);
      // DocumentSnapshot snapshot =
      //     await firestore.collection("Admins").doc(adminId).get();
      // AdminModel admin =
      //     AdminModel.fromMap(snapshot.data() as Map<String, dynamic>);
      // notificationServices.sendNotification(
      //     loginController.userModel.value.fullname,
      //     admin.token,
      //     "Someone sent a donation!",
      //     admin.uid,
      //     "",
      //     "thobe");

      resetParams();

      hideLoading();

      //Get.offNamed('/viewProduct');
      Get.to(DonateThobePickup(pId: prodId));
    } catch (e) {
      print("error occured ${e}");
    }
  }

  resetParams() {
    // Reset TextEditingController objects
    productController.numberController.clear();
    productController.addressController.clear();
    productController.codeController.clear();
  }
}

class DropdownButtonex extends StatefulWidget {
  const DropdownButtonex({super.key});

  @override
  State<DropdownButtonex> createState() => _DropdownButtonexState();
}

class _DropdownButtonexState extends State<DropdownButtonex> {
  String dropdownValue = num.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.3.h,
      decoration: BoxDecoration(
          color: Color.fromRGBO(158, 119, 119, 0.2),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(
            Icons.arrow_drop_down_sharp,
            color: ColorConstants.primaryColor,
          ),

          //elevation: 16,
          style:
              const TextStyle(color: ColorConstants.primaryColor, fontSize: 15),
          underline: Container(),

          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: num.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
