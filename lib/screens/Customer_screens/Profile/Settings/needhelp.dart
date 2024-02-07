import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../Constants/color_constants.dart';
import '../../../../utils/space_values.dart';

class NeedHelp extends StatefulWidget {
  const NeedHelp({super.key});

  @override
  State<NeedHelp> createState() => _NeedHelpState();
}

class _NeedHelpState extends State<NeedHelp> {
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
            "FAQ's",
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
                              Text("About Timeless",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Spaces.y2,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("About Timeless",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(top: 7),
                                      child: Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                ],
                              ),
                              Container(
                                  width: width * 0.7,
                                  child: Text(
                                    "Timeless is a marketplace that allows you to sell or buy used and new products.",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Divider(
                                color: Colors.white,
                              ),
                              Spaces.y0,
                              InkWell(
                                onTap: () {
                                  //Get.to(Preferences());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("How to delete a post?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                              Spaces.y1,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width * 0.8,
                                    child: Text(
                                        "Why is my camera on the app is not working?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Icon(
                                        Icons.arrow_right,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                ],
                              ),
                              Spaces.y1,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("How can I list my products? ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(top: 7),
                                      child: Icon(
                                        Icons.arrow_right,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                ],
                              ),
                              Spaces.y1,
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("How can I report a seller?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                              Spaces.y1,
                              InkWell(
                                onTap: () {
                                  //Get.to(Privacy());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("How do I upload pictures? ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                              Spaces.y1,
                              InkWell(
                                onTap: () {
                                  //Get.to(Privacy());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Why is my account not verifying?  ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                              Spaces.y1,
                              InkWell(
                                onTap: () {
                                  //Get.to(Privacy());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("How to donate thobe?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ],
                                ),
                              ),
                              Spaces.y1,
                              InkWell(
                                onTap: () {
                                  //Get.to(Privacy());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Can I purchase internationally?",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ],
                                ),
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
