// ignore_for_file: unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/constants/app_string.dart';
import '../../models/user.dart';
import '../../views/auth/signin_view.dart';
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

  signUpWithEmailPass() async {
    //
  }

  signInWithEmailPass() async {
    //
  }

  googleSignIn() async {
    googleAccount.value = await _googleSignin.signIn();
    if (googleAccount.value != null) {
      User user = User(
        uid: googleAccount.value!.id,
        name: googleAccount.value!.displayName,
        email: googleAccount.value!.email,
        profileImage: googleAccount.value!.photoUrl,
      );
      _storage.write(LOGGED_IN, true);
      _storage.write(USER_NAME, user.name);
      _storage.write(USER_EMAIL, user.email);
      _storage.write(PROFILE_IMAGE, user.profileImage);

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
