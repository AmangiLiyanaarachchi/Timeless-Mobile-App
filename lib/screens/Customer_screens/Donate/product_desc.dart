// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:timeless/screens/Customer_screens/Donate/donate_thobe.dart';
//
// import '../../../Constants/color_constants.dart';
// import '../../../Constants/firebase_consts.dart';
// import '../../../Constants/font_styles.dart';
// import '../../../controllers/call_controllers.dart';
// import '../../../models/CategoryModel.dart';
// import '../../../utils/space_values.dart';
// import '../../../widgets/custom_elevated_button.dart';
// import '../../../widgets/multiline_text_field.dart';
// class ProductDescription extends StatefulWidget {
//   const ProductDescription({super.key});
//
//   @override
//   State<ProductDescription> createState() => _ProductDescriptionState();
// }
//
// class _ProductDescriptionState extends State<ProductDescription> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(
//               scrolledUnderElevation: 0,
//               backgroundColor: Colors.white,
//               elevation: 0,
//               automaticallyImplyLeading: true,
//               iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
//               title: Text(
//                 "List your product",
//                 style: FontStyles.appBarStylePC,
//               ),
//               centerTitle: true,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 15.0),
//                   child: Icon(
//                     Icons.notifications,
//                     color: ColorConstants.primaryColor,
//                     size: 30,
//                   ),
//                 )
//               ],
//             ),
//             body: SizedBox(
//                 child: SingleChildScrollView(
//                     child: Center(
//                         child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Spaces.y5,
//
//
//                                   Text(
//                                       "Description:",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         color: ColorConstants.primaryColor,
//                                         fontWeight: FontWeight.w500,
//                                       )
//                                   ),
//
//                                   Text(
//                                       "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: ColorConstants.primaryColor,
//
//                                       )
//                                   ),
//
//                                   Spaces.y3,
//                                   Text(
//                                       "Please Answer The Following Questions:",
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: ColorConstants.primaryColor,
//                                         fontWeight: FontWeight.w400,
//                                       )
//                                   ),
//                                   Spaces.y2,
//
//                                   CustomMultilineTextField(
//                                     validator: (val) {
//                                       if (val!.isEmpty) {
//                                         return "Required";
//                                       }
//                                       return null;
//                                     },
//                                     onTextChange: (value) {},
//                                     textInputType: TextInputType.name,
//                                     hasMargin: false,
//                                     capitalization: TextCapitalization.words,
//                                     title: "What is product brand?",
//                                     hint: "Enter text",
//                                     backgroundColor:
//                                     Color.fromRGBO(158, 119, 119, 0.2),
//                                     controller: TextEditingController(),
//                                   ),
//
//
//                                   Spaces.y2,
//                                   CustomMultilineTextField(
//                                     validator: (val) {
//                                       if (val!.isEmpty) {
//                                         return "Required";
//                                       }
//                                       return null;
//                                     },
//                                     onTextChange: (value) {},
//                                     textInputType: TextInputType.name,
//                                     hasMargin: false,
//                                     capitalization: TextCapitalization.words,
//                                     title: "How many years have you used this product?",
//                                     hint: "Enter text",
//                                     backgroundColor:
//                                     Color.fromRGBO(158, 119, 119, 0.2),
//                                     controller: TextEditingController(),
//                                   ),
//                                   Spaces.y2,
//
//                                   CustomMultilineTextField(
//                                     validator: (val) {
//                                       if (val!.isEmpty) {
//                                         return "Required";
//                                       }
//                                       return null;
//                                     },
//                                     onTextChange: (value) {},
//                                     textInputType: TextInputType.name,
//                                     hasMargin: false,
//                                     capitalization: TextCapitalization.words,
//                                     title:"Does it come with receipt/box?",
//                                     hint: "Enter text",
//                                     backgroundColor:
//                                     Color.fromRGBO(158, 119, 119, 0.2),
//                                     controller: TextEditingController(),
//                                   ),
//                                   Spaces.y10,
//
//                                   CustomElevatedButton(
//                                     onPress: () async {
//
//                                       Get.to(DonateThobe());
//                                     },
//                                     height: 6.5.h,
//
//                                     title: "List",
//                                     titleColor: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                     bgColor: ColorConstants.primaryColor,
//                                     borderRadius: 7,
//                                   ),
//                                 ]
//                             )
//                         )
//                     )
//                 )
//             )
//         )
//     );
//   }
// }
