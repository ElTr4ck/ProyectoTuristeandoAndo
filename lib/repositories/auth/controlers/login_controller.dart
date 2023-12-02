import 'package:flutter/material.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/utils.dart';
import 'package:turisteando_ando/repositories/exeptions/signup_email_failure.dart';

class LoginController {
  final email = TextEditingController();
  final password = TextEditingController();
  final BuildContext context;
  LoginController({required this.context});

  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      final auth = AuthMethods();
      await auth.loginUser(
          email: email.toString().trim(), password: password.toString().trim());
      return true;
    } on SignupEmailFailure catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(e.message, context);

      return false;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(e.toString(), context);

      return false;
    }
  }
}
