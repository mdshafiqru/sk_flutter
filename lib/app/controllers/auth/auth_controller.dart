// ignore_for_file: unused_field, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/constants/app_string.dart';
import '../../data/constants/color_palatte.dart';
import '../../models/user.dart';
import '../../views/dashboard/dashboard/dashboard_view.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var creatingAccount = false.obs;
  var logingIn = false.obs;
  var hidePassword = true.obs;

  var checkingForgetPassword = false.obs;
  var signingWithEmailPass = false.obs;

  signUpWithEmailPass() async {
    //
  }

  signInWithEmailPass({required String email, required String password}) async {
    if (!signingWithEmailPass.value) {
      signingWithEmailPass.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((error) {
        signingWithEmailPass.value = false;
        Get.defaultDialog(
          title: "Login Error",
          content: Text(error.message),
          onConfirm: () => Get.back(),
          confirmTextColor: whiteColor,
        );
      });

      if (userCredential.user != null) {
        CustomUser user = CustomUser(
          uid: userCredential.user!.uid,
          name: userCredential.user!.displayName,
          email: userCredential.user!.email,
          profileImage: userCredential.user!.photoURL,
        );
        _storage.write(LOGGED_IN, true);
        _storage.write(USER_NAME, user.name ?? "");
        _storage.write(USER_EMAIL, user.email ?? "");
        _storage.write(PROFILE_IMAGE, user.profileImage ?? "");
        _storage.write(SIGN_IN_METHOD, SIGN_WITH_EMAIL_PASS);
        signingWithEmailPass.value = false;
        Get.offAll(() => DashboardView());
      } else {
        signingWithEmailPass.value = false;
      }
    }
  }

  googleSignIn() async {
    googleAccount.value = await _googleSignin.signIn();
    if (googleAccount.value != null) {
      CustomUser user = CustomUser(
        uid: googleAccount.value!.id,
        name: googleAccount.value!.displayName,
        email: googleAccount.value!.email,
        profileImage: googleAccount.value!.photoUrl,
      );
      _storage.write(LOGGED_IN, true);
      _storage.write(USER_NAME, user.name ?? "");
      _storage.write(USER_EMAIL, user.email ?? "");
      _storage.write(PROFILE_IMAGE, user.profileImage ?? "");
      _storage.write(SIGN_IN_METHOD, SIGN_WITH_GOOGLE);

      Get.offAll(() => DashboardView());
    } else {
      Get.defaultDialog(
        title: "Opps!",
        content: Text('Failed to login, please check internet connection'),
        onConfirm: () => Get.back(),
      );
    }
  }
}
