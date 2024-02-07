import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/main.dart';
import 'package:timeless/models/CategoryModel.dart';
import 'package:timeless/widgets/multiline_text_field.dart';
import '../../Constants/color_constants.dart';
import '../../controllers/call_controllers.dart';
import '../../utils/space_values.dart';
import '../../utils/utility_const.dart';
import '../custom_elevated_button.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  var title = TextEditingController();
  final _catKey = GlobalKey<FormState>();
  var imgPath = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "New Category",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {});
                  //   },
                  //   child: const Icon(
                  //     Icons.add,
                  //     color: Colors.black,
                  //     size: 24.0,
                  //   ),
                  // )
                ],
              ),
              Spaces.y3,
              Form(
                key: _catKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () async {
                          imgPath = await imagePickerController
                              .pickSingleImage(ImageSource.gallery);
                          setState(() {});
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 8.w, right: 4.w),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: imgPath.isNotEmpty
                                ? Image.file(
                                    File(imgPath),
                                    height: 10.h,
                                    width: 25.w,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/no_image.jpg',
                                    height: 10.h,
                                    width: 25.w,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                    CustomMultilineTextField(
                        onTextChange: (val) {},
                        controller: title,
                        capitalization: TextCapitalization.words,
                        hint: "Cateogry title",
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        }),
                    Spaces.y2,
                    Wrap(
                      children: [
                        CustomElevatedButton(
                            bgColor: ColorConstants.primaryColor,
                            titleColor: Colors.white,
                            title: "Save",
                            onPress: () async {
                              if (_catKey.currentState!.validate()) {
                                setLoading();
                                if (imgPath.isNotEmpty) {
                                  var downloadUrl = await imagePickerController
                                      .uploadMediatoStorage(File(imgPath));

                                  CategoryModel categoryModel = CategoryModel(
                                    uid: uuid.v4(),
                                    title: title.text.trim(),
                                    imgUrl: downloadUrl,
                                    enabled: true,
                                  );
                                  await productController
                                      .addCategory(categoryModel);
                                  hideLoading();
                                  Get.back();
                                } else {
                                  hideLoading();
                                  showErrorSnack("Attention!",
                                      "Please choose a cover image for category");
                                }
                              }
                            }),
                        CustomElevatedButton(
                          bgColor: Colors.grey.shade100,
                          titleColor: Colors.black,
                          title: "Cancel",
                          onPress: () async {
                            setState(() {
                              imgPath = "";
                            });
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spaces.y2,
            ],
          ),
        ),
      ),
    );
  }
}
