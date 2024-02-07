import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/font_styles.dart';
import 'package:timeless/models/ProductModel.dart';
import 'package:timeless/screens/Customer_screens/product_details/products_detail.dart';
import '../../../../Constants/color_constants.dart';
import '../../../../Constants/firebase_consts.dart';
import '../../../../models/CartModel.dart';
import '../../../../models/OrderModel.dart';
import '../../../../models/UserModel.dart';
import '../../../../utils/space_values.dart';

class OrderDetailWScreen extends StatelessWidget {
  const OrderDetailWScreen(
      {super.key, required this.order, required this.user});
  final OrderModel order;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 23, 23)),
        backgroundColor: Theme.of(context).canvasColor,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          "Order Details".tr,
          style: FontStyles.appBarStyleBlack,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
              height: 100.h,
              width: 80.w,
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Spaces.y2,
                  Flexible(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: order.cartIds.length,
                          itemBuilder: (c, index) {
                            return StreamBuilder(
                                stream: firestore
                                    .collection("Cart")
                                    .doc(order.cartIds[index])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.exists) {
                                      CartModel cartItem = CartModel.fromMap(
                                          snapshot.data!.data()
                                              as Map<String, dynamic>);
                                      return StreamBuilder(
                                          stream: //multiple types of items in same cart
                                              firestore
                                                  .collection("Products")
                                                  .doc(cartItem.prodId)
                                                  .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              ProductModel product =
                                                  ProductModel.fromMap(snapshot
                                                          .data!
                                                          .data()
                                                      as Map<String, dynamic>);
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 0.2.h),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w,
                                                    vertical: 2.h),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.2)),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              product
                                                                  .productname,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: FontStyles
                                                                  .boldBlackBodyText),
                                                          Text(
                                                              "Items: ${cartItem.prodQuant}",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: FontStyles
                                                                  .blackBodyText),
                                                        ],
                                                      ),
                                                    ),
                                                    Spaces.y1,
                                                    Container(
                                                      width: double.maxFinite,
                                                      color: Colors.grey
                                                          .withOpacity(0.4),
                                                    ),
                                                    Spaces.y1,
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.4))),
                                                                  child: Image
                                                                      .network(
                                                                    product
                                                                        .productimage[0],
                                                                    width:
                                                                        21.5.w,
                                                                    height: 8.h,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )),
                                                              Spaces.y0,
                                                            ],
                                                          ),
                                                        ),
                                                        Spaces.x4,
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Unit Price",
                                                                style: FontStyles
                                                                    .smallBlackBodyText,
                                                              ),
                                                              Spaces.y1,
                                                              Text(
                                                                "Sub-Total",
                                                                style: FontStyles
                                                                    .smallBlackBodyText,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Spaces.x4,
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  "QAR. ${product.price}",
                                                                  style: FontStyles
                                                                      .smallBlackBodyTextBold),
                                                              Spaces.y0,
                                                              Text(
                                                                  "QAR. ${cartItem.subTot.toString()}",
                                                                  style: FontStyles
                                                                      .smallBlackBodyTextBold),
                                                              Spaces.y0,
                                                              ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(ColorConstants
                                                                              .appSkin),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20.0)))),
                                                                  onPressed: () =>
                                                                      Get.to(ProductDetails(
                                                                          selectedProd:
                                                                              product)),
                                                                  child: Center(
                                                                    child:
                                                                        FittedBox(
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                      child: Text(
                                                                          "View",
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              FontStyles.whiteBodyText),
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                              ),
                                            );
                                          });
                                    }
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.black),
                                  );
                                });
                          })),
                  Spaces.y5,
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Customer Details",
                              style: FontStyles.boldBlackBodyText),
                          Spaces.y2,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Name",
                                  style: FontStyles.boldBlackBodyText,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  user.fullname,
                                  style: FontStyles.blackBodyText,
                                ),
                              ),
                            ],
                          ),
                          Spaces.y2,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Email",
                                  style: FontStyles.boldBlackBodyText,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  user.email,
                                  style: FontStyles.blackBodyText,
                                ),
                              ),
                            ],
                          ),
                          Spaces.y2,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Address",
                                  style: FontStyles.boldBlackBodyText,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  order.recepAddr,
                                  style: FontStyles.blackBodyText,
                                ),
                              ),
                            ],
                          ),
                          Spaces.y2,
                        ]),
                  ),
                  Spaces.y5,
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Totals", style: FontStyles.blackBodyText),
                          Spaces.y2,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Order id",
                                  style: FontStyles.boldBlackBodyText,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  order.uid,
                                  style: FontStyles.blackBodyText,
                                ),
                              ),
                            ],
                          ),
                          Spaces.y2,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Sub-Total",
                                  style: FontStyles.boldBlackBodyText,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '\QAR. ${order.subTotal}',
                                  style: FontStyles.blackBodyText,
                                ),
                              ),
                            ],
                          ),
                          Spaces.y2,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Delivery Charges",
                                  style: FontStyles.boldBlackBodyText,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'QAR. 200',
                                  style: FontStyles.blackBodyText,
                                ),
                              ),
                            ],
                          ),
                          Spaces.y2,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Total",
                                  style: FontStyles.boldBlackBodyText,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '\QAR. ${order.totalBill.toString()}',
                                  style: FontStyles.blackBodyText,
                                ),
                              ),
                            ],
                          ),
                          Spaces.y2,
                        ]),
                  ),
                  Spaces.y5,
                  Container(
                    color: Colors.black,
                    margin: EdgeInsets.only(bottom: 2.h),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 6.h,
                    child: Text(
                      order.orderStatus.toLowerCase() == "approved" ? "Shipped" : order.orderStatus.toUpperCase(),
                      style: FontStyles.whiteBodyText,
                    ),
                  ),
                ]),
              )),
        ),
      ),
    );
  }
}
