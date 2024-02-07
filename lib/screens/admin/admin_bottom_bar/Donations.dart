import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/models/DonationModel.dart';
import 'package:timeless/screens/Customer_screens/Donate/donated_product_details.dart';

import '../../../Constants/color_constants.dart';
import '../../../Constants/firebase_consts.dart';
import '../../../Constants/font_styles.dart';
import '../../../utils/space_values.dart';
import '../../bottom_bar/notifications_screen.dart';

class Donations extends StatefulWidget {
  const Donations({super.key});

  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          "Donations",
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.0.w),
            child: InkWell(
                onTap: () {
                  Get.to(NotificationsScreen());
                },
                child: Icon(
                  Icons.notifications,
                  color: ColorConstants.primaryColor,
                  size: 22.sp,
                )),
          )
        ],
      ),
      body: StreamBuilder(
          stream: firestore.collection("Donations").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              List<DonationModel> products = [];
              for (var doc in documents) {
                products.add(
                    DonationModel.fromMap(doc.data() as Map<String, dynamic>));
              }
              return products.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: documents.length,
                      itemBuilder: (c, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(DonatedProductDetails(
                                selectedProduct: products[index]));
                          },
                          child: ProductCard(
                            donatedProd: products[index],
                            onDeleteEvent: () {},
                          ),
                        );
                      })
                  : const Center(
                      child: Text("No donated items..."),
                    );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.donatedProd,
    required this.onDeleteEvent,
  });
  final DonationModel donatedProd;
  final VoidCallback onDeleteEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 0.5,
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          children: [
            Row(
              children: [
                Spaces.x2,
                Flexible(
                  flex: 2,
                  child: Container(
                    height: 13.h,
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                          image: NetworkImage(
                            donatedProd.prodImg[0],
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Column(
                      children: [
                        Spaces.y1,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(donatedProd.prodName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                FontStyles.boldBlackBodyText),
                                        Container(
                                          width: 17.w,
                                          height: 2.5.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              border: Border.all()),
                                          child: Center(
                                              child: Text(
                                            donatedProd.deliveryMode,
                                            textAlign: TextAlign.center,
                                            style: FontStyles.smallGreyBodyText,
                                          )),
                                        )
                                      ],
                                    ),
                                    Text("Category: ${donatedProd.category}",
                                        style: FontStyles.smallGreyBodyText),
                                    Text("Color: ${donatedProd.color}",
                                        style: FontStyles.smallGreyBodyText),
                                    Text("Receipt: ${donatedProd.receipt}",
                                        style: FontStyles.smallGreyBodyText),
                                    Text("Size: ${donatedProd.size}",
                                        style: FontStyles.smallGreyBodyText),
                                    Text(
                                        "Used for: ${donatedProd.usedDuration}",
                                        style: FontStyles.smallGreyBodyText),
                                  ],
                                )),
                            // Spaces.x6,
                          ],
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       flex: 1,
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //
                        //         ],
                        //       ),
                        //     ),
                        //     // Spaces.x6,
                        //
                        //   ],
                        // ),
                        Spaces.y1,
                      ],
                    ),
                  ),
                ),
                Spaces.x1,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
