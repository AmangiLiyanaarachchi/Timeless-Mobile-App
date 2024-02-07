import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/Constants/color_constants.dart';

import '../../../../utils/space_values.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Color(0xff9F8787),
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
          title: Text(
            "Privacy",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 22,
              )),
        ),
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
                              Spaces.y6,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Personalised advertising",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        Spaces.y1,
                                        Text(
                                            "Allows Timeless to share my data to personalise my ad experience",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: false,
                                    onChanged: null,
                                    splashRadius: 20,
                                    inactiveTrackColor:
                                        Color.fromRGBO(239, 239, 239, 1),
                                    inactiveThumbColor: Colors.grey,
                                  )
                                ],
                              ),
                              Spaces.y3,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Site customisation",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        Spaces.y1,
                                        Text(
                                            "Allows Timeless to use cookies to personalise my content, and remember my account and regional preferences",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: true,
                                    onChanged: null,
                                    splashRadius: 20,
                                    inactiveTrackColor:
                                        Color.fromRGBO(239, 239, 239, 1),
                                    inactiveThumbColor: Colors.grey,
                                    activeTrackColor:
                                        ColorConstants.primaryColor,
                                  )
                                ],
                              ),
                              Spaces.y6,
                              Text("Required cookies & technologies ",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Spaces.y5,
                              InkWell(
                                onTap: () {
                                  // Get.to(OrderCompleted());
                                },
                                child: Container(
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white),
                                  child: Center(
                                    child: Text("Save",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: ColorConstants.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    "assets/images/timelesslogo1.png",
                                    opacity: const AlwaysStoppedAnimation(.5),
                                  ))
                            ]))))));
  }
}
