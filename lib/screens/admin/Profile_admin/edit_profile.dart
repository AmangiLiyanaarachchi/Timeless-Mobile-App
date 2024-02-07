import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/widgets/multiline_text_field.dart';

import '../../../Constants/color_constants.dart';
import '../../../constants/firebase_consts.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_elevated_button.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _profilePictureUrl = ''; // Store the profile picture URL here
  String _image = ""; // Store the selected image file here

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchProfilePictureUrl(user?.uid);
    if (user != null) {
      // Retrieve current user data and populate form fields
      FirebaseFirestore.instance
          .collection('Admins')
          .doc(user!.uid)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            _nameController.text = documentSnapshot['fullname'];
            _emailController.text = documentSnapshot['email'];
          });
        }
      });
    }
  }

  void _fetchProfilePictureUrl(String? uid) async {
    if (uid != null) {
      final doc = await firestore.collection('Admins').doc(uid).get();
      setState(() {
        _profilePictureUrl = doc.data()?['profilepic'] ?? '';
      });
    }
  }

  removeOldImg(String imgurl) {
    Reference imgRef = FirebaseStorage.instance.refFromURL(imgurl);

    imgRef.delete();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      String newName = _nameController.text;
      String newEmail = _emailController.text;

      try {
        if (_image.isNotEmpty) {
          // Upload the image to Firebase Storage
          Reference storageReference = FirebaseStorage.instance
              .ref()
              .child('profilepictures/${user!.uid}.jpeg');
          await storageReference.putFile(File(_image));

          // Get the download URL of the uploaded image
          String imageUrl = await storageReference.getDownloadURL();

          // Update the user's profile with the new data, including the image URL
          await FirebaseFirestore.instance
              .collection('Admins')
              .doc(user!.uid)
              .update({
            'fullname': newName,
            'email': newEmail,
            'profilepic': imageUrl,
          });
        } else {
          // If no new image was selected, only update name and email
          await FirebaseFirestore.instance
              .collection('Admins')
              .doc(user!.uid)
              .update({
            'fullname': newName,
            'email': newEmail,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully!'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $e'),
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(159, 135, 135, 1),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'sans-serif',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

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
                  //       Image.asset(
                  //       "assets/images/home_bg.png",
                  //       width: double.maxFinite,
                  //       height: double.maxFinite,
                  //       fit: BoxFit.cover,
                  //
                  // ),
                  SingleChildScrollView(
                      child: Center(
                    child: Column(children: [
                      Spaces.y7,

                      // CircleAvatar(
                      //   radius: 75,
                      //   backgroundColor: Colors.white,
                      //   backgroundImage: NetworkImage(
                      //       profilePicUrl),
                      // ),

                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: Stack(children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  // _image != null
                                  //     ? FileImage(File(_image!.path))
                                  //     : NetworkImage(user?.photoURL ?? '') as ImageProvider,
                                  (_image.isNotEmpty)
                                      ? FileImage(File(_image))
                                      : (_profilePictureUrl.isNotEmpty)
                                          ? NetworkImage(_profilePictureUrl)
                                          : AssetImage(
                                                  'assets/images/user_placeholder.png')
                                              as ImageProvider,
                            ),
                            Positioned(
                                bottom: 0,
                                right: 2,
                                child: InkWell(
                                  onTap: _pickImage,
                                  child: CircleAvatar(
                                      backgroundColor:
                                          ColorConstants.primaryColor,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                )),
                          ]),
                        ),
                      ),

                      Spaces.y3,

                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // TextFormField(
                            //   controller: _nameController,
                            //   decoration: InputDecoration(labelText: 'Name'),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter your name';
                            //     }
                            //     return null;
                            //   },
                            // ),

                            CustomMultilineTextField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Required";
                                }
                                return null;
                              },
                              capitalization: TextCapitalization.words,
                              onTextChange: (value) {},
                              backgroundColor: Colors.white,
                              controller: _nameController,
                            ),

                            SizedBox(height: 20),

                            Spaces.y3,

                            CustomElevatedButton(
                              onPress: () {
                                removeOldImg(_profilePictureUrl);
                                _updateProfile();
                              },
                              height: 6.5.h,
                              title: "Save Changes",
                              titleColor: ColorConstants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              bgColor: Colors.white,
                              borderRadius: 7,
                            )
                          ],
                        ),
                      ),
                    ]),
                  ))
                ]))));
  }
}
