import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/Constants/color_constants.dart';

import '../../utils/space_values.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/multiline_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final auth = FirebaseAuth.instance;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
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
                  "Forgot Password?",
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

                          hint: "Enter valid email",
                          title: "Email",
                          backgroundColor: Color.fromRGBO(158, 119, 119, 0.2),
                          //backgroundColor: Colors.white,
                          controller: emailController,
                        ),
                      ],
                    )),

                Spaces.y6,

                // InkWell(
                //   onTap: (){
                //
                //     setState(() {
                //       loading= true;
                //     });
                //     auth.sendPasswordResetEmail(email: emailController.text.toString()).
                //     then((value){
                //       Fluttertoast.showToast(msg: 'We have sent you an email. Please check your inbox');
                //       setState(() {
                //         loading= false;
                //       });
                //     }).onError((error, stackTrace){
                //       Fluttertoast.showToast(msg: error.toString());
                //       setState(() {
                //         loading= false;
                //       });
                //     });
                //   },
                //
                //   child: Padding(
                //     padding:  EdgeInsets.symmetric(horizontal: 5.w),
                //     child: Container(
                //
                //       height: 6.5.h,
                //
                //       decoration: BoxDecoration(
                //           color: ColorConstants.appSkin.withOpacity(0.7),
                //
                //
                //           borderRadius: BorderRadius.all(Radius.circular(7))
                //       ),
                //       child: Align(
                //           alignment: Alignment.center,
                //           child: loading ? CircularProgressIndicator(
                //             color: Colors.white, strokeWidth: 3,):
                //           Text('Send an email',
                //             style: TextStyle(
                //               fontSize: 18,
                //               color: Colors.black,
                //               fontWeight: FontWeight.bold,),)),
                //     ),
                //   ),
                // ),

                CustomElevatedButton(
                  onPress: () async {
                    setState(() {
                      loading = true;
                    });
                    auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((value) {
                      Fluttertoast.showToast(
                          msg:
                              'We have sent you an email. Please check your inbox');
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(msg: error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  },
                  height: 6.5.h,
                  title: "Send an email",
                  titleColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  bgColor: ColorConstants.primaryColor,
                  borderRadius: 7,
                ),
              ]))),
            ])));
  }
}
