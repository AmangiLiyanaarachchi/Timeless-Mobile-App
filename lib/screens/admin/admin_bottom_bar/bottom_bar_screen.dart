import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/screens/admin/Profile_admin/new_admin_profile.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/product/create_product_form.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/product/view_products_screen.dart';
import '../../../Constants/color_constants.dart';
import '../../../utils/notification_services.dart';
import 'one-to-one_chat/chat_body.dart';
import 'store_revenue/Store_revenue.dart';

class BottomBarScreenAdmin extends StatefulWidget {
  const BottomBarScreenAdmin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomBarScreenAdminState createState() => _BottomBarScreenAdminState();
}

class _BottomBarScreenAdminState extends State<BottomBarScreenAdmin> {
  int _selectedIndex = 0;

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermissions();
    notificationServices.firebaseInit(context);
    notificationServices.setUpInteractMessage(context);
  }

  final List<Widget> _pages = [
    const ViewProductsScreen(),
    const CreateProductForm(),
    StoreRevenue(),
    //Donations(),
    const ChatBodyScreen(),
    AdminProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: BottomNavigationBar(
              backgroundColor: ColorConstants.primaryColor,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              showUnselectedLabels: true,
              unselectedLabelStyle: const TextStyle(color: Colors.white),
              selectedLabelStyle:
                  const TextStyle(color: ColorConstants.whiteColor),
              unselectedItemColor: Colors.white,
              selectedItemColor: ColorConstants.whiteColor,
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.add), label: "Upload"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.store), label: "Store"),
                //BottomNavigationBarItem(icon: Icon(CupertinoIcons.gift), label: "Donations"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble), label: "Chat"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ]),
        ),
      ),
    );
  }
}
