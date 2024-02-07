import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/font_styles.dart';
import '../../utils/space_values.dart';
import '../custom_elevated_button.dart';

// ignore: must_be_immutable
class ConfirmationDialog extends StatelessWidget {
  String title = '', message = '';
  Function()? onConfirm;
  Function()? onCancel;

  ConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 90.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spaces.y3,
            Text(
              title,
              style: FontStyles.heading1Black.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 19.sp,
              ),
            ),
            Spaces.y1,
            Text(
              message,
              textAlign: TextAlign.center,
              style: FontStyles.blackBodyText,
            ),
            Spaces.y2,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  title: 'Cancel',
                  width: 20.w,
                  onPress: onCancel,
                ),
                Spaces.x3,
                CustomElevatedButton(
                  title: 'Confirm',
                  width: 20.w,
                  onPress: onConfirm,
                ),
              ],
            ),
            Spaces.y3,
          ],
        ),
      ),
    );
  }
}
