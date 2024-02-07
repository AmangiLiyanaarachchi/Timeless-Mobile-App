import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/firebase_consts.dart';
import 'package:timeless/screens/Customer_screens/Profile/Settings/settings.dart';
import 'package:timeless/screens/Customer_screens/Profile/change_password.dart';
import 'package:timeless/screens/Customer_screens/Profile/edit_customer_profile.dart';
import 'package:timeless/screens/Customer_screens/auth/signin_customer.dart';
import '../../../Constants/color_constants.dart';
import '../../../utils/space_values.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/multiline_text_field.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  User? user;
  String name = '';
  String email = '';
  String profilePicUrl = '';
  bool canDelete = false;
  bool haveOrder = false;

  @override
  void initState() {
    _nameController.text = name;
    _emailController.text = email;
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      loadUserData();
      print(canDelete);
      print(user!.uid);
      print("----------------------------------");
    }
    FirebaseFirestore.instance
        .collection('Orders')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (user!.uid == doc['custId'] && doc['orderStatus'] == 'pending') {
          print(doc);
          print(doc["orderStatus"]);
          canDelete = false;
          print(canDelete);
        } else {
          canDelete = true;
          print(canDelete);
        }
      });
    });
  }

  deleteUser() {
    if (canDelete) {
      firestore.collection("Customers").doc(user!.uid).delete();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CustomerSignIn()));
    } else {
      setState(() {
        haveOrder = true;
      });
    }
  }

  Future<void> loadUserData() async {
    if (user != null) {
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('Customers')
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
            .collection('Customers')
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
          } else {
            if (snapshot.data!.exists) {
              // Access the data and update your widgets
              String name = snapshot.data!['fullname'];
              String email = snapshot.data!['email'];
              String profilePicUrl = snapshot.data!['profilepic'];
              _nameController.text = name;
              _emailController.text = email;

              return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "My Account",
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontFamily: 'sans-serif',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    actions: [
                      InkWell(
                          onTap: () {
                            Get.to(EditCustomerProfile());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              Icons.edit,
                              color: ColorConstants.primaryColor,
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.settings,
                            color: ColorConstants.primaryColor,
                            size: 28,
                          ),
                        ),
                      )
                    ],
                  ),
                  drawer: CustomDrawer(),
                  body: Container(
                      height: height * 1,
                      width: width * 1,
                      child: SingleChildScrollView(
                          child: Center(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Spaces.y6,
                                        CircleAvatar(
                                          radius: 75,
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              NetworkImage(profilePicUrl),
                                        ),
                                        Spaces.y5,
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.w),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    ColorConstants.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Column(
                                              children: [
                                                Spaces.y1,
                                                CustomMultilineTextField(
                                                  validator: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Required";
                                                    }
                                                    return null;
                                                  },

                                                  capitalization:
                                                      TextCapitalization.none,

                                                  onTextChange: (value) {},
                                                  // hint: "Name",
                                                  enable: false,
                                                  hasBorder: false,
                                                  title: "Full name",
                                                  titleColor: Colors.grey,

                                                  backgroundColor: Colors.white,
                                                  //backgroundColor: Colors.white,
                                                  controller: _nameController,
                                                ),
                                                Spaces.y3,
                                                CustomMultilineTextField(
                                                  validator: (val) {
                                                    if (val!.isEmpty) {
                                                      return "Required";
                                                    }
                                                    return null;
                                                  },
                                                  capitalization:
                                                      TextCapitalization.words,
                                                  onTextChange: (value) {},
                                                  hasBorder: false,
                                                  backgroundColor: Colors.white,
                                                  controller: _emailController,
                                                  title: "Email",
                                                  borderColor: ColorConstants
                                                      .primaryColor,
                                                  titleColor: Colors.grey,
                                                ),
                                                Spaces.y5,
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        CustomElevatedButton(
                                          onPress: () {
                                            // FirebaseAuth.instance.signOut();

                                            // //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                                            // auth.signOut().then((value) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChangePassword()));
                                            // }).onError((error, stackTrace) {
                                            //   Fluttertoast.showToast(
                                            //       msg: error.toString());
                                            // });
                                          },
                                          height: 6.5.h,
                                          title: "Change Password",
                                          //   child: loading ? CircularProgressIndicator() : Text("Submit"),
                                          titleColor: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          bgColor: ColorConstants.primaryColor,
                                          borderRadius: 7,
                                        ),
                                        //SizedBox(height: 3.h),
                                        CustomElevatedButton(
                                          onPress: () {
                                            deleteUser();
                                            //FirebaseAuth.instance.signOut();

                                            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                                            // auth.signOut().then((value) {
                                            //   Navigator.pushReplacement(
                                            //       context,
                                            //       MaterialPageRoute(
                                            //           builder: (context) =>
                                            //               CustomerSignIn()));
                                            // }).onError((error, stackTrace) {
                                            //   Fluttertoast.showToast(
                                            //       msg: error.toString());
                                            // });
                                          },
                                          height: 6.5.h,
                                          title: "Delete account",
                                          //   child: loading ? CircularProgressIndicator() : Text("Submit"),
                                          titleColor: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          bgColor: ColorConstants.primaryColor,
                                          borderRadius: 7,
                                        ),
                                        haveOrder
                                            ? Text(
                                                "You cannot delete your account. You have an order!",
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 255, 0, 0),
                                                  fontFamily: 'sans-serif',
                                                  fontWeight: FontWeight.bold,
                                                ))
                                            : Text("")
                                      ]))))));
            } else {
              return Text("No data");
            }
          }
        },
      );
    } else {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text('Admin Profile'),
        // ),
        body: Center(
          child: Text(
              'User not logged in'), // Handle the case where the user is not logged in
        ),
      );
    }
  }
}
