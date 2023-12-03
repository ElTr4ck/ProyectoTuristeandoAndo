import 'package:flutter/material.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/utils.dart';

class SignoutController {
  final email = TextEditingController();
  final password = TextEditingController();
  final BuildContext context;
  SignoutController({required this.context});
  Future<void> signout() async {
    try {
      final auth = AuthMethods();
      await auth.signOut();
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(e.toString(), context);
    }
  }
}
