import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/widgets/custom_elevated_button.dart';
import 'package:timeless/widgets/multiline_text_field.dart';

import '../../constants/color_constants.dart';
import '../../utils/space_values.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final auth = FirebaseAuth.instance;

  bool loading = false;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> sendEmailVerification() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString());

      User? user = userCredential.user;

      if (user != null) {
        //await auth.currentUser?.sendEmailVerification();
        await user.sendEmailVerification();
        //Navigator.pushReplacementNamed(context, '/verify');
      }
    } catch (e) {
      // Handle registration error
      debugPrint('Registration failed: $e');
    }
    //await auth.currentUser?.sendEmailVerification();
  }

  void _register(BuildContext context) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString());

      User? user = userCredential.user;

      if (user != null) {
        //await auth.currentUser?.sendEmailVerification();
        await user.sendEmailVerification();
        //Navigator.pushReplacementNamed(context, '/verify');
      }
    } catch (e) {
      // Handle registration error
      debugPrint('Registration failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            ///background
            Image.asset(
              "assets/images/login_bg.png",
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
            ),

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///top bar
                  Container(
                    width: double.maxFinite,
                    height: 9.h,
                    child: Row(
                      children: [
                        Spaces.x5,
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        Spaces.x10,
                        Spaces.x8,
                        Text(
                          "Create an account",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  Spaces.y6,

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //email
                          CustomMultilineTextField(
                            onTextChange: (val) {},
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            capitalization: TextCapitalization.sentences,
                            hasMargin: false,
                            title: "Email",
                            height: 6.h,
                            borderColor: ColorConstants.grayLevel15,
                            paddingHor: 3.w,
                          ),

                          ///phone
                          CustomMultilineTextField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            capitalization: TextCapitalization.sentences,
                            onTextChange: (val) {},
                            hasMargin: false,
                            title: "Phone",
                            height: 6.h,
                            borderColor: ColorConstants.grayLevel15,
                            paddingHor: 3.w,
                          ),

                          /*Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Email")),

                            Spaces.y1,

                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomFormField(controller: emailController),



                                  Spaces.y3,


                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Password")),

                                  Spaces.y1,

                                  CustomFormField(controller: passwordController),
                                  Spaces.y3,
                                ],
                              ),
                            ),
                            */

                          ///Gender
                          CustomMultilineTextField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            capitalization: TextCapitalization.sentences,
                            onTextChange: (val) {},
                            hasMargin: false,
                            title: "Gender",
                            height: 6.h,
                            borderColor: ColorConstants.grayLevel15,
                            paddingHor: 3.w,
                          ),

                          Spaces.y3,

                          ///Address
                          CustomMultilineTextField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            capitalization: TextCapitalization.sentences,
                            onTextChange: (val) {},
                            hasMargin: false,
                            title: "Address",
                            height: 6.h,
                            borderColor: ColorConstants.grayLevel15,
                            paddingHor: 3.w,
                          ),

                          Spaces.y3,

                          ///address line 2
                          CustomMultilineTextField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            capitalization: TextCapitalization.sentences,
                            onTextChange: (val) {},
                            hasMargin: false,
                            title: "Address Line 2",
                            height: 6.h,
                            borderColor: ColorConstants.grayLevel15,
                            paddingHor: 3.w,
                          ),

                          //18+
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "I confirm I am 18 years or older",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Checkbox(
                                value: (false),
                                onChanged: (val) {},
                                side: BorderSide(color: Colors.black),
                                checkColor: Colors.black,
                              ),
                            ],
                          ),

                          Spaces.y3,

                          ///verify btn
                          CustomElevatedButton(
                            onPress: () async {
                              //sendEmailVerification();
                              // _register(context);

                              /* if(_formKey.currentState!.validate()) {

                                  setState(() {
                                    loading = true;
                                  });

                                  auth.createUserWithEmailAndPassword(
                                      email: emailController.text.toString(),
                                      password: passwordController.text.toString()).then((value) async {

                                    Fluttertoast.showToast(msg: 'Signed up successfully');
                                    setState(() async {
                                     loading = false;
                                     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));

                                      //await auth.currentUser?.sendEmailVerification();
                                    });
                                  }).onError((error, stackTrace) {

                                    Fluttertoast.showToast(msg: error.toString());
                                    setState(() {
                                      loading = false;
                                    });
                                  });
                                }*/
                            },
                            title: "Verify Email",
                            borderRadius: 10,
                            height: 5.h,
                            titleColor: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          Spaces.y1,

                          Spaces.y0,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  CustomFormField({
    super.key,
    required this.controller,
  });



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //controller: emailController,
      obscureText: false,
      style: TextStyle(

        color: ColorConstants.gray,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(


        //hintText: 'Enter valid email',


        //hintStyle: TextStyle(color: Colors.pinkAccent, fontSize: 16),

        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.grayLevel15,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),

        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
                color: ColorConstants.grayLevel15
            )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(
            color: ColorConstants.grayLevel15,

          ),

        ),

      ),

    );
  }
}*/

