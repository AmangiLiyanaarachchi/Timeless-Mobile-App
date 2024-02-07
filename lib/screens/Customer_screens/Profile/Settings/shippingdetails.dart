import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/space_values.dart';

class Shipping extends StatefulWidget {
  const Shipping({super.key});

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height * 1,
            width: width * 1,
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
            child: SingleChildScrollView(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spaces.y2,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 22,
                                      )),
                                  Text(
                                    "Deliver to",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sans-serif',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 28,
                                  )
                                ],
                              ),
                              Spaces.y8,
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Center(
                                        child: Image.asset(
                                            "assets/images/qatar.png",
                                            height: 60,
                                            width: 60)),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Spaces.x5,
                                  Text(
                                    "Qatar",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    "assets/images/timelesslogo1.png",
                                    opacity: const AlwaysStoppedAnimation(.5),
                                    width: 40.w,
                                    height: 30.h,
                                  ))
                            ]))))));
  }
}
