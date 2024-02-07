import 'dart:io' as io;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/controllers/userController.dart';
import 'package:timeless/screens/Customer_screens/auth/verify_email.dart';
import '../../../Constants/color_constants.dart';
import '../../../models/UIHelper.dart';
import '../../../models/UserModel.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/multiline_text_field.dart';

class CustomerCompleteProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const CustomerCompleteProfile(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<CustomerCompleteProfile> createState() =>
      _CustomerCompleteProfileState();
}

class _CustomerCompleteProfileState extends State<CustomerCompleteProfile> {
  List<bool> isSelectedList = List.generate(20, (index) => false);
  final userController = Get.put(UserController());

  void toggleSelection(int index) {
    setState(() {
      isSelectedList[index] = !isSelectedList[index];
    });
  }

  bool loading = false;

  // List<bool> isSelectedList = List.generate(20, (index) => false);
  List<String> storeCategories = [
    "Men's Clothing",
    "Women's Clothing",
    "Sportswear",
    "Formal Wear",
    "Casual Wear",
    "Jeans",
    "Dresses",
    "T-shirts",
    // Add more categories as needed
  ];

  io.File? imageFile;
  TextEditingController fullNameController = TextEditingController();

  Future<void> selectImage(ImageSource source) async {
    // Code to pick image from gallery
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  // void selectImage(ImageSource source) async {
  //   final imagePicker = ImagePicker();
  //   XFile? pickedFile = await ImagePicker.pickImage(source: source);
  //
  //   if(pickedFile != null) {
  //
  //   }
  // }

  void checkValues() async {
    String fullname = fullNameController.text.trim();

    if (fullname == "" || imageFile == null) {
      print("Please fill all the fields");
      UIHelper.showAlertDialog(context, "Incomplete Data",
          "Please fill all the fields and upload a profile picture");
    } else {
      // log("Uploading data..");
      await uploadData();
    }
  }

  uploadData() async {
    UIHelper.showLoadingDialog(context, "Uploading image..");

    String imageUrl = await uploadImagetostorage();

    String? fullname = fullNameController.text.trim();
    widget.userModel.fullname = fullname;
    widget.userModel.profilepic = imageUrl;
    //widget.userModel.cat = cat;
    widget.userModel.cat = userController.catId;

    await FirebaseFirestore.instance
        .collection("Customers")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) {
      // UIHelper.(context, "Uploading image..");

      // log("Data uploaded!");
      //  Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return VerifyEmail();
        }),
      );
    });
  }

  Future<String> uploadImagetostorage() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilepicturescustomer")
        .child(widget.userModel.uid.toString())
        .putFile(imageFile!);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: Icon(Icons.photo_album),
                  title: Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take a photo"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

        //backgroundColor: Colors.grey[500],
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            Color(0xff5C1616),
            Color(0xff703333),
            Color(0xff937070),
            Color(0xff9F8787),
          ],
        ),
      ),
      child: SizedBox(
          height: height * 1,
          width: width * 1,
          child: Stack(children: [
            SingleChildScrollView(
                child: Center(
                    child: Column(children: [
              Spaces.y6,
              Text(
                "Complete your profile",
                style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: 25,
                    fontFamily: 'sans-serif',
                    fontWeight: FontWeight.w800),
              ),
              Spaces.y1,
              Text(
                "Enter your details to complete profile",
                style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'sans-serif'),
              ),
              Spaces.y4,
              CircleAvatar(
                backgroundColor: ColorConstants.primaryColor,
                radius: 60,
                child: InkWell(
                  onTap: () {
                    showPhotoOptions();
                  },
                  child: CircleAvatar(
                    radius: 56,
                    backgroundColor: Colors.white,
                    backgroundImage: (imageFile != null)
                        ? FileImage(imageFile! as io.File)
                        : null,
                    child: (imageFile == null)
                        ? Icon(Icons.add,
                            size: 50, color: ColorConstants.primaryColor)
                        : null,
                  ),
                ),
              ),
              Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.words,

                        onTextChange: (value) {},
                        hint: "Full Name",
                        backgroundColor: Colors.white,
                        //backgroundColor: Colors.white,
                        controller: fullNameController,
                      ),
                      CustomMultilineTextField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                        capitalization: TextCapitalization.sentences,

                        onTextChange: (value) {},
                        backgroundColor: Colors.white,
                        hint: "Description",
                        //backgroundColor: Colors.white,
                        //controller: TextEditingController(),
                      ),
                    ],
                  ),
                ),
              ),
              Spaces.y2,
              SingleChildScrollView(
                child: Container(
                  width: width * 0.85,
                  height: 12.h,
                  child: StreamBuilder(
                      stream:
                          firestore.collection("clothing types").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1 / 0.5,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 4),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (userController.catId.contains(snapshot
                                        .data!.docs[index]
                                        .data()['uid'])) {
                                      userController.catId.remove(snapshot
                                          .data!.docs[index]
                                          .data()['uid']);
                                    } else {
                                      userController.catId.add(snapshot
                                          .data!.docs[index]
                                          .data()['uid']);
                                    }
                                    debugPrint(
                                        "${userController.catId.length}");
                                    toggleSelection(index);
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: userController.catId.contains(
                                                snapshot.data!.docs[index]
                                                    .data()['uid'])
                                            ? ColorConstants.whiteColor
                                            : ColorConstants.grayLevel11),
                                    child: Center(
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            .data()['category'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: userController.catId
                                                    .contains(snapshot
                                                        .data!.docs[index]
                                                        .data()['uid'])
                                                ? ColorConstants.primaryColor
                                                : Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                        return CircularProgressIndicator();
                      }),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomElevatedButton(
                onPress: () {
                  checkValues();

                  //Get.toNamed('/successPage');

                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SuccessPage()));
                },
                height: 6.5.h,
                title: "Submit",
                //   child: loading ? CircularProgressIndicator() : Text("Submit"),
                titleColor: ColorConstants.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                bgColor: Colors.white,
                borderRadius: 7,
              )
            ])))
          ])),
    ));
  }
}
