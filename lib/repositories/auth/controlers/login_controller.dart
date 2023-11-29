import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/exeptions/signup_email_failure.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser({required String email, required String password}) async {
    try {
      final auth = AuthMethods.instance;
      await auth.loginUser(email: email, password: password);

      auth.setInitialScreen(auth.firebaseUser);
    } on SignupEmailFailure catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
