// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../data/constants/color_palatte.dart';
import '../dashboard/dashboard/dashboard_view.dart';
import 'reset_password/forget_password_view.dart';
import 'sign up/signup_view.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninView extends StatelessWidget {
  SigninView({Key? key}) : super(key: key);

  final _signinFormKey = GlobalKey<FormState>();

  final _authController = Get.put(AuthController());

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _emailController,
      style: TextStyle(fontSize: 14),
      validator: MultiValidator([
        RequiredValidator(errorText: 'Email is required'),
        EmailValidator(errorText: 'Please enter a valid email'),
      ]),
      onChanged: (val) => _authController.email.value = val,
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

    final passwordField = Obx(
      () => TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(40)],
        controller: _passwordController,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Email is required'),
          MinLengthValidator(6,
              errorText: 'Password must be at least 6 character long')
        ]),
        obscureText: _authController.hidePassword.value,
        onChanged: (val) => _authController.password.value = val,
        style: TextStyle(fontSize: 14),
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
          hintText: "Password",
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: IconButton(
            onPressed: () => Get.find<AuthController>().hidePassword.value =
                !Get.find<AuthController>().hidePassword.value,
            icon: Obx(
              () => Icon(Get.find<AuthController>().hidePassword.value
                  ? Icons.visibility
                  : Icons.visibility_off),
            ),
          ),
        ),
      ),
    );

    final signinTitle = Text(
      'Welcome Back',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darkTextColor,
      ),
    );

    final signinSubtitle = Text(
      'Login to start your session ',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: lightTextColor,
      ),
    );

    final loginButton = SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          if (_signinFormKey.currentState!.validate()) {
            Get.find<AuthController>().signInWithEmailPass(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
          }
        },
        color: purpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Obx(() {
          return Get.find<AuthController>().signingWithEmailPass.value
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
                  'Login',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                );
        }),
      ),
    );

    final signupAlternateTitle = Row(
      children: [
        Expanded(child: Divider()),
        SizedBox(width: 16),
        Text(
          'or sign in via',
          style: TextStyle(
            color: lightTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16),
        Expanded(child: Divider()),
      ],
    );

    final singinGoogleButton = SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: () async {
          Get.find<AuthController>().googleSignIn();
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/google-logo.png",
              width: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Google',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );

    final createAccountTitle = Wrap(
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: lightTextColor,
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => SignupView()),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: purpleColor,
            ),
          ),
        ),
      ],
    );

    final forgetPasswordTitle = Wrap(
      children: [
        Text(
          "Forgot Password? ",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: lightTextColor,
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => ForgetPasswordView()),
          child: Text(
            'Reset Now',
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
            key: _signinFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 52),
                  signinTitle,
                  SizedBox(height: 4),
                  signinSubtitle,
                  SizedBox(height: 24),
                  emailField,
                  SizedBox(height: 16),
                  passwordField,
                  SizedBox(height: 16),
                  loginButton,
                  SizedBox(height: 16),
                  signupAlternateTitle,
                  SizedBox(height: 16),
                  singinGoogleButton,
                  SizedBox(height: 16),
                  createAccountTitle,
                  SizedBox(height: 16),
                  forgetPasswordTitle,
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
