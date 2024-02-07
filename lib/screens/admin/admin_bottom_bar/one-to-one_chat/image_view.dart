import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../Constants/font_styles.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  resetScaleMatrix() {
    _scale = 1.0;
    _previousScale = 1.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final getArgs = Get.arguments;
    var name = getArgs['name'];
    var imgData = getArgs['img'];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Colors.white
                .withOpacity(0.2), // Choose the color you want for the border
            width: 1.0, // Adjust the width of the border
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          name,
          style: FontStyles.boldWhiteBodyText,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 1.w),
            child: TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.4)),
                onPressed: () => resetScaleMatrix(),
                icon: Icon(
                  Icons.replay,
                  color: Colors.white,
                  size: 2.5.h,
                ),
                label: Text(
                  "Reset Size",
                  style: FontStyles.whiteBodyText,
                )),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: GestureDetector(
          onScaleStart: (details) {
            _previousScale = _scale;
            setState(() {});
          },
          onScaleUpdate: (details) {
            _scale = _previousScale * details.scale;
            setState(() {});
          },
          onScaleEnd: (details) {
            _previousScale = 1.0;
            setState(() {});
          },
          child: Transform.scale(
            scale: _scale,
            child: Image.network(imgData), // Replace with your image asset
          ),
        ),
      ),
    );
  }
}
