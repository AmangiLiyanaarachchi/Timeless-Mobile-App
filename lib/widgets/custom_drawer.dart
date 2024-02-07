import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/color_constants.dart';
import 'package:timeless/constants/font_styles.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/screens/Customer_screens/Orders/order_history/order_screen.dart';
import 'package:timeless/screens/Customer_screens/Profile/Settings/settings.dart';
import 'package:timeless/screens/Customer_screens/auth/signin_customer.dart';
import 'package:timeless/screens/Customer_screens/product_details/wishlist_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Image.asset("assets/images/timelesslogo.png")),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag,
              size: 2.5.h,
            ),
            title: Text(
              'Orders',
              style: FontStyles.smallBlackBodyText,
            ),
            onTap: () {
              Get.to(OrderScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              size: 2.5.h,
            ),
            title: Text(
              'Wishlist',
              style: FontStyles.smallBlackBodyText,
            ),
            onTap: () {
              Get.to(WishlistScreen());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 2.5.h,
            ),
            title: Text(
              'Settings',
              style: FontStyles.smallBlackBodyText,
            ),
            onTap: () {
              Get.to(SettingsPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 2.5.h,
            ),
            title: Text(
              'Log Out',
              style: FontStyles.smallBlackBodyText,
            ),
            onTap: () async {
              loginController.logout();
              Get.offAll(CustomerSignIn());
            },
          ),
        ],
      ),
    );
  }
}
