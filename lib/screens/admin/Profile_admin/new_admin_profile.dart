import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/screens/Customer_screens/auth/signin_customer.dart';
import 'package:timeless/screens/admin/Profile_admin/Settings_admin/settings_admin.dart';
import 'package:timeless/screens/admin/Profile_admin/edit_profile.dart';
import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/multiline_text_field.dart';

class AdminProfilePage extends StatefulWidget {
  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void _saveChanges() {
    setState(() {
      name = _nameController.text;
      email = _emailController.text;
      _isEditing = false;
    });
  }

  User? user;
  String name = '';
  String email = '';
  String profilePicUrl = '';

  @override
  void initState() {
    _nameController.text = name;
    _emailController.text = email;
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      loadAdminData();
    }
  }

  Future<void> loadAdminData() async {
    if (user != null) {
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('Admins')
          .doc(user!.uid)
          .get();

      if (adminSnapshot.exists) {
        setState(() {
          name = adminSnapshot['fullname'];
          email = adminSnapshot['email'];
          profilePicUrl = adminSnapshot['profilepic'];
        });
      }
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (user != null) {
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Admins')
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }

          // Access the data and update your widgets
          String name = snapshot.data!['fullname'];
          String email = snapshot.data!['email'];
          String profilePicUrl = snapshot.data!['profilepic'];

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "My Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'sans-serif',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Color.fromRGBO(159, 135, 135, 1),
                elevation: 0,
                actions: [
                  InkWell(
                      onTap: () {
                        // _toggleEditMode();
                        Get.to(EditProfilePage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminSettings()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  )
                ],
              ),
              body: Container(
                  height: height * 1,
                  width: width * 1,
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
                  child: SingleChildScrollView(
                      child: Center(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spaces.y7,
                                    CircleAvatar(
                                      radius: 75,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          NetworkImage(profilePicUrl),
                                    ),
                                    Spaces.y2,
                                    CustomMultilineTextField(
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      capitalization: TextCapitalization.words,

                                      onTextChange: (value) {},
                                      // hint: "Name",
                                      enable: _isEditing,
                                      backgroundColor: Colors.white,
                                      //backgroundColor: Colors.white,
                                      controller: _nameController,
                                      hint: name,
                                    ),
                                    CustomMultilineTextField(
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Required";
                                        }
                                        return null;
                                      },
                                      capitalization:
                                          TextCapitalization.characters,

                                      onTextChange: (value) {},
                                      //hint: "Email",

                                      enable: _isEditing,
                                      backgroundColor: Colors.white,
                                      //backgroundColor: Colors.white,
                                      controller: _emailController,
                                      hint: email,
                                    ),
                                    SizedBox(height: 15.h),
                                    if (_isEditing)
                                      InkWell(
                                        onTap: _saveChanges,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: Container(
                                            //width: width*0.8,
                                            height: 6.5.h,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),

                                            child: Center(
                                              child: Text(
                                                'Save',
                                                //textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: ColorConstants
                                                      .primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    CustomElevatedButton(
                                      onPress: () {
                                        FirebaseAuth.instance.signOut();

                                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                                        auth.signOut().then((value) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerSignIn()));
                                        }).onError((error, stackTrace) {
                                          Fluttertoast.showToast(
                                              msg: error.toString());
                                        });
                                      },
                                      height: 6.5.h,
                                      title: "Logout",
                                      //   child: loading ? CircularProgressIndicator() : Text("Submit"),
                                      titleColor: ColorConstants.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      bgColor: Colors.white,
                                      borderRadius: 7,
                                    )
                                  ]))))));
        },
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Admin Profile'),
        ),
        body: Center(
          child: Text(
              'User not logged in'), // Handle the case where the user is not logged in
        ),
      );
    }
  }
}
