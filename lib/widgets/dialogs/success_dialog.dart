import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/color_constants.dart';
import 'package:timeless/constants/font_styles.dart';
import 'package:timeless/utils/space_values.dart';
import 'package:timeless/widgets/custom_elevated_button.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog(
      {super.key,
      required this.title,
      required this.body,
      required this.onPressEvent});
  final String title, body;
  final VoidCallback onPressEvent;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundColor: Colors.lightGreen.shade100,
                    child: Icon(
                      Icons.check,
                      color: Colors.lightGreen,
                      size: 4.h,
                    ),
                  ),
                  Spaces.x2,
                  Text(title, style: FontStyles.appBarStyleBlack),
                ],
              ),
            ),
            Spaces.y2,
            Flexible(
              child: Text(
                body,
                style: FontStyles.blackBodyText,
              ),
            ),
            Spaces.y2,
            CustomElevatedButton(
              title: "Ok",
              width: 20.w,
              height: 6.h,
              borderRadius: 5.0,
              bgColor: ColorConstants.primaryColor,
              onPress: onPressEvent,
            ),
          ],
        ),
      ),
    );
  }
}
