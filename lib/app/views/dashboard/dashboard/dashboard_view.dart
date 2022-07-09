// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../../data/constants/app_string.dart';
import '../../../data/helpers/helper_functions.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              // Container(
              //   height: 100,
              //   width: 100,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Colors.white,
              //     image: DecorationImage(image:  ),
              //   ),
              // ),
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
