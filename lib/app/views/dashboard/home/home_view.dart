// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sk_flutter_boilerplate/app/data/helpers/helper_functions.dart';

import '../../../data/constants/app_string.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
            children: [
              Text('Home view'),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
