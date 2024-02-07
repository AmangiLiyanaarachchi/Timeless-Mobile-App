// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:timeless/Constants/color_constants.dart';
// import 'package:timeless/screens/Customer_screens/Interestsandsizes/interests.dart';

// import '../../../utils/space_values.dart';

// class SelectCategory extends StatefulWidget {
//   const SelectCategory({super.key});

//   @override
//   State<SelectCategory> createState() => _SelectCategoryState();
// }

// class _SelectCategoryState extends State<SelectCategory> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         body: SizedBox(
//             height: height * 1,
//             width: width * 1,
//             child: SingleChildScrollView(
//                 child: Center(
//                     child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(children: [
//                 Spaces.y4,
//                 Align(
//                     alignment: Alignment.topLeft,
//                     child: Text("What are you into?",
//                         style: TextStyle(
//                           fontSize: 30,
//                           color: ColorConstants.primaryColor,
//                           fontWeight: FontWeight.w500,
//                         ))),
//                 Spaces.y6,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                         onTap: () {
//                           Get.to(Interests());
//                         },
//                         child: CustomeContainer(
//                           title: "Coats",
//                         )),
//                     CustomeContainer(title: "Scarfs"),
//                     CustomeContainer(title: "Hoodie"),
//                   ],
//                 ),
//                 Spaces.y1,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomeContainer(
//                       title: "Dresses",
//                     ),
//                     CustomeContainer(title: "Hat"),
//                     CustomeContainer(title: "Jeans"),
//                   ],
//                 ),
//                 Spaces.y1,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomeContainer(
//                       title: "T-shirts",
//                     ),
//                     CustomeContainer(title: "Jackets"),
//                     CustomeContainer(title: "Skirt"),
//                   ],
//                 ),
//                 Spaces.y1,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 5.h,
//                       width: 27.w,
//                       decoration: BoxDecoration(
//                         color: ColorConstants.primaryColor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Center(
//                           child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.asset("assets/images/add.png"),
//                           Spaces.x0,
//                           Text(
//                             "Add",
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                         ],
//                       )),
//                     )
//                   ],
//                 ),
//                 Spaces.y7,
//                 Container(
//                   height: 1,
//                   color: ColorConstants.primaryColor,
//                 ),
//                 Spaces.y3,
//                 Container(
//                   height: 5.h,
//                   width: 27.w,
//                   decoration: BoxDecoration(
//                     color: ColorConstants.primaryColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Center(
//                       child: Text(
//                     "Size",
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   )),
//                 ),
//                 SizedBox(
//                   height: 35.h,
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: InkWell(
//                     onTap: () {
//                       Get.to(Interests());
//                     },
//                     child: Container(
//                       width: 18.w,
//                       child: Row(
//                         children: [
//                           Text("Skip",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w500,
//                               )),
//                           Icon(
//                             Icons.arrow_forward_ios,
//                             size: 20,
//                           ),
//                           //Icon(Icons.arrow_forward_ios, size: 20,),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ]),
//             )))));
//   }
// }

// // ignore: must_be_immutable
// class CustomeContainer extends StatelessWidget {
//   String title;
//   CustomeContainer({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 5.h,
//       width: 27.w,
//       decoration: BoxDecoration(
//         color: ColorConstants.primaryColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Center(
//           child: Text(
//         title,
//         style: TextStyle(color: Colors.white, fontSize: 16),
//       )),
//     );
//   }
// }
