import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/screens/Customer_screens/Donate/donate_thobe_dropoff.dart';
import '../main.dart';
import '../models/AdminModel.dart';
import '../models/CategoryModel.dart';
import '../models/DonationModel.dart';
import '../models/ProductModel.dart';
import '../screens/admin/admin_bottom_bar/bottom_bar_screen.dart';
import '../utils/notification_services.dart';
import '../utils/utility_const.dart';
import '../widgets/dialogs/delete_item_dialog.dart';
import '../widgets/dialogs/success_dialog.dart';
import 'call_controllers.dart';

class ProductController extends GetxController {
  NotificationServices notificationServices = NotificationServices();

  TextEditingController nameController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController pnameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController receiptController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String selectedUid = ''; // Corresponding UID
  String selectedCatName = ''; // Corresponding UID
  String selectedBrandId = ''; // Corresponding UID
  String selectedMode = "Drop off";
  List selectedColors = [];
  //for update-----------------
  List<String> sizes = [];
  List<String> shoeSizes = [];
  //---------------------------
  List selectedSizes = []; //for product detail page
  var selectedColor;

  //declare parameters for editing product
  var existingDownloadUrls = [],
      currentColors = [],
      currentSizes = [],
      currentShoeSizes = [],
      currentBrand = "",
      currentCategory = "",
      prodId = "";

  uploadData(BuildContext context) async {
    String name = nameController.text;
    String sku = skuController.text;
    int quantity = int.parse(quantityController.text);
    int price = int.parse(priceController.text);

    String uid = uuid.v4();
    List downloadUrls = [];
    downloadUrls.clear();
    try {
      await uploadImgstoStorage(downloadUrls);

      ProductModel newData = ProductModel(
        uid: uid,
        productname: name,
        sku: sku,
        quantity: quantity,
        price: price,
        catId: selectedUid,
        productimage: downloadUrls,
        availablecolors: selectedColors,
        size: sizes.isNotEmpty ? sizes : shoeSizes,
        brand: selectedBrandId,
        createdOn: DateTime.now(),
      );
      await firestore
          .collection("Products")
          .doc(uid)
          .set(newData.toMap())
          .then((value) => debugPrint("New product created"));

      resetParams();
      final successDialog = SuccessDialog(
        title: "Success!",
        body: "Product has been created successfully.",
        onPressEvent: () => Get.back(),
      );
      await showDialog(
        context: context,
        builder: (ctx) => successDialog,
      );
      hideLoading();

      //Get.offNamed('/viewProduct');
      Get.to(BottomBarScreenAdmin());
    } catch (e) {
      print("error occured ${e}");
    }
  }

  updateProduct(BuildContext context) async {
    List downloadUrls = [];
    try {
      /// all the conditions are checking if user has not updated
      /// any value so add default values
      await uploadImgstoStorage(downloadUrls);
      await areCategoriesUpdated();
      downloadUrls = areImgsUpdated(downloadUrls);
      areColorsUpdated();
      isSizeUpdated();
      await isBrandUpdated();

      ProductModel newData = ProductModel(
        uid: prodId,
        productname: nameController.text.trim(),
        sku: skuController.text.trim(),
        quantity: int.parse(quantityController.text),
        price: int.parse(priceController.text),
        catId: selectedUid,
        productimage: downloadUrls,
        availablecolors: selectedColors,
        size: sizes.isNotEmpty ? sizes : shoeSizes,
        brand: selectedBrandId,
        createdOn: DateTime.now(),
      );
      await firestore.collection("Products").doc(prodId).set(newData.toMap());

      resetParams();
      final successDialog = SuccessDialog(
        title: "Success!",
        body: "All the changes have been saved",
        onPressEvent: () => Get.back(),
      );
      await showDialog(
        context: context,
        builder: (ctx) => successDialog,
      );
      Get.to(BottomBarScreenAdmin());
    } catch (e) {
      print("error while updating $e");
    }
  }

