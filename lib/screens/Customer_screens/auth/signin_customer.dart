import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:status_alert/status_alert.dart';
import 'package:timeless/Constants/color_constants.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/screens/Customer_screens/auth/register_customer.dart';
import 'package:timeless/screens/auth/forgotPassword.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/multiline_text_field.dart';
import '../BottomBarNew/bottom_bar.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

bool checkedValue = false;
bool value = false;

bool rememberMe = false;
bool _isChecked = false;

class CustomerSignIn extends StatefulWidget {
  const CustomerSignIn({super.key});

  @override
  State<CustomerSignIn> createState() => _CustomerSignInState();
}

class _CustomerSignInState extends State<CustomerSignIn> {
  // final auth = FirebaseAuth.instance;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  bool _isChecked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleRemeberme(bool? value) {
    _isChecked = value!;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = _email;
        passwordController.text = _password;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   // final LoginResult loginResult = await FacebookAuth.instance.login();
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
            height: height * 1,
            width: width * 1,
            child: Stack(children: [
              SingleChildScrollView(
                  child: Center(
                      child: Column(children: [
                Spaces.y4,

                Image.asset("assets/images/timelesslogo2.png"),

                Spaces.y6,

                Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor,
                    fontFamily: "Poppins",
                  ),
                ),

                Spaces.y6,

                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomMultilineTextField(
                          onTextChange: (value) {},
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                          capitalization: TextCapitalization.none,

                          hint: "Enter Email",
                          title: "Email",
                          backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                          //backgroundColor: Colors.white,
                          controller: emailController,
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
                          title: "Password",
                          hint: "Enter Password",
                          backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                          controller: passwordController,
                          //onPasswordEyeClick: ,
                        ),
                      ],
                    ),
                  ),
                ),

                Spaces.y1,

                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              activeColor: ColorConstants.primaryColor,
                              value: _isChecked,
                              onChanged: _handleRemeberme),
                          Text("Remember me",
                              style: TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 28.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPassword()));
                              },
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    color: ColorConstants.primaryColor,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                CustomElevatedButton(
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      loginController.logIn(emailController.text.trim(),
                          passwordController.text.trim(), context);
                    }
                  },
                  height: 6.5.h,
                  title: "Sign In",
                  titleColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  bgColor: ColorConstants.primaryColor,
                  borderRadius: 7,
                ),

                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Image.asset("assets/images/or.png"),
                ),

                Spaces.y3,

                ///social media btn & logout
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          loginController.signInWithGoogle(context);
                        },
                        child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: ColorConstants.grayLevel18)),
                            child: Image.asset(
                              "assets/images/google.png",
                              fit: BoxFit.cover,
                            ))),
                    InkWell(
                        onTap: () {
                          loginController.signInWithApple(context);
                        },
                        child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: ColorConstants.grayLevel18)),
                            child: Image.asset(
                              "assets/images/google.png",
                              fit: BoxFit.cover,
                            ))),
                    // Spaces.x5,
                    // InkWell(
                    //     onTap: () async {
                    //       try {
                    //         await signInWithFacebook();
                    //         if (context.mounted) {
                    //           Get.to(BottomBarScreen1());
                    //           // Navigator.push(
                    //           //     context,
                    //           //     MaterialPageRoute(
                    //           //         builder: (context) => Interests()));
                    //         }
                    //       } catch (e) {
                    //         StatusAlert.show(context,
                    //             duration: const Duration(seconds: 2),
                    //             title: 'User Authentication',
                    //             subtitle: e.toString(),
                    //             configuration: const IconConfiguration(
                    //                 icon: Icons.close,
                    //                 color: Colors.red,
                    //                 size: 80),
                    //             maxWidth: 360);
                    //       }
                    //     },
                    //     child: Container(
                    //         height: 35,
                    //         width: 35,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(50),
                    //             border: Border.all(
                    //                 color: ColorConstants.grayLevel18)),
                    //         child: Image.asset("assets/images/fb.png"))),
                    // //Spaces.x5,
                    // SvgPicture.asset("assets/svgs/logout.svg"),
                  ],
                ),
                Spaces.y1,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: ColorConstants.blackLevel1),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterCustomer()));
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
              ]))),
            ])));
  }
}
