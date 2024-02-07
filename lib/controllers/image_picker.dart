import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/firebase_consts.dart';

class ImagePickerController extends GetxController {
  RxList<String> pickedImgPaths = <String>[].obs;
  var mediaPath = ''.obs;

  get pickedImgPath => null;

  // Pick an image for chat
  Future<String> pickSingleImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (image != null) {
      mediaPath.value = image.path;
      return image.path;
    }
    return "";
  }

  //multiple images only from gallery
  pickImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );
    if (images.isNotEmpty) {
      for (var image in images) {
        pickedImgPaths.add(image.path);
      }
    }
  }

  Future<String> uploadMediatoStorage(File image) async {
    final Reference storageRef =
        storage.ref().child("images/posts/${DateTime.now()}.png");
    UploadTask task = storageRef.putFile(image);
    TaskSnapshot taskSnapshot = await task;
    var downloadurl = await taskSnapshot.ref.getDownloadURL();
    return downloadurl;
  }
}
