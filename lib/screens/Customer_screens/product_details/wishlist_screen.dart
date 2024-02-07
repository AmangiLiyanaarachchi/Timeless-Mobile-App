import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/models/WishlistModel.dart';
import 'package:timeless/screens/Customer_screens/BottomBarNew/bottom_bar.dart';
import 'package:timeless/screens/Customer_screens/product_details/products_detail.dart';
import '../../../Constants/color_constants.dart';
import '../../../Constants/firebase_consts.dart';
import '../../../Constants/font_styles.dart';
import '../../../models/ProductModel.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
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
          "Wishlist",
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: firestore
              .collection("Wishlist")
              .where("custId", isEqualTo: auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: const CircularProgressIndicator());
            } else {
              if (snapshot.data!.docs.isNotEmpty) {
                List<WishlistModel> wishlistItems = [];
                for (var doc in snapshot.data!.docs) {
                  wishlistItems.add(WishlistModel.fromMap(doc.data()));
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (c, index) {
                      return WishlistCard(wishlist: wishlistItems[index]);
                    });
              } else {
                return Center(
                  child: Text(
                    "Nothing to show...",
                    style: FontStyles.blackBodyText,
                  ),
                );
              }
            }
          }),
    );
  }
}

class WishlistCard extends StatefulWidget {
  const WishlistCard({
    super.key,
    required this.wishlist,
  });

  final WishlistModel wishlist;

  @override
  State<WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore
            .collection("Products")
            .doc(widget.wishlist.prodId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else {
            ProductModel product = ProductModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0.5.h),
              child: ListTile(
                onTap: () => Get.to(ProductDetails(selectedProd: product)),
                visualDensity: VisualDensity(vertical: 4.0),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.productimage[0],
                      width: 25.w,
                      height: 11.h,
                      fit: BoxFit.cover,
                    )),
                title: Text(product.productname.capitalizeFirst!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyles.blackBodyText),
                trailing: GestureDetector(
                  onTap: () async {
                    await wishlistController
                        .removeItemfromWishlist(widget.wishlist.prodId);
                    Get.offAll(BottomBarScreen1());
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }
        });
  }
}
