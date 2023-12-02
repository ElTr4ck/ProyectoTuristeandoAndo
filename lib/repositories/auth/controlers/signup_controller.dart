import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/exeptions/signup_email_failure.dart';

class SignupController {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final lastName = TextEditingController();

  Future<bool> signUp(
      {required String email,
      required String password,
      required String name,
      required String lastName}) async {
    try {
      final auth = AuthMethods();
      await auth.signUpUser(
          email: email, password: password, name: name, lastName: lastName);
      return true;
    } on SignupEmailFailure catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        duration: const Duration(seconds: 3),
      ));
      return false;
    }
  }
}
