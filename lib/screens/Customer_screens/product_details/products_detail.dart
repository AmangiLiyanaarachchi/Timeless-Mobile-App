import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/controllers/review_controller.dart';
import 'package:timeless/models/ColorModel.dart';
import 'package:timeless/models/ProductModel.dart';
import 'package:timeless/widgets/custom_elevated_button.dart';
import 'package:timeless/widgets/multiline_text_field.dart';
import 'package:timeless/screens/Customer_screens/BottomBarNew/bottom_bar.dart';
import 'package:timeless/utils/utility_const.dart';
import '../../../Constants/color_constants.dart';
import '../../../constants/font_styles.dart';
import '../../../controllers/call_controllers.dart';
import '../../../models/ReviewModel.dart';
import '../../../models/temp/sizes.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_gradient_button.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.selectedProd,
  });
  final ProductModel selectedProd;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

enum SampleItem { itemOne }

class _ProductDetailsState extends State<ProductDetails> {
  ReviewController review = ReviewController();
  int selectedIndex = 0;
  int selectedColorIndex = 0;

  bool visible = false;
  bool isvisible = false;

  Future<List<ReviewModel>> fetchProductReviews(String productId) async {
    List<ReviewModel> reviews = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection("ProductReviews")
        .where("productId", isEqualTo: productId)
        .get();

    querySnapshot.docs.forEach((doc) {
      reviews.add(ReviewModel.fromMap(doc.data()));
    });

    return reviews;
  }

  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spaces.y2,
                    CarouselSlider.builder(
                      itemCount: widget.selectedProd.productimage.length,
                      itemBuilder: (c, index, realIndex) {
                        return Image.network(
                          widget.selectedProd.productimage[index],
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
                    Spaces.y1,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("QAR. ${widget.selectedProd.price}",
                            style: TextStyle(
                              fontSize: 24,
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.w600,
                            )),
                        auth.currentUser!.uid != adminId
                            ? StreamBuilder(
                                stream: firestore
                                    .collection("Wishlist")
                                    .where("custId",
                                        isEqualTo: auth.currentUser!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List found = [];
                                    for (var doc in snapshot.data!.docs) {
                                      if (doc.data()['prodId'] ==
                                          widget.selectedProd.uid) {
                                        found.add(true);
                                        break;
                                      }
                                    }

                                    return InkWell(
                                      splashColor: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(40.0),
                                      onTap: () async {
                                        try {
                                          setLoading();

                                          if (found.isNotEmpty) {
                                            await wishlistController
                                                .removeItemfromWishlist(
                                                    widget.selectedProd.uid);

                                            hideLoading();
                                          } else {
                                            await wishlistController
                                                .addItemtoWishlist(
                                                    widget.selectedProd.uid);
                                          }
                                        } catch (e) {
                                          found.clear();
                                          hideLoading();
                                          log("Errpr $e");
                                        }
                                      },
                                      child: found.isNotEmpty
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                            ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                })
                            : InkWell(
                                splashColor: ColorConstants.primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.0),
                                onTap: () {},
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                )),
                      ],
                    ),
                    Text(widget.selectedProd.productname.capitalizeFirst!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    Spaces.y1,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 2.h,
                              color: Colors.yellow,
                            ),
                            Spaces.x1,
                            StreamBuilder(
                                stream: firestore
                                    .collection("ProductReviews")
                                    .where("productId",
                                        isEqualTo: widget.selectedProd.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.docs.isNotEmpty) {
                                      var ratingCount = 0.0;
                                      var ratings = 0.0;
                                      for (var doc in snapshot.data!.docs) {
                                        ratingCount = ratingCount +
                                            double.parse(doc
                                                .data()['rating']
                                                .toString());
                                      }
                                      ratings = ratingCount /
                                          snapshot.data!.docs.length;

                                      return Text(
                                        '${ratings}',
                                        style: FontStyles.smallGreyBodyText,
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }
                                  return const SizedBox.shrink();
                                }),
                          ],
                        ),
                        auth.currentUser!.uid != adminId
                            ? Row(
                                children: [
                                  InkWell(
                                      borderRadius: BorderRadius.circular(30.0),
                                      onTap: () {
                                        orderController.quant.value += 1;
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 2.h,
                                      )),
                                  Spaces.x1,
                                  Obx(
                                    () => Text(
                                      orderController.quant.value.toString(),
                                      style: FontStyles.smallBlackBodyText,
                                    ),
                                  ),
                                  Spaces.x1,
                                  InkWell(
                                      borderRadius: BorderRadius.circular(30.0),
                                      onTap: () {
                                        if (orderController.quant.value > 1) {
                                          orderController.quant.value -= 1;
                                        }
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        size: 2.h,
                                      )),
                                ],
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                    Spaces.y2,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Available Sizes",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Spaces.y1,
                              StreamBuilder(
                                  stream: firestore
                                      .collection('Categories')
                                      .doc(widget.selectedProd.catId)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox.shrink();
                                    } else {
                                      if (snapshot.data != null) {
                                        return snapshot.data!
                                                    .data()!['title'] ==
                                                "Footwear"
                                            ? Wrap(
                                                spacing: 2.w,
                                                children:
                                                    auth.currentUser!.uid ==
                                                            adminId
                                                        ? widget
                                                            .selectedProd.size
                                                            .map((size) {
                                                            return ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        elevation:
                                                                            0.3,
                                                                        backgroundColor: size.contains(size)
                                                                            ? ColorConstants.primaryColor
                                                                            : Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            side: const BorderSide(
                                                                              color: ColorConstants.primaryColor,
                                                                            ))),
                                                                child: Text(
                                                                  size,
                                                                  style: size.contains(
                                                                          size)
                                                                      ? FontStyles
                                                                          .boldWhiteBodyText
                                                                      : FontStyles
                                                                          .boldPcBodyText,
                                                                ));
                                                          }).toList()
                                                        : footwearSizes
                                                            .map((size) {
                                                            return Obx(
                                                              () => ElevatedButton(
                                                                  onPressed: () {
                                                                    if (orderController
                                                                            .selShoeSize
                                                                            .value ==
                                                                        size) {
                                                                      orderController
                                                                          .selShoeSize
                                                                          .value = "05";
                                                                    } else {
                                                                      orderController
                                                                          .selShoeSize
                                                                          .value = size;
                                                                    }
                                                                    orderController
                                                                            .selSize
                                                                            .value =
                                                                        ""; //dress size should be null,
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      elevation: 0.3,
                                                                      backgroundColor: orderController.selShoeSize.value == size ? ColorConstants.primaryColor : Colors.white,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(5.0),
                                                                          side: const BorderSide(
                                                                            color:
                                                                                ColorConstants.primaryColor,
                                                                          ))),
                                                                  child: Obx(
                                                                    () => Text(
                                                                      size,
                                                                      style: orderController.selShoeSize.value ==
                                                                              size
                                                                          ? FontStyles
                                                                              .boldWhiteBodyText
                                                                          : FontStyles
                                                                              .boldPcBodyText,
                                                                    ),
                                                                  )),
                                                            );
                                                          }).toList(),
                                              )
                                            : Wrap(
                                                spacing: 2.w,
                                                children:
                                                    auth.currentUser!.uid ==
                                                            adminId
                                                        ? widget
                                                            .selectedProd.size
                                                            .map((size) {
                                                            return ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        elevation:
                                                                            0.3,
                                                                        backgroundColor: size.contains(size)
                                                                            ? ColorConstants.primaryColor
                                                                            : Colors.white,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                            side: const BorderSide(
                                                                              color: ColorConstants.primaryColor,
                                                                            ))),
                                                                child: Text(
                                                                  size,
                                                                  style: size.contains(
                                                                          size)
                                                                      ? FontStyles
                                                                          .boldWhiteBodyText
                                                                      : FontStyles
                                                                          .boldPcBodyText,
                                                                ));
                                                          }).toList()
                                                        : availableSizes
                                                            .map((size) {
                                                            return Obx(
                                                              () => ElevatedButton(
                                                                  onPressed: () {
                                                                    if (orderController
                                                                            .selSize
                                                                            .value ==
                                                                        size) {
                                                                      orderController
                                                                          .selSize
                                                                          .value = "XS";
                                                                    } else {
                                                                      orderController
                                                                          .selSize
                                                                          .value = size;
                                                                    }
                                                                    orderController
                                                                            .selShoeSize
                                                                            .value =
                                                                        ""; //footwear sizes should be null,
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      elevation: 0.3,
                                                                      backgroundColor: orderController.selSize.value == size ? ColorConstants.primaryColor : Colors.white,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(5.0),
                                                                          side: const BorderSide(
                                                                            color:
                                                                                ColorConstants.primaryColor,
                                                                          ))),
                                                                  child: Obx(
                                                                    () => Text(
                                                                      size,
                                                                      style: orderController.selSize.value ==
                                                                              size
                                                                          ? FontStyles
                                                                              .boldWhiteBodyText
                                                                          : FontStyles
                                                                              .boldPcBodyText,
                                                                    ),
                                                                  )),
                                                            );
                                                          }).toList(),
                                              );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }
                                  }),
                            ],
                          ),
                          Spaces.y2,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Available Colors",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Spaces.y1,
                              StreamBuilder(
                                  stream: firestore
                                      .collection("Colors")
                                      .where("uid",
                                          whereIn: widget
                                              .selectedProd.availablecolors)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox.shrink();
                                    } else {
                                      List<ColorModel> colors = [];
                                      for (var color in snapshot.data!.docs) {
                                        colors.add(
                                            ColorModel.fromMap(color.data()));
                                      }
                                      orderController.selColor.value =
                                          colors[0].title;

                                      return Wrap(
                                        spacing: 2.w,
                                        runSpacing: 1.h,
                                        children: colors.map((color) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (orderController
                                                      .selColor.value ==
                                                  color.title) {
                                                orderController.selColor.value =
                                                    colors[0].title;
                                                ;
                                              } else {
                                                orderController.selColor.value =
                                                    color.title;
                                              }
                                            },
                                            child: Obx(
                                              () => Container(
                                                width: orderController
                                                            .selColor.value ==
                                                        color.title
                                                    ? 40
                                                    : 35,
                                                height: orderController
                                                            .selColor.value ==
                                                        color.title
                                                    ? 40
                                                    : 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(
                                                    int.parse(
                                                        '0xff${color.hexcode}'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }
                                  }),
                            ],
                          ),
                          auth.currentUser!.uid != adminId
                              ? Column(
                                  children: [
                                    Spaces.y2,
                                    Divider(
                                      color: Colors.grey.shade300,
                                    ),
                                    Spaces.y1,
                                    widget.selectedProd.quantity > 0
                                        ? StreamBuilder(
                                            stream: firestore
                                                .collection("Cart")
                                                .where("custId",
                                                    isEqualTo:
                                                        auth.currentUser!.uid)
                                                .where("prodId",
                                                    isEqualTo:
                                                        widget.selectedProd.uid)
                                                .where("status",
                                                    isEqualTo: "active")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const SizedBox.shrink();
                                              } else {
                                                print(
                                                    "snapshot ${snapshot.data!.docs.length}");
                                                return CustomGradientButton(
                                                  color1: snapshot
                                                          .data!.docs.isEmpty
                                                      ? ColorConstants
                                                          .primaryColor
                                                      : ColorConstants
                                                          .primaryColor
                                                          .withOpacity(0.6),
                                                  color2: snapshot
                                                          .data!.docs.isEmpty
                                                      ? ColorConstants
                                                          .primaryColor
                                                          .withOpacity(0.7)
                                                      : ColorConstants
                                                          .primaryColor
                                                          .withOpacity(0.6),
                                                  title: snapshot
                                                          .data!.docs.isEmpty
                                                      ? "Add to Cart"
                                                      : "Added to Cart",
                                                  onPress: () async {
                                                    if (snapshot
                                                        .data!.docs.isEmpty) {
                                                      await orderController
                                                          .addToCart(
                                                              widget
                                                                  .selectedProd
                                                                  .uid,
                                                              widget
                                                                  .selectedProd
                                                                  .price);
                                                      bottombarController
                                                          .selectedIndex
                                                          .value = 3;
                                                      Get.offAll(
                                                          BottomBarScreen1());
                                                    }
                                                  },
                                                  titleColor: Colors.white,
                                                  height: 6.h,
                                                  borderRadius: 12.0,
                                                );
                                              }
                                            },
                                          )
                                        : CustomGradientButton(
                                            color1: ColorConstants.primaryColor
                                                .withOpacity(0.6),
                                            color2: ColorConstants.primaryColor
                                                .withOpacity(0.7),
                                            title: "Sold Out",
                                            titleColor: Colors.white,
                                            height: 6.h,
                                            borderRadius: 12.0,
                                          ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          Spaces.y3,
                          Text(
                            "Rate this Product",
                            style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spaces.y2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add a review",
                                style: TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // SizedBox(width: 20.w,),

                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      isvisible = !isvisible;
                                    });
                                  },
                                  child: Icon(
                                    isvisible == true
                                        ? Icons.highlight_off_outlined
                                        : Icons.edit,
                                    color: ColorConstants.primaryColor,
                                  )),
                            ],
                          ),
                          Spaces.y2,
                          Visibility(
                            visible: isvisible,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: CupertinoColors.systemGrey2),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spaces.y3,
                                    RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        itemSize: 38,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color:
                                                  ColorConstants.yellowLevel1,
                                            ),
                                        onRatingUpdate: (rating) {
                                          setState(() {
                                            review.selRating = rating;
                                          });
                                        }),
                                    Spaces.y2,
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: CustomMultilineTextField(
                                        capitalization:
                                            TextCapitalization.sentences,
                                        onTextChange: (value) {},
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        controller: review.reviewController,
                                        hasMargin: false,
                                        hint: "Describe your experience",
                                        borderColor: Colors.grey,
                                        maxLines: 10,
                                      ),
                                    ),
                                    Spaces.y2,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomElevatedButton(
                                          onPress: () {
                                            if (review.reviewController.text
                                                .isNotEmpty) {
                                              review.createReview(context,
                                                  widget.selectedProd.uid);
                                              setState(() {
                                                isvisible = !isvisible;
                                              });
                                            }
                                          },
                                          title: "Submit",
                                          fontSize: 16,
                                          bgColor: ColorConstants.primaryColor,
                                          height: 4.h,
                                          borderRadius: 7,
                                        ),
                                        CustomElevatedButton(
                                          onPress: () {
                                            setState(() {
                                              isvisible = !isvisible;
                                            });
                                            review.reviewController.clear();
                                          },
                                          title: "Cancel",
                                          fontSize: 16,
                                          height: 4.h,
                                          borderRadius: 7,
                                          titleColor: Colors.black,
                                          bgColor: Colors.grey[300],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spaces.y2,
                          Text(
                            "Reviews",
                            style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          Spaces.y2,
                          Wrap(children: [
                            Container(
                              child: FutureBuilder<List<ReviewModel>>(
                                future: fetchProductReviews(
                                    widget.selectedProd.uid),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Center(
                                        child: Text('No reviews available.'));
                                  } else {
                                    List<ReviewModel> reviews = snapshot.data!;

                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: reviews.length,
                                      itemBuilder: (context, index) {
                                        var review = reviews[index];
                                        return Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('Customers')
                                                      .doc(review.creatorId)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator(); // Show a loading indicator while fetching data.
                                                    }

                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          "Error: ${snapshot.error}");
                                                    }

                                                    if (!snapshot.hasData ||
                                                        snapshot.data == null) {
                                                      return Text(
                                                          "User not found"); // Handle the case when user data is not found.
                                                    }

                                                    final userData =
                                                        snapshot.data?.data();
                                                    final userName =
                                                        userData?["fullname"];
                                                    final userProfilePicture =
                                                        userData?["profilepic"];

                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      userProfilePicture),
                                                            ),
                                                            Spaces.x3,
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  " $userName",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  "${review.createdOn?.day.toString().padLeft(2, '0')}-"
                                                                  "${review.createdOn!.month.toString().padLeft(2, '0')}-${review.createdOn?.year.toString().padLeft(2, '0')}   ${review.createdOn?.hour.toString().padLeft(2, '0')}:${review.createdOn?.minute.toString().padLeft(2, '0')}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            child: review
                                                                        .creatorId ==
                                                                    auth.currentUser!
                                                                        .uid
                                                                ? PopupMenuButton<
                                                                    String>(
                                                                    onSelected:
                                                                        (value) {
                                                                      // Handle menu item selection here
                                                                      print(
                                                                          'Selected: $value');
                                                                    },
                                                                    itemBuilder: (BuildContext
                                                                            context) =>
                                                                        <PopupMenuEntry<
                                                                            String>>[
                                                                      PopupMenuItem<
                                                                          String>(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            firestore.collection("ProductReviews").doc(review.id).delete();
                                                                          });
                                                                        },
                                                                        value:
                                                                            'option_1',
                                                                        child: Text(
                                                                            'Delete'),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : null),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                              Spaces.y1,
                                              RatingBar.builder(
                                                ignoreGestures: true,
                                                initialRating: review.rating,
                                                minRating: 1,
                                                itemSize: 20,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 0.1.w),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: ColorConstants
                                                      .yellowLevel1,
                                                ),
                                                onRatingUpdate:
                                                    (double value) {},
                                              ),
                                              Spaces.y1,
                                              Text(
                                                review.review,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              Spaces.y3,
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ]),
                          Spaces.y4,
                        ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
