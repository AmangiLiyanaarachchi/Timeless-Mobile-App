// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';

class CustomElevatedButton extends StatelessWidget {
  String? title;
  Widget? child;
  FontWeight? fontWeight;
  double? fontSize;
  Function()? onPress;
  double? width;
  double? height;
  double? borderRadius;
  Color? bgColor;
  Color? titleColor;

  CustomElevatedButton(
      {super.key,
       this.child,
      this.onPress,
       this.title,
      this.width,
      this.height,
      this.bgColor,
      this.titleColor,
      this.borderRadius,
      this.fontWeight,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 7.w),
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      bgColor ?? ColorConstants.appSkin.withOpacity(0.7)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(borderRadius ?? 30.0)))),
              onPressed: () {
                onPress?.call();
              },
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: titleColor ?? Colors.white,
                        fontSize: fontSize ?? 13.sp,
                        fontWeight: fontWeight ?? FontWeight.normal),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
