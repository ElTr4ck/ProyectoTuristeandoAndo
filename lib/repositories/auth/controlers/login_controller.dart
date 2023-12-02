import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/exeptions/signup_email_failure.dart';

class LoginController {
  final email = TextEditingController();
  final password = TextEditingController();

  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      final auth = AuthMethods();
      await auth.loginUser(
          email: email.toString().trim(), password: password.toString().trim());
      return true;
    } on SignupEmailFailure catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: const Duration(seconds: 3),
      ));
      return false;
    } catch (e) {
      String res = e.toString();
      Get.showSnackbar(GetSnackBar(
        message: res,
        duration: const Duration(seconds: 3),
      ));
      return false;
    }
  }
}
