import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/screens/Customer_screens/Donate/donate_thobe.dart';
import '../../../Constants/color_constants.dart';
import '../../../Constants/font_styles.dart';
import '../../../controllers/call_controllers.dart';
import '../../../utils/space_values.dart';
import '../../../utils/utility_const.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/multiline_text_field.dart';
import '../../bottom_bar/notifications_screen.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
          title: Text(
            "List your product",
            style: FontStyles.appBarStylePC,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: () {
                  Get.to(NotificationsScreen());
                },
                child: Icon(
                  Icons.notifications,
                  color: ColorConstants.primaryColor,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        drawer: CustomDrawer(),
        body: Form(
            key: _key,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  Spaces.y5,
                  SizedBox(
                    width: 84.w,
                    child: Obx(
                      () => GestureDetector(
                        onTap: () async {
                          if (imagePickerController.pickedImgPaths.isNotEmpty) {
                            await imagePickerController.pickImages();
                          }
                        },
                        child: Text(
                          imagePickerController.pickedImgPaths.isNotEmpty
                              ? "Change Pictures"
                              : "Pick Images",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  Spaces.y1,
                  Obx(
                    //using smae form for edit and delete so checking both conditions
                    () => imagePickerController.pickedImgPaths.isNotEmpty
                        ? CarouselSlider.builder(
                            itemCount:
                                imagePickerController.pickedImgPaths.length,
                            itemBuilder: (c, index, realIndex) {
                              return Image.file(
                                File(imagePickerController
                                    .pickedImgPaths[index]),
                                width: double.infinity,
                                fit: BoxFit.scaleDown,
                              );
                            },
                            options: CarouselOptions(
                                padEnds: true,
                                aspectRatio: 10 / 6,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                enableInfiniteScroll: true,
                                initialPage: 0,
                                viewportFraction: 0.45),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await imagePickerController.pickImages();
                            },
                            child: Container(
                              height: 17.h,
                              width: 43.w,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(236, 228, 228, 1),
                                borderRadius: BorderRadius.circular(7.sp),
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 50.sp,
                                color: ColorConstants.primaryColor,
                              ),
                            ),
                          ),
                  ),
                  Spaces.y3,
                  CustomMultilineTextField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    onTextChange: (value) {},
                    textInputType: TextInputType.name,
                    //hasMargin: false,
                    capitalization: TextCapitalization.words,
                    title: "Name",
                    hint: "Enter product name",
                    backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                    controller: productController.pnameController,
                  ),
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
                    //hasMargin: false,
                    capitalization: TextCapitalization.words,
                    title: "Category",
                    hint: "e.g. Jackets, Shirts, Sweaters, Dresses, Jeans etc.",
                    backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                    controller: productController.categoryController,
                  ),
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
                    //hasMargin: false,
                    capitalization: TextCapitalization.words,
                    title: "Size",
                    hint: "e.g. Small, Medium, Large or Extra Large",
                    backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                    controller: productController.sizeController,
                  ),
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
                    //hasMargin: false,
                    capitalization: TextCapitalization.words,
                    title: "Color",
                    hint: "e.g. white, black, blue, red etc.",
                    backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                    controller: productController.colorController,
                  ),
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
                    //hasMargin: false,
                    capitalization: TextCapitalization.words,
                    title: "What is product brand?",
                    hint: "e.g. Nike, Adidas, Puma etc.",
                    backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                    controller: productController.brandController,
                  ),
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
                    //hasMargin: false,
                    capitalization: TextCapitalization.words,
                    title: "Product Condition have you used this product?",
                    hint: "",
                    backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                    controller: productController.timeController,
                  ),
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
                    //hasMargin: false,
                    capitalization: TextCapitalization.words,
                    title: "Does it come with receipt/box?",
                    hint: "Yes/No",
                    backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                    controller: productController.receiptController,
                  ),
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
                    //hasMargin: false,
                    capitalization: TextCapitalization.words,
                    title: "Description",
                    hint: "Enter text",
                    maxLines: 7,
                    backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                    controller: productController.descriptionController,
                  ),
                  Spaces.y2,
                  CustomElevatedButton(
                    onPress: () async {
                      // _createProduct(context);
                      // uploadData(context);
                      validateData(context);
                    },
                    height: 6.5.h,
                    title: "List",
                    titleColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    bgColor: ColorConstants.primaryColor,
                    borderRadius: 7,
                  ),
                  Spaces.y3,
                ]))));
  }

  Future<void> validateData(BuildContext context) async {
    if (imagePickerController.pickedImgPaths.length < 2 ||
        productController.pnameController.text.isEmpty ||
        productController.categoryController.text.isEmpty ||
        productController.sizeController.text.isEmpty ||
        productController.colorController.text.isEmpty ||
        productController.timeController.text.isEmpty ||
        productController.receiptController.text.isEmpty ||
        productController.descriptionController.text.isEmpty) {
      hideLoading();
      showErrorSnack("Attention",
          "Please add at least two images and fill in all required details.");
    } else {
      Get.to(DonateThobe());
    }
  }
}
