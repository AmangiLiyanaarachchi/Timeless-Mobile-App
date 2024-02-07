// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:timeless/screens/Customer_screens/BottomBarNew/bottom_bar.dart';
// import '../../../Constants/color_constants.dart';
// import '../../../constants/font_styles.dart';
// import '../../../utils/space_values.dart';
// import '../../../widgets/multiline_text_field.dart';

// class Interests extends StatefulWidget {
//   const Interests({super.key});

//   @override
//   State<Interests> createState() => _InterestsState();
// }

// List<String> sizes = ["Small", "Medium", "Large", "Extra Large"];

// int selectedIndex = 0;

// class _InterestsState extends State<Interests> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           scrolledUnderElevation: 0,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           automaticallyImplyLeading: true,
//           leading: const Icon(Icons.arrow_back),
//           iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
//           title: Text(
//             "Interests and sizes",
//             style: FontStyles.appBarStylePC,
//           ),
//           centerTitle: true,
//         ),
//         body: SizedBox(
//             height: height * 1,
//             width: width * 1,
//             child: SingleChildScrollView(
//                 child: Center(
//                     child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Spaces.y4,

//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   "Sizes",
//                                   style: TextStyle(
//                                       color: ColorConstants.primaryColor,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ),

//                               Spaces.y2,
//                               Text(
//                                 "Tops",
//                                 style: TextStyle(
//                                     color: ColorConstants.primaryColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                               ),

//                               Spaces.y1,

//                               Container(
//                                 width: width * 0.92,
//                                 decoration: BoxDecoration(
//                                     color: Color.fromRGBO(158, 119, 119, 0.2),
//                                     borderRadius: BorderRadius.circular(7)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20.0),
//                                   child: DropdownButtonex(),
//                                 ),
//                               ),

//                               Spaces.y2,
//                               Text(
//                                 "Bottoms",
//                                 style: TextStyle(
//                                     color: ColorConstants.primaryColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                               ),

//                               Spaces.y1,

//                               Container(
//                                 width: width * 0.92,
//                                 decoration: BoxDecoration(
//                                     color: Color.fromRGBO(158, 119, 119, 0.2),
//                                     borderRadius: BorderRadius.circular(7)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20.0),
//                                   child: DropdownButtonex(),
//                                 ),
//                               ),
//                               Spaces.y2,
//                               Text(
//                                 "Shoes",
//                                 style: TextStyle(
//                                     color: ColorConstants.primaryColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                               ),

//                               Spaces.y1,

//                               Container(
//                                 width: width * 0.92,
//                                 decoration: BoxDecoration(
//                                     color: Color.fromRGBO(158, 119, 119, 0.2),
//                                     borderRadius: BorderRadius.circular(7)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20.0),
//                                   child: DropdownButtonex(),
//                                 ),
//                               ),

//                               Spaces.y5,

//                               Text(
//                                 "Brands",
//                                 style: TextStyle(
//                                     color: ColorConstants.primaryColor,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w500),
//                               ),

//                               Spaces.y1,
//                               Text(
//                                 "Write down your favourite brands",
//                                 style: TextStyle(
//                                     color: ColorConstants.primaryColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                               ),

//                               //Spaces.y1,

//                               CustomMultilineTextField(
//                                 validator: (val) {
//                                   if (val!.isEmpty) {
//                                     return "Required";
//                                   }
//                                   return null;
//                                 },
//                                 capitalization: TextCapitalization.none,

//                                 onTextChange: (value) {},
//                                 hint: "---",
//                                 maxLines: 5,
//                                 backgroundColor:
//                                     Color.fromRGBO(158, 119, 119, 0.2),
//                                 controller: TextEditingController(),
//                                 hasMargin: false,
//                                 //onPasswordEyeClick: ,
//                               ),

//                               Spaces.y3,

//                               Text(
//                                 "Colors",
//                                 style: TextStyle(
//                                     color: ColorConstants.primaryColor,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                               Spaces.y1,

//                               Row(
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       selectedIndex = 1;
//                                       setState(() {});
//                                     },
//                                     child: Container(
//                                       width: 35,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           color: Color(0xfffca518)),
//                                       child: Icon(
//                                         Icons.check,
//                                         color: selectedIndex == 1
//                                             ? Colors.white
//                                             : Color(0xfffca518),
//                                       ),
//                                     ),
//                                   ),
//                                   Spaces.x2,
//                                   InkWell(
//                                     onTap: () {
//                                       selectedIndex = 2;
//                                       setState(() {});
//                                     },
//                                     child: Container(
//                                       width: 35,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           color: Color(0xff18fbe0)),
//                                       child: Icon(
//                                         Icons.check,
//                                         color: selectedIndex == 2
//                                             ? Colors.white
//                                             : Color(0xff18fbe0),
//                                       ),
//                                     ),
//                                   ),
//                                   Spaces.x2,
//                                   InkWell(
//                                     onTap: () {
//                                       selectedIndex = 3;
//                                       setState(() {});
//                                     },
//                                     child: Container(
//                                       width: 35,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           color: Color(0xff18a9fb)),
//                                       child: Icon(
//                                         Icons.check,
//                                         color: selectedIndex == 3
//                                             ? Colors.white
//                                             : Color(0xff18a9fb),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),

//                               Spaces.y3,

//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: InkWell(
//                                   onTap: () {
//                                     Get.to(BottomBarScreen1());
//                                   },
//                                   child: Container(
//                                     width: 18.w,
//                                     child: Row(
//                                       children: [
//                                         Text("Skip",
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w500,
//                                             )),
//                                         Icon(
//                                           Icons.arrow_forward_ios,
//                                           size: 20,
//                                         ),
//                                         //Icon(Icons.arrow_forward_ios, size: 20,),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ]))))));
//   }
// }

// class DropdownButtonex extends StatefulWidget {
//   const DropdownButtonex({super.key});

//   @override
//   State<DropdownButtonex> createState() => _DropdownButtonexState();
// }

// class _DropdownButtonexState extends State<DropdownButtonex> {
//   String dropdownValue = sizes.first;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: Padding(
//         padding: const EdgeInsets.only(left: 175.0),
//         child: const Icon(
//           Icons.arrow_drop_down_sharp,
//           color: ColorConstants.primaryColor,
//         ),
//       ),

//       //elevation: 16,
//       style: const TextStyle(color: ColorConstants.primaryColor, fontSize: 15),
//       underline: Container(),

//       onChanged: (String? value) {
//         // This is called when the user selects an item.
//         setState(() {
//           dropdownValue = value!;
//         });
//       },
//       items: sizes.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
