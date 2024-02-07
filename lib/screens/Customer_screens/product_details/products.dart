import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/font_styles.dart';
import 'package:timeless/models/ProductModel.dart';
import 'package:timeless/screens/Customer_screens/product_details/products_detail.dart';
import 'package:timeless/utils/space_values.dart';
import '../../../constants/color_constants.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {super.key, required this.products, required this.appbarTitle});
  final List<ProductModel> products;
  final String appbarTitle;
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var searchController = TextEditingController();
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
          widget.appbarTitle,
          style: FontStyles.appBarStylePC,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 90.w,
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              onChanged: (value) {
                setState(() {
                  searchController.text = value;
                });
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 2.5.h,
                    color: Colors.grey,
                  ),
                  hintText: 'Search',
                  hintStyle: FontStyles.greyBodyText,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          Spaces.y1,
          Flexible(
            child: widget.products.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.products.length,
                    itemBuilder: (c, index) {
                      if (searchController.text.isEmpty) {
                        return GestureDetector(
                          onTap: () => Get.to(ProductDetails(
                              selectedProd: widget.products[index])),
                          child: ProductCard(product: widget.products[index]),
                        );
                      } else {
                        if (widget.products[index].productname
                            .toLowerCase()
                            .isCaseInsensitiveContainsAny(
                                searchController.text.trim().toLowerCase())) {
                          return ProductCard(product: widget.products[index]);
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    },
                  )
                : const Center(
                    child: Text("No products..."),
                  ),
          ),
        ],
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
      elevation: 0.5,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.productimage[0],
                    width: double.infinity,
                    height: 20.h,
                    fit: BoxFit.cover,
                  )),
            ),
            Spaces.y1,
            Row(
              children: [
                Text(
                  "Title: ",
                  style: FontStyles.boldBlackBodyText,
                ),
                Spaces.x1,
                Text(
                  product.productname,
                  style: FontStyles.blackBodyText,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Sku: ",
                      style: FontStyles.smallBlackBodyTextBold,
                    ),
                    Spaces.x1,
                    Text(
                      product.sku,
                      style: FontStyles.smallBlackBodyText,
                    ),
                  ],
                ),
                Text(
                  "QAR. ${product.price}",
                  style: FontStyles.smallGreyBodyText,
                ),
              ],
            ),
            Spaces.y1,
          ],
        ),
      ),
    );
  }
}
