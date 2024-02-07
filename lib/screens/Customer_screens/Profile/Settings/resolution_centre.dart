import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/widgets/multiline_text_field.dart';

import '../../../../Constants/color_constants.dart';
import '../../../../utils/space_values.dart';

class ResolutionCentre extends StatefulWidget {
  const ResolutionCentre({super.key});

  @override
  State<ResolutionCentre> createState() => _ResolutionCentreState();
}

List<String> issues = [
  "Delivery",
  "Listing",
  "Reviews",
  "Seller",
  "App",
  "Others"
];

class _ResolutionCentreState extends State<ResolutionCentre> {
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
            "Resolution Center",
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
                              Text("Have an issue with the app?",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Spaces.y2,
                              Text(
                                "Number",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              Spaces.y1,
                              Container(
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: DropdownButtonex1(),
                                ),
                              ),
                              Spaces.y2,
                              CustomMultilineTextField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                capitalization: TextCapitalization.none,

                                onTextChange: (value) {},
                                hint: "Enter name",

                                title: "Name",
                                titleColor: Colors.white,
                                backgroundColor: Colors.white,
                                controller: TextEditingController(),
                                hasMargin: false,
                                //onPasswordEyeClick: ,
                              ),
                              Spaces.y2,
                              CustomMultilineTextField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                capitalization: TextCapitalization.none,

                                onTextChange: (value) {},
                                hint: "abc@gmail.com",

                                title: "Email",
                                titleColor: Colors.white,
                                backgroundColor: Colors.white,
                                controller: TextEditingController(),
                                hasMargin: false,
                                //onPasswordEyeClick: ,
                              ),
                              Spaces.y2,
                              CustomMultilineTextField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                capitalization: TextCapitalization.none,

                                onTextChange: (value) {},
                                hint:
                                    "Write a brief description about your problem.",

                                title: "Description",
                                titleColor: Colors.white,
                                backgroundColor: Colors.white,
                                controller: TextEditingController(),
                                hasMargin: false,
                                maxLines: 4,
                                //onPasswordEyeClick: ,
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

class DropdownButtonex1 extends StatefulWidget {
  const DropdownButtonex1({super.key});

  @override
  State<DropdownButtonex1> createState() => _DropdownButtonex1State();
}

class _DropdownButtonex1State extends State<DropdownButtonex1> {
  String dropdownValue = issues.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Padding(
        padding: const EdgeInsets.only(left: 190.0),
        child: const Icon(
          Icons.arrow_drop_down_sharp,
          color: ColorConstants.primaryColor,
        ),
      ),

      //elevation: 16,
      style: const TextStyle(color: ColorConstants.primaryColor, fontSize: 15),
      underline: Container(),

      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: issues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
