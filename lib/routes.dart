import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/product/create_product_form.dart';
import 'package:timeless/screens/splash_screen.dart';

import 'screens/admin/admin_bottom_bar/bottom_bar_screen.dart';
import 'screens/admin/admin_bottom_bar/product/view_products_screen.dart';
import 'screens/one-to-one_chat/chatroom.dart';

class AppRoutes {
  static const String home = '/'; //default route
  static const String bba = '/bottombarAdmin';
  static const String createProdForm = '/createProd';
  static const String viewProd = '/viewProduct';
  static const String inbox = '/inbox';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const SplashScreen()),
    GetPage(
        name: createProdForm,
        page: () => const CreateProductForm(
              index: 1,
            )),
    GetPage(name: viewProd, page: () => const ViewProductsScreen()),
    GetPage(name: bba, page: () => const BottomBarScreenAdmin()),
    GetPage(name: inbox, page: () => CustChatroomScreen()),
  ];
}
