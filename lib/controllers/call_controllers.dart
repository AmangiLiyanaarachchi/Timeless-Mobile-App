import 'package:get/get.dart';
import 'package:timeless/controllers/Login_controller.dart';
import 'package:timeless/controllers/bottombar_controller.dart';
import 'package:timeless/controllers/image_picker.dart';
import 'package:timeless/controllers/product_controller.dart';
import 'package:timeless/controllers/wishlist_controller.dart';
import 'order_controller.dart';
import 'chat_controller.dart';

final imagePickerController = Get.put(ImagePickerController());
final chatController = Get.put(ChatController());
final loginController = Get.put(LoginController());
final productController = Get.put(ProductController());
final orderController = Get.put(OrderController());
final bottombarController = Get.put(BottomBarController());
final wishlistController = Get.put(WishlistController());
