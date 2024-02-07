import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/models/CartModel.dart';
import 'package:timeless/models/ProductModel.dart';
import 'package:timeless/screens/Customer_screens/Orders/place_order.dart';
import 'package:timeless/screens/Customer_screens/product_details/products_detail.dart';
import 'package:timeless/widgets/dialogs/delete_item_dialog.dart';
import 'package:timeless/widgets/dialogs/success_dialog.dart';
import '../../../Constants/color_constants.dart';
import '../../../constants/font_styles.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_gradient_button.dart';
import '../../bottom_bar/notifications_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          "Cart",
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () {
                Get.to(NotificationsScreen());
              },
              child: Icon(
                Icons.notifications,
                color: ColorConstants.primaryColor,
                size: 30,
              ),
            ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: StreamBuilder(
            stream: firestore
                .collection("Cart")
                .where("custId", isEqualTo: auth.currentUser!.uid)
                .where("status", isEqualTo: "active")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: const CircularProgressIndicator());
              } else {
                if (snapshot.data!.docs.isNotEmpty) {
                  var subtot = 0;
                  List<CartModel> cartItems = [];
                  for (var doc in snapshot.data!.docs) {
                    cartItems.add(CartModel.fromMap(doc.data()));
                    subtot =
                        subtot + int.parse(doc.data()['subTot'].toString());
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (c, index) {
                              return CardCard(cart: cartItems[index]);
                            }),
                        Spaces.y5,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Summary",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spaces.y0,
                                Spaces.y1,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sub-total",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    Text("QAR. $subtot",
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
                                    Text("Delivery Fee",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    Text("QAR. 200",
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
                                    Text("Total Payment",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    Text("QAR. ${subtot + 200}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ))
                                  ],
                                ),
                                Spaces.y2,
                                Divider(
                                  color: Colors.grey,
                                ),
                                Spaces.y0,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Total",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Text("QAR. ${subtot + 200}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: ColorConstants.primaryColor,
                                            fontWeight: FontWeight.w400,
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Spaces.y2,
                        CustomGradientButton(
                          title: "Proceed",
                          onPress: () async {
                            Get.to(PlaceOrder(
                              cartItems: cartItems,
                              total: subtot + 200,
                            ));
                          },
                          titleColor: Colors.white,
                          width: 85.w,
                          height: 7.h,
                          borderRadius: 12.0,
                        ),
                        Spaces.y3,
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: SizedBox(
                      height: 25.h,
                      child: Lottie.asset("assets/animations/empty_cart.json"),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}

class CardCard extends StatefulWidget {
  const CardCard({
    super.key,
    required this.cart,
  });

  final CartModel cart;

  @override
  State<CardCard> createState() => _CardCardState();
}

class _CardCardState extends State<CardCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore
            .collection("Products")
            .doc(widget.cart.prodId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else {
            ProductModel product = ProductModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spaces.y0,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Get.to(ProductDetails(
                            selectedProd: product,
                          ));
                        },
                        child: Row(
                          children: [
                            Flexible(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    product.productimage[0],
                                    width: 25.w,
                                    height: 11.h,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Spaces.x4,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.productname.capitalizeFirst!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: FontStyles.blackBodyText),
                                Spaces.y0,
                                Text("QAR. ${widget.cart.subTot}",
                                    style: FontStyles.smallBlackBodyTextBold),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Size: ${widget.cart.size} ",
                                        style: FontStyles.smallBlackBodyText),
                                    Text("| Color: ",
                                        style: FontStyles.smallBlackBodyText),
                                    StreamBuilder(
                                        stream: firestore
                                            .collection("Colors")
                                            .where("title",
                                                isEqualTo: widget.cart.color)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const SizedBox.shrink();
                                          } else {
                                            return Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Color(
                                                  int.parse(
                                                      '0xff${snapshot.data!.docs[0].data()['hexcode']}'),
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              var deleteItem = DeletionDialog(
                                  title: "Remove Item",
                                  body:
                                      "Are you sure to remove ${product.productname} from cart?",
                                  onCancelEvent: () => Get.back(),
                                  onConfirmEvent: () async {
                                    await orderController
                                        .deleteFromCart(widget.cart.cartId);
                                    Get.back();
                                  });
                              showDialog(
                                context: context,
                                builder: (c) => deleteItem,
                              );
                            },
                            child: Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Spaces.y1,
                        Text("Quantity", style: FontStyles.blackBodyText),
                        Spaces.y0,
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StreamBuilder(
                        stream: firestore
                            .collection("Wishlist")
                            .where("prodId", isEqualTo: product.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox.shrink();
                          } else {
                            if (snapshot.data!.docs.isEmpty) {
                              return GestureDetector(
                                onTap: () async {
                                  await wishlistController
                                      .addItemtoWishlist(product.uid);
                                  await orderController
                                      .deleteFromCart(widget.cart.cartId);
                                  var successDialog = SuccessDialog(
                                      title: "Success!",
                                      body:
                                          "${product.productname} has been moved to wishlist from cart.",
                                      onPressEvent: () => Get.back());

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return successDialog;
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.amber,
                                    ),
                                    Spaces.x3,
                                    Text("Move to wishlist",
                                        style: FontStyles.greyBodyText)
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4.h,
                          width: 8.w,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.cart.prodQuant += 1;
                                  orderController.updateQuantity(
                                      widget.cart.prodQuant,
                                      product.price,
                                      widget.cart.cartId);
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  Icons.add,
                                  size: 13,
                                ),
                              )),
                        ),
                        Spaces.x2,
                        Text(
                          widget.cart.prodQuant.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Spaces.x2,
                        GestureDetector(
                            onTap: () {
                              if (widget.cart.prodQuant > 1) {
                                setState(() {
                                  widget.cart.prodQuant -= 1;
                                  orderController.updateQuantity(
                                      widget.cart.prodQuant,
                                      product.price,
                                      widget.cart.cartId);
                                });
                              } else {
                                var deleteItem = DeletionDialog(
                                    title: "Remove Item",
                                    body:
                                        "Are you sure to remove ${product.productname} from cart?",
                                    onCancelEvent: () => Get.back(),
                                    onConfirmEvent: () async {
                                      await orderController
                                          .deleteFromCart(widget.cart.cartId);
                                      Get.back();
                                    });
                                showDialog(
                                  context: context,
                                  builder: (c) => deleteItem,
                                );
                              }
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.remove,
                                size: 13,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade200,
                ),
              ],
            );
          }
        });
  }
}
