import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/color_constants.dart';
import 'package:timeless/constants/font_styles.dart';
import 'package:timeless/utils/space_values.dart';
import 'package:timeless/widgets/custom_elevated_button.dart';

class DeletionDialog extends StatelessWidget {
  const DeletionDialog({
    super.key,
    required this.title,
    required this.body,
    required this.onCancelEvent,
    required this.onConfirmEvent,
  });
  final String title, body;
  final VoidCallback onCancelEvent;
  final VoidCallback onConfirmEvent;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
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
                    backgroundColor: Colors.red.shade100,
                    child: Icon(
                      Icons.close,
                      color: Colors.redAccent,
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
            Wrap(
              children: [
                CustomElevatedButton(
                  title: "Confirm",
                  height: 4.5.h,
                  borderRadius: 5.0,
                  bgColor: ColorConstants.primaryColor,
                  onPress: onConfirmEvent,
                ),
                CustomElevatedButton(
                  title: "Cancel",
                  height: 4.5.h,
                  borderRadius: 5.0,
                  titleColor: Colors.black,
                  bgColor: Colors.grey.shade200,
                  onPress: onCancelEvent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
