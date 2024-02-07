import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/models/CategoryModel.dart';
import 'package:timeless/models/OrderModel.dart';
import 'package:timeless/models/ProductModel.dart';
import 'package:timeless/screens/Customer_screens/Orders/order_history/order_screen.dart';
import 'package:timeless/screens/Customer_screens/product_details/products.dart';
import 'package:timeless/widgets/dialogs/add_category.dart';

import '../../../../constants/color_constants.dart';
import '../../../../constants/font_styles.dart';
import '../../../../utils/space_values.dart';
import '../../../bottom_bar/notifications_screen.dart';
import '../Donations.dart';

class StoreRevenue extends StatefulWidget {
  const StoreRevenue({super.key});

  @override
  State<StoreRevenue> createState() => _StoreRevenueState();
}

class _StoreRevenueState extends State<StoreRevenue> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: ColorConstants.primaryColor),
          leadingWidth: 10.w,
          leading: InkWell(
              onTap: () {
                Get.to(Donations());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 3.0.w),
                child: Image.asset(
                  "assets/images/donate1.png",
                  color: ColorConstants.primaryColor,
                ),
              )),
          title: Text(
            "Store",
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              StreamBuilder(
                  stream: firestore.collection("Orders").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var totalSale = 0;
                      List<OrderModel> newOrders = [];
                      List<OrderModel> inprogressOrders = [];
                      List<OrderModel> deliveredOrders = [];
                      for (var doc in snapshot.data!.docs) {
                        if (doc.data()['orderStatus'] == 'pending') {
                          newOrders.add(OrderModel.fromMap(doc.data()));
                        } else if (doc.data()['orderStatus'] == 'shipped') {
                          inprogressOrders.add(OrderModel.fromMap(doc.data()));
                        } else if (doc.data()['orderStatus'] == 'completed') {
                          deliveredOrders.add(OrderModel.fromMap(doc.data()));
                        }
                        totalSale = totalSale +
                            int.parse(doc.data()['totalBill'].toString());
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(OrderScreen()),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(193, 170, 170, 0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 6.w),
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Orders",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spaces.y0,
                                  Text(
                                    snapshot.data!.docs.length
                                        .toString()
                                        .padLeft(2, '0'),
                                    style: TextStyle(
                                      color: ColorConstants.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Spaces.y1,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("New",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text(
                                          newOrders.length
                                              .toString()
                                              .padLeft(2, '0'),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ],
                                  ),
                                  Spaces.y1,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("In progress",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text(
                                          inprogressOrders.length
                                              .toString()
                                              .padLeft(2, '0'),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ],
                                  ),
                                  Spaces.y1,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Delivered",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text(
                                          deliveredOrders.length
                                              .toString()
                                              .padLeft(2, '0'),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spaces.y2,
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(193, 170, 170, 0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Sales",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spaces.y0,
                                Text(
                                  "QAR. ${totalSale.toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    color: ColorConstants.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spaces.y2,
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(193, 170, 170, 0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Products",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spaces.y0,
                                StreamBuilder(
                                    stream: firestore
                                        .collection("Products")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!.docs.length
                                              .toString()
                                              .padLeft(2, '0'),
                                          style: TextStyle(
                                            color: ColorConstants.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    }),
                              ],
                            ),
                          ),
                          Spaces.y2,
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(193, 170, 170, 0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            child: StreamBuilder(
                                stream: firestore
                                    .collection("Categories")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0,
                                              right: 18.0,
                                              top: 18.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Categories",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton.filled(
                                                      onPressed: () {
                                                        var addDialog =
                                                            AddCategory();
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return addDialog;
                                                            });
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      )),
                                                ],
                                              ),
                                              Text(
                                                snapshot.data!.docs.length
                                                    .toString()
                                                    .padLeft(2, '0'),
                                                style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (c, index) {
                                              if (snapshot.hasData) {
                                                CategoryModel category =
                                                    CategoryModel.fromMap(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data());
                                                return ListTile(
                                                  shape: Border(
                                                      bottom: BorderSide(
                                                          color: ColorConstants
                                                              .primaryColor
                                                              .withOpacity(
                                                                  0.1))),
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(snapshot
                                                            .data!.docs[index]
                                                            .data()['imgUrl']),
                                                  ),
                                                  title: Text(
                                                    snapshot.data!.docs[index]
                                                        .data()['title'],
                                                    style: FontStyles
                                                        .blackBodyText,
                                                  ),
                                                  subtitle: StreamBuilder(
                                                      stream: firestore
                                                          .collection(
                                                              "Products")
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          List<ProductModel>
                                                              products = [];
                                                          for (var doc
                                                              in snapshot
                                                                  .data!.docs) {
                                                            if (doc.data()[
                                                                    'catId'] ==
                                                                category.uid) {
                                                              products.add(
                                                                  ProductModel
                                                                      .fromMap(doc
                                                                          .data()));
                                                            }
                                                          }
                                                          return GestureDetector(
                                                            onTap: () => Get.to(
                                                                ProductsScreen(
                                                                    products:
                                                                        products,
                                                                    appbarTitle:
                                                                        category
                                                                            .title)),
                                                            child: Text(
                                                                '${products.length.toString().padLeft(2, '0')} Products'),
                                                          );
                                                        }
                                                        return const SizedBox
                                                            .shrink();
                                                      }),
                                                  trailing: Switch(
                                                    activeTrackColor:
                                                        ColorConstants
                                                            .primaryColor,
                                                    inactiveTrackColor:
                                                        Colors.white,
                                                    inactiveThumbColor:
                                                        ColorConstants
                                                            .primaryColor,
                                                    trackOutlineColor:
                                                        const MaterialStatePropertyAll(
                                                            ColorConstants
                                                                .primaryColor),
                                                    value: category.enabled,
                                                    onChanged: (val) async {
                                                      if (category.enabled) {
                                                        await productController
                                                            .updateCategory(
                                                                category.uid,
                                                                false);
                                                      } else {
                                                        await productController
                                                            .updateCategory(
                                                                category.uid,
                                                                true);
                                                      }
                                                    },
                                                  ),
                                                );
                                              }
                                              return const SizedBox.shrink();
                                            })
                                      ],
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                          ),
                          Spaces.y2,
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
