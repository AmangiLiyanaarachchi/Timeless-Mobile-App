import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/Constants/color_constants.dart';
import 'package:timeless/controllers/call_controllers.dart';
import 'package:timeless/screens/Customer_screens/Donate/list_product.dart';
import 'package:timeless/screens/Customer_screens/Home/home_screen.dart';
import 'package:timeless/screens/Customer_screens/Profile/myProfile.dart';
import 'package:timeless/utils/notification_services.dart';
import '../../one-to-one_chat/chatroom.dart';
import '../product_details/cart_screen.dart';

class BottomBarScreen1 extends StatefulWidget {
  @override
  _BottomBarScreen1State createState() => _BottomBarScreen1State();
}

class _BottomBarScreen1State extends State<BottomBarScreen1> {
  List<Map<String, Widget>>? _pages;
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    notificationServices.requestNotificationPermissions();
    notificationServices.firebaseInit(context);
    notificationServices.setUpInteractMessage(context);

    _pages = [
      {
        'page': HomeCustomer(),
      },
      {
        'page': CustChatroomScreen(),
      },
      {
        'page': ListProduct(),
      },
      {
        'page': CartScreen(),
      },
      {
        'page': MyProfile(),
      },
    ];

    super.initState();
  }

  void _selectPage(int index) {
    bottombarController.selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _pages?[bottombarController.selectedIndex.value]['page'],
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _selectPage,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: ColorConstants.primaryColor,
            currentIndex: bottombarController.selectedIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                backgroundColor: ColorConstants.primaryColor,
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                ),
                backgroundColor: ColorConstants.primaryColor,
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/donate1.png",
                  color: Colors.white,
                  height: 3.5.h,
                  width: 9.w,
                ),
                label: 'List',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_basket,
                ),
                backgroundColor: ColorConstants.primaryColor,
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                backgroundColor: ColorConstants.primaryColor,
                label: 'Profile',
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: InkWell(
        //     onTap: (){
        //       Get.to(ListProduct());
        //     },
        //     child: CircleAvatar(
        //         radius: 4.2.h,
        //         backgroundColor: Colors.white,
        //         child: CircleAvatar(
        //           radius: 3.6.h,
        //           backgroundColor: ColorConstants.primaryColor,
        //           child: Image.asset("assets/images/donate.png", color: Colors.white, height: 8.5.h, width: 8.5.w,),
        //         )),
        //   ),
        // ),
      ),
    );
  }
}
