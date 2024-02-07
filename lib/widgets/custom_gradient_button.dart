// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/color_constants.dart';

class CustomGradientButton extends StatelessWidget {
  String title;
  FontWeight? fontWeight;
  double? fontSize;
  Function()? onPress;
  double? width;
  double? height;
  double? borderRadius;
  Color? titleColor;
  Color? color1;
  Color? color2;

  CustomGradientButton({
    super.key,
    required this.title,
    this.onPress,
    this.width,
    this.height,
    this.titleColor,
    this.borderRadius,
    this.fontWeight,
    this.fontSize,
    this.color1,
    this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              gradient: LinearGradient(
                colors: [
                  color1 ?? ColorConstants.primaryColor,
                  color2 ?? ColorConstants.primaryColor.withOpacity(0.7),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
          width: width,
          height: height,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  )),
              onPressed: () {
                onPress?.call();
              },
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: titleColor ?? Colors.white,
                      fontSize: fontSize ?? 13.sp,
                      fontWeight: fontWeight ?? FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}
