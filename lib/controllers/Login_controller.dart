// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:timeless/models/AdminModel.dart';
import 'package:timeless/screens/Customer_screens/BottomBarNew/bottom_bar.dart';
import 'package:timeless/screens/admin/admin_bottom_bar/bottom_bar_screen.dart';
import 'package:timeless/utils/utility_const.dart';
import '../Constants/firebase_consts.dart';
import '../models/UIHelper.dart';
import '../models/UserModel.dart';
import '../utils/notification_services.dart';

class LoginController extends GetxController {
  NotificationServices notificationServices = NotificationServices();

  Rx<UserModel> userModel = UserModel(
          uid: "", fullname: "", email: "", profilepic: "", cat: [], token: "")
      .obs;
  Rx<AdminModel> activeAdmin =
      AdminModel(uid: "", fullname: "", email: "", profilepic: "", token: "")
          .obs;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  logIn(String email, String password, context) async {
    UserCredential? credential;
    try {
      setLoading();
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      DocumentSnapshot adminData = await FirebaseFirestore.instance
          .collection('Admins')
          .doc(auth.currentUser!.uid)
          .get();
      DocumentSnapshot custData = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(auth.currentUser!.uid)
          .get();
      if (adminData.exists) {
        activeAdmin.value =
            AdminModel.fromMap(adminData.data() as Map<String, dynamic>);
        await notificationServices.getFcmTokenForAdmin();
        hideLoading();
        Get.offAll(BottomBarScreenAdmin());
      } else if (custData.exists && auth.currentUser!.emailVerified) {
        await notificationServices.getFcmTokenForCustomer();
        userModel.value =
            UserModel.fromMap(custData.data() as Map<String, dynamic>);
        hideLoading();
        Get.offAll(BottomBarScreen1());
      } else {
        hideLoading();
        Fluttertoast.showToast(msg: "Verify email first");
        debugPrint("Verify email first");
      }
    } on FirebaseAuthException catch (ex) {
      // Close the loading dialog
      // Show Alert Dialog
      hideLoading();
      UIHelper.showAlertDialog(
          context, "Verify email first", ex.message.toString());
    }
  }

  signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    debugPrint(userCredential.user?.displayName);
    //StaticData.name= userCredential.user!.displayName!;

    debugPrint(userCredential.user?.email);
    //StaticData.email= userCredential.user!.email!;

    if (userCredential.user != null) {
      Get.to(BottomBarScreen1());
      // Navigator.push(context as BuildContext,
      //     MaterialPageRoute(builder: (context) => SelectCategory()));
    }
  }




  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  signInWithApple(BuildContext context) async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    //  await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    debugPrint(userCredential.user?.displayName);
    //StaticData.name= userCredential.user!.displayName!;

    debugPrint(userCredential.user?.email);
    //StaticData.email= userCredential.user!.email!;

    if (userCredential.user != null) {
      Get.to(BottomBarScreen1());
      // Navigator.push(context as BuildContext,
      //     MaterialPageRoute(builder: (context) => SelectCategory()));
    }

  }


  logout() {
    auth.signOut();
    googleSignIn.signOut();
    // FacebookAuth.instance.logOut();
  }
}
