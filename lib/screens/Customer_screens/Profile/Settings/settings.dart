import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/screens/Customer_screens/Profile/Settings/needhelp.dart';
import 'package:timeless/screens/Customer_screens/Profile/Settings/privacy.dart';
import 'package:timeless/screens/Customer_screens/Profile/Settings/resolution_centre.dart';
import 'package:timeless/screens/Customer_screens/auth/signin_customer.dart';
import '../../../../Constants/color_constants.dart';
import '../../../../utils/space_values.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
            "Settings",
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
                              InkWell(
                                onTap: () {
                                  Get.to(ResolutionCentre());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Resolution Centre",
                                        style: TextStyle(
                                          fontSize: 16,
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
                                  Get.to(NeedHelp());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Need Help?",
                                        style: TextStyle(
                                          fontSize: 16,
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
                                  Get.to(Privacy());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Privacy",
                                        style: TextStyle(
                                          fontSize: 16,
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
                                  //Get.to(Preferences());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Terms and conditions",
                                        style: TextStyle(
                                          fontSize: 16,
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
                                onTap: () async {
                                  loginController.logout();
                                  Get.offAll(CustomerSignIn());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Logout",
                                        style: TextStyle(
                                          fontSize: 16,
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
                            ]))))));
  }
}