  Future<void> uploadImgstoStorage(List<dynamic> downloadUrls) async {
    if (imagePickerController.pickedImgPaths.isNotEmpty) {
      for (int i = 0; i < imagePickerController.pickedImgPaths.length; i++) {
        UploadTask uploadTask = FirebaseStorage.instance
            .ref("Product pictures")
            .child(uuid.v1())
            .putFile(File(imagePickerController.pickedImgPaths[i]));
        TaskSnapshot snapshot = await uploadTask;
        String? imageUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(imageUrl);
      }
    }
  }

  Future<void> areCategoriesUpdated() async {
    if (selectedUid.isEmpty) {
      await firestore
          .collection("Categories")
          .where("title", isEqualTo: currentCategory)
          .get()
          .then((data) {
        selectedUid = data.docs[0].data()['uid'];
      });
      print("selec uid $selectedUid");
    }
  }

  List<dynamic> areImgsUpdated(List<dynamic> downloadUrls) {
    if (downloadUrls.isEmpty) {
      downloadUrls = existingDownloadUrls;
      print("selec img ${downloadUrls.length}");
    }
    return downloadUrls;
  }

  void areColorsUpdated() {
    if (selectedColors.isEmpty) {
      for (var color in currentColors) {
        firestore
            .collection("Colors")
            .where("title", isEqualTo: color)
            .get()
            .then((data) {
          selectedColors.add(data.docs[0].data()['uid']);
        });
        print("selec colors ${selectedColors.length}");
      }
    }
  }

  void isSizeUpdated() {
    if (sizes.isEmpty && currentSizes.isNotEmpty) {
      sizes = currentSizes.cast();
    } else if (shoeSizes.isEmpty && currentShoeSizes.isNotEmpty) {
      shoeSizes = currentShoeSizes.cast();
    }
  }

  Future<void> isBrandUpdated() async {
    if (selectedBrandId.isEmpty) {
      await firestore
          .collection("Brands")
          .where("title", isEqualTo: currentBrand)
          .get()
          .then((data) {
        selectedBrandId = data.docs[0].data()['uid'];
      });
      print("selec uid $selectedBrandId");
    }
  }

  removeOldImg(String imgurl) {
    Reference imgRef = FirebaseStorage.instance.refFromURL(imgurl);
    imgRef.delete();
  }

  Future<void> deleteProduct(ProductModel selProduct) async {
    try {
      for (var img in selProduct.productimage) {
        await removeOldImg(img);
      }
      await firestore.collection('Products').doc(selProduct.uid).delete();
      // Product and its data are deleted successfully
      print('Product deleted successfully');
    } catch (e) {
      // Handle any errors that occur during deletion
      print('Error deleting product: $e');
    }
  }

  Future<void> deleteItem(
      List<ProductModel> productList, index, productId, context) async {
    RxBool isRemoved = false.obs;
    final deletionDialog = DeletionDialog(
        title: "Attention!",
        body:
            "Deleted product will be removed permanently. Please confirm the action",
        onCancelEvent: () => Get.back(),
        onConfirmEvent: () async {
          deleteProduct(productList[index]);
          await productList.removeAt(index);
          isRemoved(false);
          Get.back();
        });
    await showDialog(
      context: context,
      builder: (ctx) => deletionDialog,
    );
    if (isRemoved.value) {
      showSnack("Action complete!", "Product has been deleted successfully");
    }
  }

  initParams(ProductModel product) async {
    nameController.text = product.productname.trim();
    skuController.text = product.sku.trim();
    priceController.text = product.price.toString();
    quantityController.text = product.quantity.toString();
    existingDownloadUrls = product.productimage;
    prodId = product.uid;
    for (var color in product.availablecolors) {
      firestore.collection("Colors").doc(color).get().then((doc) {
        currentColors.add(doc.data()!['title']);
      });
    }
    await firestore.collection("Brands").doc(product.brand).get().then((doc) {
      currentBrand = doc.data()!['title'];
    });
    await firestore
        .collection("Categories")
        .doc(product.catId)
        .get()
        .then((doc) {
      currentCategory = doc.data()!['title'];
    });
    if (currentCategory == "Footwear") {
      currentShoeSizes = product.size;
    } else {
      currentSizes = product.size;
    }
  }

