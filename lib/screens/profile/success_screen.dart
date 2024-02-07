import 'package:flutter/material.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/bottom_bar_screen.dart';

import '../../Constants/color_constants.dart';
import '../../utils/space_values.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 600), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BottomBarScreenAdmin()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        //backgroundColor: Colors.grey[500],
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            Color(0xff5C1616),
            Color(0xff703333),
            Color(0xff937070),
            Color(0xff9F8787),
          ],
        ),
      ),
      child: SizedBox(
          height: height * 1,
          width: width * 1,
          child: Stack(children: [
            //       Image.asset(
            //       "assets/images/home_bg.png",
            //       width: double.maxFinite,
            //       height: double.maxFinite,
            //       fit: BoxFit.cover,
            //
            // ),
            SingleChildScrollView(
                child: Center(
                    child: Column(children: [
              Spaces.y10,
              Text(
                "Successfull",
                style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: 38,
                    fontFamily: 'sans-serif',
                    fontWeight: FontWeight.w800),
              ),
              Spaces.y10,
              Spaces.y3,
              Image.asset("assets/images/Frame.png")
            ])))
          ])),
    ));
  }
}
