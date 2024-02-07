import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/models/ProductModel.dart';
import 'package:timeless/screens/Customer_screens/product_details/products_detail.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/Donations.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/product/create_product_form.dart';
import 'package:timeless/screens/bottom_bar/notifications_screen.dart';
import 'package:timeless/utils/space_values.dart';
import '../../../../Constants/color_constants.dart';
import '../../../../constants/font_styles.dart';
import '../../../../controllers/call_controllers.dart';

class ViewProductsScreen extends StatefulWidget {
  const ViewProductsScreen({super.key});

  @override
  State<ViewProductsScreen> createState() => _ViewProductsScreenState();
}

class _ViewProductsScreenState extends State<ViewProductsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Products",
          style: FontStyles.appBarStylePC,
        ),
        leading: InkWell(
            onTap: (){
              Get.to(Donations());
            },
            child: Padding(
              padding:  EdgeInsets.only(left: 3.0.w),
              child: Image.asset("assets/images/donate1.png", color: ColorConstants.primaryColor, ),
            )),
        centerTitle: true,
        leadingWidth: 10.w,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.0.w),
            child: InkWell(
                onTap: (){
                  Get.to(NotificationsScreen());
                },
                child: Icon(Icons.notifications, color: ColorConstants.primaryColor, size: 22.sp,)),
          )
        ],
      ),
      body: StreamBuilder(
          stream: firestore.collection("Products").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              List<ProductModel> products = [];
              for (var doc in documents) {
                products.add(
                    ProductModel.fromMap(doc.data() as Map<String, dynamic>));
              }
              return products.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: documents.length,
                      itemBuilder: (c, index) {
                        ProductModel product = products[index];
                        String productId = product.uid;

                        return GestureDetector(
                          onTap: () {
                            Get.to(ProductDetails(
                              selectedProd: products[index],
                            ));
                          },
                          child: ProductCard(
                            product: products[index],
                            onDeleteEvent: () {
                              productController.deleteItem(
                                  products, index, productId, context);
                            },
                            onEditEvent: () async {
                              await productController
                                  .initParams(products[index]);
                              Get.to(CreateProductForm(
                                index: 0,
                              ));
                            },
                          ),
                        );
                      })
                  : const Center(
                      child: Text("No products added..."),
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
    required this.product,
    required this.onDeleteEvent,
    required this.onEditEvent,
  });
  final ProductModel product;
  final VoidCallback onDeleteEvent;
  final VoidCallback onEditEvent;

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
        child: Row(
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
                        product.productimage[0],
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: onEditEvent,
                            child: const Icon(
                              Icons.edit,
                              color: ColorConstants.primaryColor,
                            )),
                        Spaces.x1,
                        GestureDetector(
                            onTap: onDeleteEvent,
                            child: const Icon(
                              Icons.delete,
                              color: ColorConstants.primaryColor,
                            ))
                      ],
                    ),
                    Spaces.y1,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.productname,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: FontStyles.boldBlackBodyText),
                                Text("Code: ${product.sku}",
                                    style: FontStyles.smallGreyBodyText),
                              ],
                            )),
                        // Spaces.x6,
                        Flexible(
                          child: Text("QAR. ${product.price.toString()}",
                              style: FontStyles.smallBlackBodyText),
                        ),
                      ],
                    ),
                    Spaces.y1,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Quantity",
                                  style: FontStyles.boldBlackBodyText),
                              Text("In-stock",
                                  style: FontStyles.smallGreyBodyText),
                            ],
                          ),
                        ),
                        // Spaces.x6,
                        Flexible(
                          child: Text("${product.quantity} units",
                              style: FontStyles.smallBlackBodyText),
                        ),
                      ],
                    ),
                    Spaces.y1,
                  ],
                ),
              ),
            ),
            Spaces.x1,
          ],
        ),
      ),
    );
  }
}
