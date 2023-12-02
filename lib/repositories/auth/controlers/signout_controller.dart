import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';

class SignoutController {
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> signout() async {
    try {
      final auth = AuthMethods();
      await auth.signOut();

      //await auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      print(e);
    }
  }
}
