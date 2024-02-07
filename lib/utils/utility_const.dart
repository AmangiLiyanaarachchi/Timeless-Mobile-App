import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/font_styles.dart';
import '../constants/color_constants.dart';

final RegExp nameRegExp = RegExp(r'^[A-Za-z]+\s?([A-Za-z]+\s?)*$');
final RegExp emailRegExp =
    RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$');
final RegExp phoneRegExp = RegExp(
  r'^((\+|00)92|0)?\s?[3][0-9]{2}\s?[0-9]{7}$',
  caseSensitive: false,
  multiLine: false,
);
final RegExp numberRegExp = RegExp(r'^\d+$');
final RegExp passRegExp = RegExp(r'^.{0,5}$');

void showSnack(String title, String msg, {bool isError = false}) {
  Get.snackbar(title, msg,
      backgroundColor: Colors.white,
      borderWidth: 2,
      borderColor: Colors.lightGreen,
      colorText: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      padding: EdgeInsets.symmetric(
        vertical: 1.5.h,
        horizontal: 2.w,
      ),
      margin: EdgeInsets.only(bottom: 1.h, left: 3.w, right: 3.w));
}

void showErrorSnack(String title, String msg, {bool isError = false}) {
  Get.snackbar(title, msg,
      backgroundColor: Colors.white,
      borderWidth: 1,
      borderColor: ColorConstants.red,
      colorText: ColorConstants.red,
      snackPosition: SnackPosition.BOTTOM,
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 2.w,
      ),
      margin: EdgeInsets.only(bottom: 1.5.h, left: 3.w, right: 3.w));
}

setLoading() {
  Get.defaultDialog(
      backgroundColor: Colors.white,
      title: 'Please wait...',
      titleStyle: FontStyles.smallBlackBodyTextBold,
      barrierDismissible: false,
      content: const CircularProgressIndicator(
        color: ColorConstants.primaryColor,
      ));
}

void hideLoading() {
  Get.back();
}
