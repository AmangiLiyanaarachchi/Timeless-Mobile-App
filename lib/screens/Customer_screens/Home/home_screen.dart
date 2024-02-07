import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/models/CategoryModel.dart';
import 'package:timeless/models/ProductModel.dart';
import 'package:timeless/screens/Customer_screens/product_details/wishlist_screen.dart';
import 'package:timeless/screens/bottom_bar/notifications_screen.dart';
import '../../../Constants/color_constants.dart';
import '../../../constants/font_styles.dart';
import '../../../controllers/call_controllers.dart';
import '../../../utils/space_values.dart';
import '../../../utils/utility_const.dart';
import '../../../widgets/custom_drawer.dart';
import '../product_details/products.dart';
import '../product_details/products_detail.dart';

class HomeCustomer extends StatefulWidget {
  const HomeCustomer({super.key});

  @override
  State<HomeCustomer> createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  final DateTime threeDaysAgo =
      DateTime.now().subtract(const Duration(days: 3));

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
          "Home",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(alignment: Alignment.center, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset("assets/images/image1.png")),
              Center(
                child: StreamBuilder(
                    stream: firestore
                        .collection("Categories")
                        .where("enabled", isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      } else {
                        List<CategoryModel> cats = [];
                        for (var cat in snapshot.data!.docs) {
                          cats.add(CategoryModel.fromMap(cat.data()));
                        }
                        return StreamBuilder(
                            stream: firestore
                                .collection("Products")
                                .where("createdOn",
                                    isGreaterThanOrEqualTo: threeDaysAgo)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductModel> newProd = [];
                                for (var doc in snapshot.data!.docs) {
                                  for (var cat in cats) {
                                    if (doc.data()['catId'] == cat.uid) {
                                      newProd.add(
                                          ProductModel.fromMap(doc.data()));
                                      break;
                                    }
                                  }
                                }

                                return GestureDetector(
                                  onTap: () {
                                    Get.to(ProductsScreen(
                                        appbarTitle: "New Arrivals",
                                        products: newProd));
                                  },
                                  child: Text(
                                    "New Articles",
                                    style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            });
                      }
                    }),
              ),
            ]),
            Spaces.y2,
            StreamBuilder(
                stream: firestore
                    .collection("Categories")
                    .where("enabled", isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  } else {
                    List<CategoryModel> categories = [];
                    for (var category in snapshot.data!.docs) {
                      categories.add(CategoryModel.fromMap(category.data()));
                    }
                    return CarouselSlider.builder(
                      itemCount: categories.length,
                      itemBuilder: (c, index, realIndex) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 1.w,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]), // Set item background color
                          child: StreamBuilder(
                              stream: firestore
                                  .collection("Products")
                                  .where("catId",
                                      isEqualTo: categories[index].uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<ProductModel> categoryProducts = [];
                                  for (var doc in snapshot.data!.docs) {
                                    categoryProducts
                                        .add(ProductModel.fromMap(doc.data()));
                                  }
                                  return GestureDetector(
                                    onTap: () => Get.to(ProductsScreen(
                                        appbarTitle: categories[index]
                                            .title
                                            .capitalizeFirst!,
                                        products: categoryProducts)),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Spaces.y1,
                                          Flexible(
                                            child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    categories[index].imgUrl)),
                                          ),
                                          Spaces.y1,
                                          Flexible(
                                            child: Text(
                                              categories[index]
                                                  .title
                                                  .capitalizeFirst!,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                        );
                      },
                      options: CarouselOptions(
                          padEnds: false,
                          aspectRatio: 12 / 3,
                          enlargeCenterPage: false,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          initialPage: 0,
                          viewportFraction: 0.22),
                    );
                  }
                }),
            StreamBuilder(
              stream: firestore
                  .collection("Wishlist")
                  .where("custId", isEqualTo: auth.currentUser!.uid)
                  .snapshots(),
              builder: (index, snapshot) {
                if (snapshot.hasData) {
                  List productIds = [];
                  for (var doc in snapshot.data!.docs) {
                    productIds.add(doc.data()['prodId']);
                  }
                  if (productIds.isNotEmpty) {
                    return StreamBuilder(
                        stream: firestore
                            .collection("Products")
                            .where("uid", whereIn: productIds)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox.shrink();
                          } else {
                            if (snapshot.data!.docs.isNotEmpty) {
                              List<ProductModel> products = [];
                              for (var prod in snapshot.data!.docs) {
                                products.add(ProductModel.fromMap(prod.data()));
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Spaces.y0,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Favorite Items",
                                        style: FontStyles.boldBlackBodyText,
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.to(WishlistScreen()),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'View all ',
                                            style: FontStyles.smallGreyBodyText,
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                Icons.arrow_forward,
                                                size: 1.7.h,
                                                color: Colors.grey,
                                              )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  CarouselSlider.builder(
                                    itemCount: products.length <= 3
                                        ? products.length
                                        : 3,
                                    itemBuilder: (c, index, realIndex) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(ProductDetails(
                                            selectedProd: products[index],
                                          ));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 1.w),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Spaces.y2,
                                              Flexible(
                                                flex: 4,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                  child: Image.network(
                                                    products[index]
                                                        .productimage[0],
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                              ),
                                              Spaces.y1,
                                              Flexible(
                                                flex: 1,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.w),
                                                  child: Text(
                                                      products[index]
                                                          .productname
                                                          .capitalizeFirst!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FontStyles
                                                          .blackBodyText),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.5.w),
                                                      child: Text(
                                                          "QAR. ${products[index].price}",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: FontStyles
                                                              .smallBlackBodyText),
                                                    ),
                                                    StreamBuilder(
                                                        stream: firestore
                                                            .collection(
                                                                "Wishlist")
                                                            .where("custId",
                                                                isEqualTo: auth
                                                                    .currentUser!
                                                                    .uid)
                                                            .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return InkWell(
                                                                splashColor: Colors
                                                                    .red
                                                                    .withOpacity(
                                                                        0.1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.0),
                                                                onTap:
                                                                    () async {
                                                                  try {
                                                                    setLoading();

                                                                    await wishlistController
                                                                        .removeItemfromWishlist(
                                                                            products[index].uid);
                                                                    hideLoading();
                                                                  } catch (e) {
                                                                    hideLoading();
                                                                  }
                                                                },
                                                                child: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 2.h));
                                                          } else {
                                                            return const SizedBox
                                                                .shrink();
                                                          }
                                                        })
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                        padEnds: false,
                                        enlargeCenterPage: false,
                                        autoPlay: false,
                                        enableInfiniteScroll: false,
                                        initialPage: 0,
                                        viewportFraction: products.length == 1
                                            ? 1
                                            : products.length == 2
                                                ? 0.5
                                                : 0.4),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }
                        });
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                return const SizedBox.shrink();
              },
            ),
            StreamBuilder(
                stream: firestore
                    .collection("Categories")
                    .where("enabled", isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  } else {
                    List<CategoryModel> cats = [];
                    for (var cat in snapshot.data!.docs) {
                      cats.add(CategoryModel.fromMap(cat.data()));
                    }
                    return StreamBuilder(
                        stream: firestore.collection("Products").snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox.shrink();
                          } else {
                            if (snapshot.data!.docs.isNotEmpty) {
                              List<ProductModel> products = [];
                              for (var doc in snapshot.data!.docs) {
                                for (var cat in cats) {
                                  if (doc.data()['catId'] == cat.uid) {
                                    products
                                        .add(ProductModel.fromMap(doc.data()));
                                    break;
                                  }
                                }
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Spaces.y0,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "All Products",
                                        style: FontStyles.boldBlackBodyText,
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.to(ProductsScreen(
                                          products: products,
                                          appbarTitle: 'All Products',
                                        )),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'View all ',
                                            style: FontStyles.smallGreyBodyText,
                                            children: [
                                              WidgetSpan(
                                                  child: Icon(
                                                Icons.arrow_forward,
                                                size: 1.7.h,
                                                color: Colors.grey,
                                              )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Spaces.y1_0,
                                  GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5.0,
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (c, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            Get.to(ProductDetails(
                                              selectedProd: products[index],
                                            ));
                                          },
                                          child: ProductCard(
                                              product: products[index]));
                                    },
                                    itemCount: products.length <= 10
                                        ? products.length
                                        : 10,
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          }
                        });
                  }
                }),
            Spaces.y1,
          ]),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(product.productimage[0]))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.black26,
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Text(product.productname.capitalizeFirst!,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyles.boldWhiteBodyText),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.black26,
                child: Text("QAR. ${product.price}",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyles.smallWhiteBodyTextBold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
