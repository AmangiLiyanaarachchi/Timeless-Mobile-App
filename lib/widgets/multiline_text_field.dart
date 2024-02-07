import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/font_styles.dart';

import '../constants/color_constants.dart';
import '../utils/space_values.dart';

class CustomMultilineTextField extends StatelessWidget {
  final Function(String) onTextChange;
  final TextEditingController? controller;
  final Function()? onPasswordEyeClick;
  final String? hint;
  final String? initialValue;
  final String? startSvgIcon;
  final int maxLines;
  final bool maxLinesDisabled;
  final TextCapitalization capitalization;
  final double? height;
  final double? width;
  final bool hasBorder;
  final bool enable;
  final bool addEnterInHint;
  final bool obscureText;
  final double paddingVer;
  final double paddingHor;
  final TextInputType textInputType;
  final Function(String)? onSubmitted;
  final TextInputAction textInputAction;
  final Color? backgroundColor;
  final Color? borderColor;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool hasPasswordEye;
  final bool hasMargin;
  final String? title;
  final Color? titleColor;
  final String? Function(String?) validator;

  const CustomMultilineTextField(
      {Key? key,
      this.controller,
      required this.onTextChange,
      required this.capitalization,
      this.hint,
      this.height,
      this.onSubmitted,
      this.startSvgIcon,
      this.title,
      this.hasBorder = true,
      this.enable = true,
      this.hasMargin = true,
      this.obscureText = false,
      this.addEnterInHint = true,
      this.hasPasswordEye = false,
      this.initialValue,
      this.width,
      this.onPasswordEyeClick,
      this.floatingLabelBehavior,
      this.textInputType = TextInputType.multiline,
      this.textInputAction = TextInputAction.newline,
      this.paddingVer = 20,
      this.paddingHor = 0,
      this.maxLinesDisabled = false,
      this.backgroundColor,
      this.titleColor,
      this.borderColor,
      this.maxLines = 1,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: hasMargin
              ? EdgeInsets.symmetric(horizontal: 7.w)
              : const EdgeInsets.all(0),
          child: Text(
            title ?? '',
            style: TextStyle(
                fontSize: 12.sp,
                color: titleColor,
                fontWeight: FontWeight.w400),
          ),
        ),
        Spaces.y1,
        Container(
          //height: height ?? 8.5.h,
          //?? 8.5.h,
          width: width,
          decoration: BoxDecoration(
              color: backgroundColor ?? Colors.transparent,
              borderRadius: new BorderRadius.all(new Radius.circular(7))),

          margin: hasMargin ? EdgeInsets.symmetric(horizontal: 7.w) : null,
          child: Stack(
            children: [
              TextFormField(
                textInputAction: textInputAction,
                keyboardType: textInputType,
                textCapitalization: capitalization,
                // textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                obscureText: obscureText,
                onFieldSubmitted: onSubmitted,
                validator: validator,
                cursorHeight: 23,

                maxLines: maxLinesDisabled ? null : maxLines,
                onChanged: onTextChange,
                enabled: enable,
                controller: controller,
                decoration: InputDecoration(
                  filled: false,
                  isDense: false,

                  floatingLabelBehavior:
                      floatingLabelBehavior ?? FloatingLabelBehavior.never,
                  alignLabelWithHint: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 3.5.w),
                  counterText: '',
                  //suffixStyle: FontStyles.normalBlackBodyText,
                  focusColor: ColorConstants.appBlack,
                  fillColor: Colors.white,
                  hoverColor: ColorConstants.appBlack,
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor ?? Colors.grey.shade200,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(7))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor ?? Colors.grey.shade200,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(7))),
                  //border: OutlineInputBorder(),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor ?? Colors.grey.shade200,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(7))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor ?? Colors.grey.shade200,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(7))),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor ?? Colors.red.withOpacity(0.3),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(7))),
                  border: hasBorder ? null : InputBorder.none,
                  labelText: hint ?? '',
                  labelStyle: FontStyles.smallBlackBodyText,
                  hintText: '${addEnterInHint ? '' : ''}${hint ?? ''}',
                  hintStyle: FontStyles.smallBlackBodyTextBold,
                ),
                style: FontStyles.blackBodyText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
