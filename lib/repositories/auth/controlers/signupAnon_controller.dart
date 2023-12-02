import 'package:flutter/material.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/utils.dart';
import 'package:turisteando_ando/repositories/exeptions/signup_email_failure.dart';

class SignupAnonController {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final lastName = TextEditingController();
  final BuildContext context;
  SignupAnonController({required this.context});
  void signUpAnonymously(
      {required String email,
      required String password,
      required String name,
      required String lastName}) async {
    try {
      final auth = AuthMethods();
      await auth.signUpAnonymously(
          email: email, password: password, name: name, lastName: lastName);
      // ignore: use_build_context_synchronously
      auth.sendVerificationEmail(context);
    } on SignupEmailFailure catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(e.message, context);
    }
  }
}
