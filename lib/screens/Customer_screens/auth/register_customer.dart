import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/color_constants.dart';
import 'package:timeless/screens/Customer_screens/Profile/Customer_complete_profile.dart';
import 'package:timeless/screens/Customer_screens/auth/signin_customer.dart';
import 'package:timeless/widgets/custom_elevated_button.dart';
import 'package:timeless/widgets/multiline_text_field.dart';

import '../../../models/UIHelper.dart';
import '../../../models/UserModel.dart';
import '../../../utils/space_values.dart';

class RegisterCustomer extends StatefulWidget {
  const RegisterCustomer({super.key});

  @override
  State<RegisterCustomer> createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  void checkValues() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else if (password != cPassword) {
      UIHelper.showAlertDialog(context, "Password Mismatch",
          "The passwords you entered do not match!");
    } else {
      _register(context);
      //   _verifyEmail(context);
    }
  }

  void _register(BuildContext context) async {
    UserCredential? credential;

    try {
      final email = emailController.text.trim();
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());

      User? user = credential.user;

      if (user != null) {
        UIHelper.showLoadingDialog(context, "Creating User..");
        //await auth.currentUser?.sendEmailVerification();
        // await user.sendEmailVerification();
        //Navigator.pushReplacementNamed(context, '/verify');
        String uid = credential.user!.uid;
        UserModel newUser = UserModel(
          uid: uid,
          email: email,
          profilepic: "",
          fullname: "",
          cat: [],
          token: '',
        );
        await FirebaseFirestore.instance
            .collection("Customers")
            .doc(uid)
            .set(newUser.toMap())
            .then((value) {
          debugPrint("New user created");
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return CustomerCompleteProfile(
                  userModel: newUser, firebaseUser: credential!.user!);
            }),
          );
        });
      } else {
        UIHelper.showAlertDialog(context, "Warning", "User already exists!");
      }
    } catch (e) {
      // Handle registration error
      debugPrint('Registration failed: $e');
    }
  }

  void _verifyEmail(BuildContext context) async {
    try {
      final email = emailController.text.trim();
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString());

      User? user = userCredential.user;

      if (user != null) {
        //await auth.currentUser?.sendEmailVerification();
        await user.sendEmailVerification();
        //Navigator.pushReplacementNamed(context, '/verify');
        String uid = userCredential.user!.uid;
        UserModel newUser = UserModel(
            uid: uid,
            fullname: "",
            email: email,
            profilepic: "",
            cat: [],
            token: "");
        await FirebaseFirestore.instance
            .collection("Customers")
            .doc(uid)
            .set(newUser.toMap())
            .then((value) {
          debugPrint("New user created");
        });
        Fluttertoast.showToast(msg: 'Verification email sent to ${user.email}');
      }
      Fluttertoast.showToast(
          msg: 'Registration successful. Check your email for verification.');
      print('Registration successful. Check your email for verification.');
    } catch (e) {
      // Handle registration error
      debugPrint('Registration failed: $e');
      Fluttertoast.showToast(msg: 'Registration failed: $e');
    }
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
              Spaces.y7,
              Text(
                "Customer Signup",
                style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: 38,
                    fontWeight: FontWeight.w800),
              ),
              Spaces.y10,
              Text(
                "Registration",
                style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w500),
              ),
              Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.none,

                        onTextChange: (value) {},
                        hint: "Email",
                        backgroundColor: Colors.white,
                        //backgroundColor: Colors.white,
                        controller: emailController,
                      ),
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.none,

                        onTextChange: (value) {},
                        hint: "Password",
                        hasPasswordEye: true,

                        backgroundColor: Colors.white,
                        //backgroundColor: Colors.white,
                        controller: passwordController,
                      ),
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.none,

                        onTextChange: (value) {},
                        backgroundColor: Colors.white,
                        hint: "Confirm Password",
                        //backgroundColor: Colors.white,
                        controller: cPasswordController,
                      ),
                    ],
                  ),
                ),
              ),
              Spaces.y3,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account??",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerSignIn()));
                      },
                      child: Text("Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline)))
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomElevatedButton(
                onPress: () {
                  // Get.toNamed('/completeProf');
                  checkValues();

                  /*
                 if(_formKey.currentState!.validate()){

                   setState(() {
                                        loading = true;
                                      });

                                      auth.createUserWithEmailAndPassword(
                                          email: emailController.text.toString(),
                                          password: passwordController.text.toString()).then((value) {

                                        // Navigator.pushReplacement(context,
                                        //     MaterialPageRoute(builder: (context)=> CompleteProfile()));
                                        Fluttertoast.showToast(msg: 'Signed up successfully');
                                        setState(() {
                                          loading = false;

                                        });

                                      }).onError((error, stackTrace) {

                                        Fluttertoast.showToast(msg: error.toString());
                                        setState(() {
                                          loading = false;
                                        });
                                      });
                                    }*/
                },
                height: 6.5.h,
                title: "Continue",
                //child: loading ? CircularProgressIndicator() : Text("Signup"),
                titleColor: ColorConstants.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                bgColor: Colors.white,
                borderRadius: 7,
              )
            ])))
          ])),
    ));
  }
}
