import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/color_constants.dart';
import 'package:timeless/constants/font_styles.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/models/BrandModel.dart';
import 'package:timeless/models/CategoryModel.dart';
import 'package:timeless/models/ColorModel.dart';
import 'package:timeless/models/temp/sizes.dart';
import 'package:timeless/utils/utility_const.dart';
import 'package:timeless/widgets/multiline_text_field.dart';
import '../../../../Constants/firebase_consts.dart';
import '../../../../utils/space_values.dart';
import '../../../../widgets/custom_gradient_button.dart';
import '../../../bottom_bar/notifications_screen.dart';
import '../Donations.dart';

class CreateProductForm extends StatefulWidget {
  const CreateProductForm({super.key, this.index});
  final int?
      index; //to track from which page this is called - differentiating b/w edit/add product requests

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final _prodKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 10.w,
        leading: widget.index == 0
            ? IconButton(
                onPressed: () async {
                  await productController.resetParams();
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorConstants.primaryColor,
                ))
            : InkWell(
                onTap: () {
                  Get.to(Donations());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 3.0.w),
                  child: Image.asset(
                    "assets/images/donate1.png",
                    color: ColorConstants.primaryColor,
                  ),
                )),
        title: Text(
          widget.index == 0 ? "Edit Product" : "Create Product",
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
        actions: [
          widget.index == 0
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(right: 4.0.w),
                  child: InkWell(
                      onTap: () {
                        Get.to(NotificationsScreen());
                      },
                      child: Icon(
                        Icons.notifications,
                        color: ColorConstants.primaryColor,
                        size: 22.sp,
                      )),
                )
        ],
      ),
      body: Form(
          key: _prodKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 84.w,
                  child: Obx(
                    () => GestureDetector(
                      onTap: () async {
                        if (imagePickerController.pickedImgPaths.isNotEmpty ||
                            productController.existingDownloadUrls.isNotEmpty) {
                          await imagePickerController.pickImages();
                        }
                      },
                      child: Text(
                        imagePickerController.pickedImgPaths.isNotEmpty ||
                                productController
                                    .existingDownloadUrls.isNotEmpty
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
                  () => imagePickerController.pickedImgPaths.isNotEmpty ||
                          productController.existingDownloadUrls.isNotEmpty
                      ? CarouselSlider.builder(
                          itemCount: imagePickerController
                                  .pickedImgPaths.isNotEmpty
                              ? imagePickerController.pickedImgPaths.length
                              : productController.existingDownloadUrls.length,
                          itemBuilder: (c, index, realIndex) {
                            return imagePickerController
                                    .pickedImgPaths.isNotEmpty
                                ? Image.file(
                                    File(imagePickerController
                                        .pickedImgPaths[index]),
                                    width: double.infinity,
                                    fit: BoxFit.scaleDown,
                                  )
                                : Image.network(
                                    productController
                                        .existingDownloadUrls[index],
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
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () async {
                              await imagePickerController.pickImages();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 8.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: Icon(
                                Icons.image,
                                size: 7.h,
                                color: Colors.grey.shade500,
                              ),
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
                  capitalization: TextCapitalization.words,
                  title: "Product Name",
                  hint: "Enter text",
                  controller: productController.nameController,
                ),
                Spaces.y2,
                CustomMultilineTextField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  capitalization: TextCapitalization.sentences,
                  onTextChange: (value) {},
                  title: "SKU",
                  hint: "Enter text",
                  controller: productController.skuController,
                ),
                Spaces.y2,
                SizedBox(
                  width: 84.w,
                  child: Text(
                    "Product",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                Spaces.y1,
                SizedBox(
                  width: 85.w,
                  child: StreamBuilder(
                      stream: firestore
                          .collection("Categories")
                          .where("enabled", isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        } else {
                          if (snapshot.data!.docs.isNotEmpty) {
                            List catTemp = snapshot.data!.docs.map((doc) {
                              return doc[
                                  'title']; // Replace 'name' with the field name containing your category names
                            }).toList();
                            List<String> categoryNames = catTemp.cast();
                            return DropdownButtonFormField<String>(
                                items: categoryNames.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: FontStyles.smallBlackBodyText,
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.3.h, horizontal: 3.5.w),
                                  hintText: productController
                                          .currentCategory.isNotEmpty
                                      ? productController.currentCategory
                                      : "Select product type",
                                  hintStyle: FontStyles.blackBodyText,
                                  labelStyle: FontStyles.blackBodyText,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade100,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                  ),
                                ),
                                onChanged: (value) async {
                                  QuerySnapshot snapshot = await firestore
                                      .collection("Categories")
                                      .where("title", isEqualTo: value)
                                      .limit(1)
                                      .get();

                                  CategoryModel selCategory =
                                      CategoryModel.fromMap(snapshot.docs[0]
                                          .data() as Map<String, dynamic>);
                                  setState(() {
                                    productController.selectedUid =
                                        selCategory.uid;
                                    productController.selectedCatName =
                                        selCategory.title;
                                  });
                                });
                          } else {
                            return const SizedBox.shrink();
                          }
                        }
                      }),
                ),
                Spaces.y2,
                SizedBox(
                  width: 84.w,
                  child: Text(
                    "Brand",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                Spaces.y1,
                SizedBox(
                  width: 85.w,
                  child: StreamBuilder(
                      stream: firestore.collection("Brands").snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink();
                        } else {
                          List brandTemp = snapshot.data!.docs.map((doc) {
                            return doc[
                                'title']; // Replace 'name' with the field name containing your category names
                          }).toList();
                          List<String> brandsList = brandTemp.cast();
                          return DropdownButtonFormField<String>(
                              items: brandsList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: FontStyles.smallBlackBodyText,
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2.3.h, horizontal: 3.5.w),
                                hintText:
                                    productController.currentBrand.isNotEmpty
                                        ? productController.currentBrand
                                        : "Select brand",
                                hintStyle: FontStyles.blackBodyText,
                                labelStyle: FontStyles.blackBodyText,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade100,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                              ),
                              onChanged: (value) async {
                                QuerySnapshot snapshot = await firestore
                                    .collection("Brands")
                                    .where("title", isEqualTo: value)
                                    .limit(1)
                                    .get();
                                BrandModel selBrand = BrandModel.fromMap(
                                    snapshot.docs[0].data()
                                        as Map<String, dynamic>);
                                setState(() {
                                  productController.selectedBrandId =
                                      selBrand.uid;
                                });
                              });
                        }
                      }),
                ),
                Spaces.y2,
                CustomMultilineTextField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  capitalization: TextCapitalization.none,
                  onTextChange: (value) {},
                  textInputType: TextInputType.number,
                  title: "Quantity",
                  hint: "Enter text",
                  controller: productController.quantityController,
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
                  textInputType: TextInputType.number,
                  capitalization: TextCapitalization.none,
                  title: "Price",
                  hint: "Enter text",
                  controller: productController.priceController,
                ),
                Spaces.y2,
                SizedBox(
                  width: 84.w,
                  child: Text(
                    "Available Sizes",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                Spaces.y1,
                productController.selectedCatName != "Footwear" &&
                        productController.currentCategory != "Footwear"
                    ? Wrap(
                        spacing: 2.w,
                        children: availableSizes.map((size) {
                          return ElevatedButton(
                              onPressed: () {
                                _manageSizes(size);
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.3,
                                  backgroundColor:
                                      productController.sizes.contains(size) ||
                                              productController.currentSizes
                                                  .contains(size)
                                          ? ColorConstants.primaryColor
                                          : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                        color: ColorConstants.primaryColor,
                                      ))),
                              child: Text(
                                size,
                                style: productController.sizes.contains(size) ||
                                        productController.currentSizes
                                            .contains(size)
                                    ? FontStyles.boldWhiteBodyText
                                    : FontStyles.boldPcBodyText,
                              ));
                        }).toList(),
                      )
                    : CustomMultiSelectField<String>(
                        width: 85.w,
                        selectedItemColor: ColorConstants.primaryColor,
                        title: "",
                        initialValue:
                            productController.currentShoeSizes.isNotEmpty
                                ? productController.currentShoeSizes.cast()
                                : [],
                        items: footwearSizes,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2.3.h, horizontal: 3.5.w),
                          hintText: "Select Sizes",
                          hintStyle: FontStyles.blackBodyText,
                          labelStyle: FontStyles.blackBodyText,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade100,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                        ),
                        enableAllOptionSelect: true,
                        onSelectionDone: (List<dynamic> val) async {
                          setState(() {
                            productController.shoeSizes = val.cast();
                          });
                          setState(() {});
                        },
                        itemAsString: (item) => item.toString(),
                      ),
                Spaces.y3,
                SizedBox(
                  width: 84.w,
                  child: Text(
                    "Available Colors",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                Spaces.y1,
                StreamBuilder(
                    stream: firestore.collection("Colors").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      } else {
                        List<String> colors = [];
                        for (var doc in snapshot.data!.docs) {
                          colors.add(doc.data()['title']);
                        }
                        return CustomMultiSelectField<String>(
                          width: 85.w,
                          selectedItemColor: ColorConstants.primaryColor,
                          title: "",
                          initialValue:
                              productController.currentColors.isNotEmpty
                                  ? productController.currentColors.cast()
                                  : [],
                          items: colors,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2.3.h, horizontal: 3.5.w),
                            hintText: "Select Colors",
                            hintStyle: FontStyles.blackBodyText,
                            labelStyle: FontStyles.blackBodyText,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade100,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                          ),
                          enableAllOptionSelect: true,
                          onSelectionDone: (List<dynamic> val) async {
                            List colorIds = [];
                            QuerySnapshot snapshot = await firestore
                                .collection("Colors")
                                .where("title", whereIn: val)
                                .get();
                            if (snapshot.docs.isNotEmpty) {
                              for (var doc in snapshot.docs) {
                                ColorModel color = ColorModel.fromMap(
                                    doc.data() as Map<String, dynamic>);
                                colorIds.add(color.uid);
                              }
                            }
                            setState(() {
                              productController.selectedColors = colorIds;
                            });
                            setState(() {});
                          },
                          itemAsString: (item) => item.toString(),
                        );
                      }
                    }),
                Spaces.y3,
                CustomGradientButton(
                  title: widget.index == 0 ? "Save Changes" : "Create",
                  onPress: () async {
                    if (_prodKey.currentState!.validate()) {
                      print("index is ${widget.index}");
                      widget.index == null
                          ? await _createProduct(context)
                          : await _updateProduct(context);
                    }
                  },
                  titleColor: Colors.white,
                  width: 85.w,
                  height: 7.h,
                  borderRadius: 12.0,
                ),
                Spaces.y1,
              ],
            ),
          )),
    );
  }

  Future<void> _createProduct(BuildContext context) async {
    setLoading();

    if ((productController.selectedCatName == "Footwear" &&
            productController.shoeSizes.isEmpty) ||
        (productController.selectedCatName != "Footwear" &&
            productController.sizes.isEmpty) ||
        productController.selectedColors.isEmpty ||
        productController.selectedUid.isEmpty ||
        productController.selectedBrandId.isEmpty ||
        imagePickerController.pickedImgPaths.isEmpty) {
      hideLoading();
      showErrorSnack("Attention", "Some details are missing.");
    } else {
      await productController.uploadData(context);
      hideLoading();
    }
  }

  Future<void> _updateProduct(BuildContext context) async {
    try {
      await productController.updateProduct(context);
    } catch (e) {
      print("error while calling update $e");
    }
  }

  void _manageSizes(String size) {
    setState(() {
      if (productController.sizes.contains(size)) {
        productController.sizes.remove(size);
      } else if (productController.currentSizes.contains(size)) {
        productController.sizes.remove(size);
        productController.currentSizes.remove(size);
      } else {
        productController.sizes.add(size);
      }
    });
  }
}
