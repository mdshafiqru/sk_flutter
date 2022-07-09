import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../views/auth/signin_view.dart';
import '../constants/app_string.dart';

final _storage = GetStorage();

logout() async {
  await GoogleSignIn().signOut().then((value) {
    _storage.write(LOGGED_IN, false);
    _storage.remove(USER_NAME);
    _storage.remove(USER_EMAIL);
    _storage.remove(PROFILE_IMAGE);
    Get.offAll(() => SigninView());
  });
}
