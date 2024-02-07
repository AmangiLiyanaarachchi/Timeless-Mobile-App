import 'dart:io' as io;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/screens/profile/success_screen.dart';

import '../../../widgets/multiline_text_field.dart';
import '../../Constants/color_constants.dart';
import '../../models/AdminModel.dart';
import '../../models/UIHelper.dart';

import '../../utils/space_values.dart';
import '../../widgets/custom_elevated_button.dart';

class CompleteProfile extends StatefulWidget {
  final AdminModel adminModel;
  final User firebaseUser;

  const CompleteProfile(
      {super.key, required this.adminModel, required this.firebaseUser});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  List<bool> isSelectedList = List.generate(20, (index) => false);

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
    widget.adminModel.fullname = fullname;
    widget.adminModel.profilepic = imageUrl;

    await FirebaseFirestore.instance
        .collection("Admins")
        .doc(widget.adminModel.uid)
        .set(widget.adminModel.toMap())
        .then((value) {
      // UIHelper.(context, "Uploading image..");

      // log("Data uploaded!");
      //  Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return SuccessPage();
        }),
      );
    });
  }

  Future<String> uploadImagetostorage() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilepictures")
        .child(widget.adminModel.uid.toString())
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

  // Future<String> uploadImagetostorage() async {
  //   UploadTask uploadTask = FirebaseStorage.instance
  //       .ref("profilepictures")
  //       .child(widget.userModel.uid.toString())
  //       .putFile(imageFile!);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String imageUrl = await snapshot.ref.getDownloadURL();
  //   return imageUrl;
  // }

  // void showPhotoOptions() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text("Upload Profile Picture"),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               ListTile(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                   selectImage(ImageSource.gallery);
  //                 },
  //                 leading: Icon(Icons.photo_album),
  //                 title: Text("Select from Gallery"),
  //               ),
  //               ListTile(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                   selectImage(ImageSource.camera);
  //                 },
  //                 leading: Icon(Icons.camera_alt),
  //                 title: Text("Take a photo"),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

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
              SizedBox(
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
                                    size: 50,
                                    color: ColorConstants.primaryColor)
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
                                capitalization: TextCapitalization.sentences,

                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
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
                      Spaces.y1,

                      /*
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Select store categories",
                                            style:
                                            TextStyle(color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:  'sans-serif'
                                            ),),
                                        ),
                                      ),
                                      Spaces.y2,

                                      SingleChildScrollView(
                                        child: Container(
                                          width: width* 0.85  ,
                                          height: 12.h,
                                          child: StreamBuilder(
                                            stream: firestore.collection("clothing types").snapshots(),
                                            builder: (context, snapshot){
                                              if(snapshot.hasData){

                                                return GridView.builder(
                                                    itemCount: snapshot.data!.docs.length,
                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                                                        childAspectRatio: 1/0.5,
                                                        crossAxisSpacing: 5,
                                                        mainAxisSpacing: 10,
                                                        crossAxisCount: 4),
                                                    itemBuilder: (BuildContext context, int index){
                                                      return InkWell(
                                                        onTap: (){


                                                          if(adminController.catId.contains(snapshot.data!.docs[index].data()['uid'])){
                                                            adminController.catId.remove(snapshot.data!.docs[index].data()['uid']);
                                                          }
                                                          else{
                                                            adminController.catId.add(snapshot.data!.docs[index].data()['uid']);
                                                          }
                                                          debugPrint("${adminController.catId.length}");
                                                          toggleSelection(index);
                                                          setState(() {

                                                          });
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(7),

                                                              color: adminController.catId.contains(snapshot.data!.docs[index].data()['uid']) ? ColorConstants.whiteColor : ColorConstants.grayLevel11
                                                          ),



                                                          child:  Center(
                                                            child: Text(snapshot.data!.docs[index].data()['category'],
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  color: adminController.catId.contains(snapshot.data!.docs[index].data()['uid']) ? ColorConstants.primaryColor : Colors.white),),
                                                          ),

                                                        ),
                                                      );
                                                    });
                                              }
                                              return CircularProgressIndicator();

                                               }
                                               ),
                                        ),
                                      ),*/
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomElevatedButton(
                        onPress: () {
                          checkValues();
                          //Get.toNamed('/successPage');
                          //Get.to(SuccessPage());
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
              Spaces.y1,
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select store categories",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'sans-serif'),
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
                          // return GridView.builder(
                          //     itemCount: snapshot.data!.docs.length,
                          //     gridDelegate:
                          //         SliverGridDelegateWithFixedCrossAxisCount(
                          //             childAspectRatio: 1 / 0.5,
                          //             crossAxisSpacing: 5,
                          //             mainAxisSpacing: 10,
                          //             crossAxisCount: 4),
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return InkWell(
                          //         onTap: () {
                          //       if (adminController.catId.contains(snapshot
                          //           .data!.docs[index]
                          //           .data()['uid'])) {
                          //         adminController.catId.remove(snapshot
                          //             .data!.docs[index]
                          //             .data()['uid']);
                          //       } else {
                          //         adminController.catId.add(snapshot
                          //             .data!.docs[index]
                          //             .data()['uid']);
                          //       }
                          //       debugPrint(
                          //           "${adminController.catId.length}");
                          //       toggleSelection(index);
                          //       setState(() {});
                          //     },
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(7),
                          //           color: adminController.catId.contains(
                          //                   snapshot.data!.docs[index]
                          //                       .data()['uid'])
                          //               ? ColorConstants.whiteColor
                          //               : ColorConstants.grayLevel11),
                          //       child: Center(
                          //         child: Text(
                          //           snapshot.data!.docs[index]
                          //               .data()['category'],
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //               color: adminController.catId
                          //                       .contains(snapshot
                          //                           .data!.docs[index]
                          //                           .data()['uid'])
                          //                   ? ColorConstants.primaryColor
                          //                   : Colors.white),
                          //         ),
                          //       ),
                          //     ),
                          //   );
                          // });
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
                  //Get.to(SuccessPage());
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
