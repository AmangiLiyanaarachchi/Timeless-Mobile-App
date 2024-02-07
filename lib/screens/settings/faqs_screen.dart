import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/color_constants.dart';
import '../../utils/space_values.dart';
import '../../widgets/multiline_text_field.dart';

class FAQsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spaces.y2,

            ///top bar
            Row(
              children: [
                Spaces.x5,
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back)),
                Spaces.x10,
                Spaces.x10,
                Spaces.x10,
                Text(
                  "FAQs",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spaces.y2,
            Container(
              height: 0.2.h,
              width: double.maxFinite,
              color: Colors.black,
            ),

            ///FAQs
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///search
                  CustomMultilineTextField(
                    onTextChange: (val) {},
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    capitalization: TextCapitalization.none,
                    height: 6.h,
                    width: 80.w,
                    hasMargin: false,
                    hasBorder: false,
                    paddingHor: 2.w,
                    paddingVer: 2.h,
                    backgroundColor: ColorConstants.grayLevel15,
                    startSvgIcon: "assets/svgs/search.svg",
                    hint: "Search using keywords",
                  ),
                  Spaces.y3,

                  Text(
                    "About Timeless",
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),

                  Spaces.y2,
                  item("What is Timeless?"),
                  item("How to delete a post?"),
                  item("Why is my camera on the app is not working?"),
                  item("How can I list my products? "),
                  item("How do I upload pictures? "),
                  item("Why is my account not verifying? "),
                  item("How to donate thobe?"),
                  item("Can I purchase internationally?"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget item(Question) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                Question,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down_circle_outlined, size: 8.w),
            ),
          ],
        ),
        Spaces.y1,
      ],
    );
  }
}
