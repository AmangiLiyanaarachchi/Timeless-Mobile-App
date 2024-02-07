import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/Constants/firebase_consts.dart';
import 'package:timeless/models/DonationModel.dart';

import '../../../Constants/color_constants.dart';
import '../../../Constants/font_styles.dart';
import '../../../utils/space_values.dart';

class DonatedProductDetails extends StatefulWidget {
  const DonatedProductDetails({super.key, required this.selectedProduct});
  final DonationModel selectedProduct;

  @override
  State<DonatedProductDetails> createState() => _DonatedProductDetailsState();
}

class _DonatedProductDetailsState extends State<DonatedProductDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
          title: Text(
            "Product Details",
            style: FontStyles.appBarStylePC,
          ),
          centerTitle: true,
        ),
        body: SizedBox(
            child: SingleChildScrollView(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spaces.y2,
                              CarouselSlider.builder(
                                itemCount:
                                    widget.selectedProduct.prodImg.length,
                                itemBuilder: (c, index, realIndex) {
                                  return Image.network(
                                    widget.selectedProduct.prodImg[index],
                                    fit: BoxFit.cover,
                                  );
                                },
                                options: CarouselOptions(
                                    padEnds: true,
                                    aspectRatio: 10 / 6,
                                    enlargeCenterPage: false,
                                    autoPlay: false,
                                    enableInfiniteScroll: true,
                                    initialPage: 0,
                                    viewportFraction: 0.45),
                              ),
                              Spaces.y2,
                              Text(
                                "Name",
                                style: FontStyles.boldBlackBodyText,
                              ),
                              Container(
                                height: 5.h,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(158, 119, 119, 0.2),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.0.w, top: 1.h),
                                  child: Text(
                                    widget.selectedProduct.prodName,
                                    style: FontStyles.blackBodyText,
                                  ),
                                ),
                              ),
                              Spaces.y2,
                              Text(
                                "Category",
                                style: FontStyles.boldBlackBodyText,
                              ),
                              Container(
                                height: 5.h,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(158, 119, 119, 0.2),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.0.w, top: 1.h),
                                  child: Text(
                                    widget.selectedProduct.category,
                                    style: FontStyles.blackBodyText,
                                  ),
                                ),
                              ),
                              Spaces.y2,
                              Text(
                                "Size",
                                style: FontStyles.boldBlackBodyText,
                              ),
                              Container(
                                height: 5.h,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(158, 119, 119, 0.2),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.0.w, top: 1.h),
                                  child: Text(
                                    widget.selectedProduct.size,
                                    style: FontStyles.blackBodyText,
                                  ),
                                ),
                              ),
                              Spaces.y2,
                              Text(
                                "Color",
                                style: FontStyles.boldBlackBodyText,
                              ),
                              Container(
                                height: 5.h,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(158, 119, 119, 0.2),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.0.w, top: 1.h),
                                  child: Text(
                                    widget.selectedProduct.color,
                                    style: FontStyles.blackBodyText,
                                  ),
                                ),
                              ),
                              Spaces.y2,
                              Text(
                                "Brand",
                                style: FontStyles.boldBlackBodyText,
                              ),
                              Container(
                                height: 5.h,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(158, 119, 119, 0.2),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.0.w, top: 1.h),
                                  child: Text(
                                    widget.selectedProduct.prodBrand,
                                    style: FontStyles.blackBodyText,
                                  ),
                                ),
                              ),
                              Spaces.y2,
                              Text(
                                "Used Duration",
                                style: FontStyles.boldBlackBodyText,
                              ),
                              Container(
                                height: 5.h,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(158, 119, 119, 0.2),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 4.0.w, top: 1.h),
                                  child: Text(
                                    widget.selectedProduct.usedDuration,
                                    style: FontStyles.blackBodyText,
                                  ),
                                ),
                              ),
                              Spaces.y2,
                              Text(
                                "Receipt?",
                                style: FontStyles.boldBlackBodyText,
                              ),
                              Container(
                                height: 5.h,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(158, 119, 119, 0.2),
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.0.w),
                                      child: Text(
                                        widget.selectedProduct.receipt,
                                        style: FontStyles.blackBodyText,
                                      ),
                                    )),
                              ),
                              Spaces.y2,
                              Text(
                                "Description",
                                style: FontStyles.boldBlackBodyText,
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(158, 119, 119, 0.2),
                                    borderRadius: BorderRadius.circular(7.sp),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 4.0.w, top: 1.h, bottom: 1.h),
                                    child: Text(
                                      widget.selectedProduct.prodDisc,
                                      style: FontStyles.blackBodyText,
                                    ),
                                  ),
                                ),
                              ),
                              Spaces.y4,
                              widget.selectedProduct.deliveryMode == "Pick up"
                                  ? StreamBuilder(
                                      stream: firestore
                                          .collection("Donations")
                                          .doc(widget.selectedProduct.uid)
                                          .collection("PickUp")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        final data = snapshot.data!.docs[0];
                                        final document = data.data();
                                        if (!snapshot.hasData) {
                                          return CircularProgressIndicator();
                                        } else {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Pick up details:",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spaces.y1,
                                              Text(
                                                "Phone number",
                                                style: FontStyles
                                                    .boldBlackBodyText,
                                              ),
                                              Container(
                                                height: 5.h,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      158, 119, 119, 0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.sp),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.0.w, top: 1.h),
                                                  child: Text(
                                                    document["phoneNumber"],
                                                    style: FontStyles
                                                        .blackBodyText,
                                                  ),
                                                ),
                                              ),
                                              Spaces.y2,
                                              Text(
                                                "Address",
                                                style: FontStyles
                                                    .boldBlackBodyText,
                                              ),
                                              Container(
                                                height: 5.h,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      158, 119, 119, 0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.sp),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.0.w, top: 1.h),
                                                  child: Text(
                                                    document["Address"],
                                                    style: FontStyles
                                                        .blackBodyText,
                                                  ),
                                                ),
                                              ),
                                              Spaces.y2,
                                              Text(
                                                "Postal Code",
                                                style: FontStyles
                                                    .boldBlackBodyText,
                                              ),
                                              Container(
                                                height: 5.h,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      158, 119, 119, 0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.sp),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.0.w, top: 1.h),
                                                  child: Text(
                                                    document["PostalCode"],
                                                    style: FontStyles
                                                        .blackBodyText,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      })
                                  : SizedBox.shrink(),
                              Spaces.y4,
                            ]))))));
  }
}