  resetParams() {
    // Reset TextEditingController objects
    nameController.clear();
    skuController.clear();
    quantityController.clear();
    priceController.clear();

    // Reset string variables
    selectedUid = '';
    selectedBrandId = '';
    currentBrand = '';
    currentCategory = '';
    selectedCatName = '';

    // Clear lists
    selectedColors.clear();
    imagePickerController.pickedImgPaths.clear();
    sizes.clear();
    shoeSizes.clear();
    currentSizes.clear();
    currentShoeSizes.clear();
    currentColors.clear();
    existingDownloadUrls.clear();
  }

  //categories
  addCategory(CategoryModel categoryModel) async {
    await firestore
        .collection("Categories")
        .doc(categoryModel.uid)
        .set(categoryModel.toMap());
  }

  updateCategory(String uid, bool isEnabled) async {
    firestore.collection("Categories").doc(uid).update({"enabled": isEnabled});
  }

  Future<void> donateProduct(BuildContext context) async {
    uploadDonation(context);
  }

  Future<String> uploadDonation(BuildContext context) async {
    setLoading();
    String uid = uuid.v4();
    List downloadUrls = [];
    try {
      await uploadDonatedProdsImgs(downloadUrls);

      DonationModel newData = DonationModel(
          uid: uid,
          donorId: auth.currentUser!.uid,
          prodImg: downloadUrls,
          prodName: pnameController.text,
          prodBrand: brandController.text,
          category: categoryController.text,
          prodDisc: descriptionController.text,
          receipt: receiptController.text,
          color: colorController.text,
          usedDuration: timeController.text,
          size: sizeController.text,
          deliveryMode: selectedMode,
          createdOn: DateTime.now());
      await firestore
          .collection("Donations")
          .doc(uid)
          .set(newData.toMap())
          .then((value) => debugPrint("New product created"));

      resetDonationParams();
      final successDialog = SuccessDialog(
        title: "Success!",
        body: "Product has been donated successfully.",
        onPressEvent: () => Get.back(),
      );
      await showDialog(
        context: context,
        builder: (ctx) => successDialog,
      );
      DocumentSnapshot snapshot =
          await firestore.collection("Admins").doc(adminId).get();
      AdminModel admin =
          AdminModel.fromMap(snapshot.data() as Map<String, dynamic>);
      //notify admin
      notificationServices.sendNotification(
        "Timeless",
        admin.token,
        "Someone sent a donation!",
        admin.uid,
        "",
      );

      //notify customer
      notificationServices.sendNotification(
        "Timeless",
        loginController.userModel.value.token,
        "Thank You For Donating, We Will be in Touch Soon",
        loginController.userModel.value.uid,
        "",
      );
      hideLoading();
      Get.to((DonateThobeDropoff(
        pId: uid,
      )));
      //Get.offNamed('/viewProduct');
      return newData.uid;
    } catch (e) {
      print("error occured ${e}");
    }
    return "";
  }

  resetDonationParams() {
    // Reset TextEditingController objects
    productController.pnameController.clear();
    productController.brandController.clear();
    productController.sizeController.clear();
    productController.colorController.clear();
    imagePickerController.pickedImgPaths.clear();
    productController.descriptionController.clear();
    productController.categoryController.clear();
    productController.timeController.clear();
    productController.receiptController.clear();
    existingDownloadUrls.clear();
  }

  Future<void> uploadDonatedProdsImgs(List<dynamic> downloadUrls) async {
    if (imagePickerController.pickedImgPaths.isNotEmpty) {
      for (int i = 0; i < imagePickerController.pickedImgPaths.length; i++) {
        UploadTask uploadTask = FirebaseStorage.instance
            .ref("Donated thobes pictures")
            .child(uuid.v1())
            .putFile(File(imagePickerController.pickedImgPaths[i]));
        TaskSnapshot snapshot = await uploadTask;
        String? imageUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(imageUrl);
      }
    }
  }
}
