// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../../data/constants/app_string.dart';
import '../../../data/helpers/helper_functions.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userPhoto = GetStorage().read(PROFILE_IMAGE) ?? "";
    String userName = GetStorage().read(USER_NAME) ?? "No Name";
    String email = GetStorage().read(USER_EMAIL) ?? "No Email";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(APP_NAME),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: userPhoto.isNotEmpty
                        ? NetworkImage(userPhoto)
                        : AssetImage(DEFUALT_USER_IMAGE)
                            as ImageProvider<Object>,
                  ),
                ),
              ),
              Text(userName),
              Text(email),
              Text('Home view'),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  logout();
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
