// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:sk_flutter_boilerplate/app/views/auth/signin_view.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../../data/constants/app_string.dart';
import '../../../data/constants/color_palatte.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);

  final _signupFormKey = GlobalKey<FormState>();

  final _authController = Get.put(AuthController());

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      style: TextStyle(fontSize: 14),
      keyboardType: TextInputType.name,
      validator: RequiredValidator(errorText: 'Name is required'),
      onChanged: (val) => _authController.name.value = val,
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
        hintText: "Full Name",
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    final emailField = TextFormField(
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

    final confirmPasswordField = Obx(
      () => TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(40)],
        validator: (val) {
          String cpass = val ?? "";
          String pass = Get.find<AuthController>().password.value;

          if (pass != cpass || cpass.isEmpty) {
            return "confirm password not matched";
          } else {
            return null;
          }
        },
        obscureText: _authController.hidePassword.value,
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
          hintText: "Confirm Password",
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

    final signupTitle = Text(
      'Sign Up to $APP_NAME',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darkTextColor,
      ),
    );

    final signupSubtitle = Wrap(
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: lightTextColor,
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(() => SigninView()),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: purpleColor,
            ),
          ),
        ),
      ],
    );

    final createAccountButton = SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          if (_signupFormKey.currentState!.validate()) {
            Get.find<AuthController>().signUpWithEmailPass();
          }
        },
        color: purpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 14),
        child: Obx(() {
          return Get.find<AuthController>().creatingAccount.value
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Creating..',
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
                  'Create Account',
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
          'or sign up via',
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

    final singupGoogleButton = SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {},
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

    final termsConditionTitle = Wrap(
      children: [
        Text(
          'By Signing up to Mastermind you agree to our ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: lightTextColor,
          ),
        ),
        Text(
          'Terms and conditions',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: purpleColor,
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _signupFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 52),
                  signupTitle,
                  SizedBox(height: 4),
                  signupSubtitle,
                  SizedBox(height: 24),
                  nameField,
                  SizedBox(height: 16),
                  emailField,
                  SizedBox(height: 16),
                  passwordField,
                  SizedBox(height: 16),
                  confirmPasswordField,
                  SizedBox(height: 16),
                  createAccountButton,
                  SizedBox(height: 16),
                  signupAlternateTitle,
                  SizedBox(height: 16),
                  singupGoogleButton,
                  SizedBox(height: 16),
                  termsConditionTitle,
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
