// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:sizer/sizer.dart';
// import 'package:timeless/Constants/color_constants.dart';
// import 'package:timeless/models/UserModel.dart';
//
// import '../../utils/space_values.dart';
// import 'login_email.dart';
//
// class SignUpEmail extends StatefulWidget {
//   const SignUpEmail({super.key});
//
//   @override
//   State<SignUpEmail> createState() => _SignUpEmailState();
// }
//
// class _SignUpEmailState extends State<SignUpEmail> {
//   final auth= FirebaseAuth.instance;
//   bool loading = false;
//   final _formKey= GlobalKey<FormState>();
//   final emailController= TextEditingController();
//   final passwordController= TextEditingController();
//
//
//   void _register(BuildContext context) async {
//     try {
//       final email= emailController.text.trim();
//       final UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//           email: emailController.text.toString(), password: passwordController.text.toString());
//
//       User? user = userCredential.user;
//
//       if (user != null) {
//         //await auth.currentUser?.sendEmailVerification();
//         await user.sendEmailVerification();
//         //Navigator.pushReplacementNamed(context, '/verify');
//         String uid= userCredential.user!.uid;
//         UserModel newUser= UserModel(
//           uid: uid,
//           email: email,
//           profilepic: "",
//           fullname: "",
//           cat: [],
//         );
//         await FirebaseFirestore.instance.collection("users").doc(uid).set
//           (newUser.toMap()).then((value) {
//             debugPrint("New user created");
//         });
//
//       }
//     } catch (e) {
//       // Handle registration error
//       debugPrint('Registration failed: $e');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     var height= MediaQuery.of(context).size.height;
//     var width= MediaQuery.of(context).size.width;
//     return SafeArea(
//         child: Scaffold(
//
//             body: SizedBox(
//                 height: height*1,
//                 width: width*1,
//                 child: Stack(
//                   children: [
//
//                     Image.asset(
//                       "assets/images/login_bg.png",
//                       width: double.maxFinite,
//                       height: double.maxFinite,
//                       fit: BoxFit.fill,
//                       //width: width*1,
//                       //height: height* 1,
//                       //fit: BoxFit.fill,
//                     ),
//                     SingleChildScrollView(
//                       child: Center(
//                           child: Column(
//
//                               children: [
//
//                                 Container(
//                                   width: double.maxFinite,
//                                   height: 9.h,
//                                   child: Row(
//                                     children: [
//                                       Spaces.x5,
//                                       GestureDetector(
//                                           onTap: () {
//                                             Get.back();
//                                           },
//                                           child: SvgPicture.asset("assets/svgs/back_ic.svg",color: Colors.white,)),
//                                       Spaces.x10,
//                                       Spaces.x8,
//                                       Center(
//                                         child: Text(
//                                           "Create an account",
//                                           style: TextStyle(
//                                               fontSize: 16.sp, fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 SizedBox(height: 60,),
//
//                                 Form(
//                                     key: _formKey,
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           height: 40,
//                                           width: width*0.84,
//                                           child: TextFormField(
//                                             controller: emailController,
//                                             obscureText: false,
//                                             style: TextStyle(
//
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             decoration: InputDecoration(
//                                               prefixIcon: Icon(Icons.email, color: Colors.black,),
//                                               //labelText: 'Email',
//                                               hintText: 'Enter valid email',
//                                               contentPadding: EdgeInsets.only(top: 3),
//
//
//
//                                               hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
//
//                                               border: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: ColorConstants.grayLevel15,
//                                                     width: 1
//                                                 ),
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                   borderSide: BorderSide(
//                                                       width: 1,
//                                                       color: ColorConstants.grayLevel15
//
//                                                   )
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                 borderSide: BorderSide(
//                                                     color: ColorConstants.grayLevel15,
//                                                     width: 1
//
//                                                 ),
//
//                                               ),
//
//                                             ),
//                                             /*validator: (value){
//                                               if(value!.isEmpty){
//                                                 return 'Enter email';
//                                               }
//                                               return null;
//                                             },*/
//                                           ),
//                                         ),
//
//                                         SizedBox(height: 30,),
//
//                                         Container(
//                                           width: width*0.84,
//                                           height: 40,
//                                           child: TextFormField(
//                                             controller: passwordController,
//                                             obscureText: true,
//                                             style: TextStyle(
//
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             decoration: InputDecoration(
//                                               prefixIcon: Icon(Icons.lock, color: Colors.black,),
//                                               //labelText: 'Password',
//                                               hintText: 'Enter password',
//                                               contentPadding: EdgeInsets.only(top: 3),
//
//
//
//                                               hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
//
//                                               border: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: ColorConstants.grayLevel15,
//                                                 ),
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                   borderSide: BorderSide(
//                                                       color: ColorConstants.grayLevel15
//                                                   )
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                 borderSide: BorderSide(
//                                                   color: ColorConstants.grayLevel15,
//
//                                                 ),
//
//                                               ),
//
//                                             ),
//
//                                             /*validator: (value){
//                                               if(value!.isEmpty){
//                                                 return 'Enter password';
//                                               }
//                                               return null;
//                                             },*/
//
//                                           ),
//                                         ),
//
//
//
//                                         SizedBox(height: 30,),
//
//                                         Container(
//                                             width: width*0.84,
//                                             height: 40,
//                                             child: TextFormField(
//                                               //controller: emailController,
//                                               obscureText: false,
//                                               style: TextStyle(
//
//                                                 color: ColorConstants.blackLevel1,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               decoration: InputDecoration(
//                                                 prefixIcon: Icon(Icons.male, color: Colors.black,),
//                                                 //labelText: 'Email',
//                                                 hintText: 'Gender',
//                                                 contentPadding: EdgeInsets.only(top: 3),
//
//
//
//                                                 hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
//
//                                                 border: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: ColorConstants.grayLevel15,
//                                                       width: 1
//                                                   ),
//                                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//
//                                                 ),
//                                                 focusedBorder: OutlineInputBorder(
//                                                     borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                     borderSide: BorderSide(
//                                                         width: 1,
//                                                         color: ColorConstants.grayLevel15
//
//                                                     )
//                                                 ),
//                                                 enabledBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                   borderSide: BorderSide(
//                                                       color: ColorConstants.grayLevel15,
//                                                       width: 1
//
//                                                   ),
//
//                                                 ),
//
//                                               ),
//                                             ),
//                                         ),
//
//                                         SizedBox(height: 30,),
//
//                                         Container(
//                                           width: width*0.84,
//                                           height: 40,
//                                           child: TextFormField(
//                                             //controller: emailController,
//                                             obscureText: false,
//                                             style: TextStyle(
//
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             decoration: InputDecoration(
//                                               prefixIcon: Icon(Icons.location_on, color: Colors.black,),
//                                               //labelText: 'Email',
//                                               hintText: 'Address 1',
//                                               contentPadding: EdgeInsets.only(top: 3),
//                                               hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
//
//                                               border: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: ColorConstants.grayLevel15,
//                                                     width: 1
//                                                 ),
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                   borderSide: BorderSide(
//                                                       width: 1,
//                                                       color: ColorConstants.grayLevel15
//
//                                                   )
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                 borderSide: BorderSide(
//                                                     color: ColorConstants.grayLevel15,
//                                                     width: 1
//
//                                                 ),
//
//                                               ),
//
//                                             ),
//                                           ),
//                                         ),
//
//                                         SizedBox(height: 30,),
//
//                                         Container(
//                                           height: 40,
//                                           width: width*0.84,
//                                           child: TextFormField(
//
//                                             //controller: emailController,
//                                             obscureText: false,
//                                             style: TextStyle(
//
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             decoration: InputDecoration(
//                                               prefixIcon: Icon(Icons.location_on, color: Colors.black,),
//                                               //labelText: 'Email',
//                                               hintText: 'Address 2',
//                                               contentPadding: EdgeInsets.only(top: 3),
//                                               hintStyle: TextStyle(color: Colors.black45, fontSize: 15),
//
//                                               border: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: ColorConstants.grayLevel15,
//                                                     width: 1
//                                                 ),
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                   borderSide: BorderSide(
//                                                       width: 1,
//                                                       color: ColorConstants.grayLevel15
//
//                                                   )
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                                                 borderSide: BorderSide(
//                                                     color: ColorConstants.grayLevel15,
//                                                     width: 1
//
//                                                 ),
//
//                                               ),
//
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                 ),
//
//                                 SizedBox(height: 20,),
//
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//
//                                     Text(
//                                       "I confirm I am 18 years or older",
//                                       style: TextStyle(
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w500
//                                       ),
//                                     ),
//
//                                     Checkbox(
//                                       value: (false),
//                                       onChanged: (val) {},
//                                       side: BorderSide(color: Colors.black),
//                                       checkColor: Colors.black,
//                                     ),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: 40,),
//
//                                 InkWell(
//                                   onTap: (){
//
//                                     _register(context);
//
//                                    /* if(_formKey.currentState!.validate()){
//
//                                       setState(() {
//                                         loading = true;
//                                       });
//
//                                       auth.createUserWithEmailAndPassword(
//                                           email: emailController.text.toString(),
//                                           password: passwordController.text.toString()).then((value) {
//
//                                         Fluttertoast.showToast(msg: 'Signed up successfully');
//                                         setState(() {
//                                           loading = false;
//
//                                         });
//                                       }).onError((error, stackTrace) {
//
//                                         Fluttertoast.showToast(msg: error.toString());
//                                         setState(() {
//                                           loading = false;
//                                         });
//                                       });
//                                     }*/
//                                   },
//
//                                   child: Container(
//
//                                     height: 40,
//                                     width: width * 0.7,
//                                     decoration: BoxDecoration(
//                                         color: ColorConstants.appSkin.withOpacity(0.7),
//
//
//                                         borderRadius: BorderRadius.all(Radius.circular(15))
//                                     ),
//                                     child: Align(
//                                         alignment: Alignment.center,
//                                         child: loading ? CircularProgressIndicator(color: Colors.white, strokeWidth: 3,): Text('Verify Email',
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold,),)),
//                                   ),
//                                 ),
//
//                                 SizedBox(height: 10,),
//
//
//
//
//
//
//
//
//
//                               ]
//                           )
//                       )
//                   ),
//                 ]
//                 )
//             )
//         )
//     );
//   }
// }