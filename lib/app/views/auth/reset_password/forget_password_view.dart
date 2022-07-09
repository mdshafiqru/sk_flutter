// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../../data/constants/color_palatte.dart';
import '../signin_view.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({Key? key}) : super(key: key);

  final _resetPassFormKey = GlobalKey<FormState>();

  final _authController = Get.put(AuthController());

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      style: TextStyle(fontSize: 14),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Email is required'),
        EmailValidator(errorText: 'Please enter a valid email'),
      ]),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: textFieldColor,
        hintText: "Email",
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    final forgetPasswordTitle = Row(
      children: [
        Expanded(
          child: Text(
            'Forgot your password? ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: darkTextColor,
            ),
          ),
        ),
      ],
    );

    final forgetSubtitle = Text(
      'Just enter your email ',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: lightTextColor,
      ),
    );

    final resetButton = SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          if (_resetPassFormKey.currentState!.validate()) {
            // Get.find<AuthController>().googleSignIn();
          }
        },
        color: purpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Obx(() {
          return Get.find<AuthController>().checkingForgetPassword.value
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Checking..',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Next',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                );
        }),
      ),
    );

    final signinTitle = Wrap(
      children: [
        Text(
          "Back to ",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: lightTextColor,
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => SigninView()),
          child: Text(
            'Sign In',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: purpleColor,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _resetPassFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 52),
                  forgetPasswordTitle,
                  SizedBox(height: 4),
                  forgetSubtitle,
                  SizedBox(height: 24),
                  emailField,
                  SizedBox(height: 16),
                  resetButton,
                  SizedBox(height: 16),
                  signinTitle,
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
