import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:timeless/constants/color_constants.dart';
import 'package:timeless/screens/Customer_screens/auth/signin_customer.dart';
import 'package:timeless/widgets/custom_elevated_button.dart';
import 'package:timeless/widgets/multiline_text_field.dart';

import '../../../utils/space_values.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;

  Future<void> changePassword() async {
    try {
      User? user = auth.currentUser;

      if (user != null) {
        // Check if the old password entered matches the user's current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPasswordController.text,
        );

        try {
          await user.reauthenticateWithCredential(credential);
        } catch (e) {
          // If reauthentication fails, show an error message
          print("Error: Old password does not match the current password");
          showErrorDialog("Old password is incorrect");
          return;
        }

        // Check if the new password matches the confirm password
        if (newPasswordController.text != confirmPasswordController.text) {
          showErrorDialog("New password and confirm password do not match");
          return;
        }

        // Now the user is reauthenticated, update the password
        await user.updatePassword(newPasswordController.text);

        // Password updated successfully
        print("Password changed successfully");

        // Sign out the user
        await auth.signOut();

        // Navigate to the sign-in screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomerSignIn()),
        );
      } else {
        // No user is currently signed in
        print("No user is signed in");
      }
    } catch (e) {
      // Handle password change error
      print("Error changing password: $e");
      showErrorDialog("Error changing password: $e");
    }
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Spaces.y7,
                      Text(
                        "Change Password",
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Spaces.y10,
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
                                capitalization: TextCapitalization.none,
                                onTextChange: (value) {},
                                hint: "Old Password",
                                backgroundColor: Colors.white,
                                controller: oldPasswordController,
                              ),
                              CustomMultilineTextField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                capitalization: TextCapitalization.none,
                                onTextChange: (value) {},
                                hint: "New Password",
                                hasPasswordEye: true,
                                backgroundColor: Colors.white,
                                controller: newPasswordController,
                              ),
                              CustomMultilineTextField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                capitalization: TextCapitalization.none,
                                onTextChange: (value) {},
                                backgroundColor: Colors.white,
                                hint: "Confirm Password",
                                controller: confirmPasswordController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      CustomElevatedButton(
                        onPress: () async {
                          // Add validation for the passwords here if needed
                          await changePassword();
                        },
                        height: 6.5.h,
                        title: "Submit",
                        titleColor: ColorConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        bgColor: Colors.white,
                        borderRadius: 7,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
