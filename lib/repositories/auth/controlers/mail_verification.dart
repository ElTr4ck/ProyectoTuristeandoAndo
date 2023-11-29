import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';

class MailVerificationController extends GetxController {
  late Timer _timer;
  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimer();
  }

  void sendVerificationEmail() async {
    try {
      final auth = AuthMethods.instance;
      await auth.sendVerificationEmail();
    } catch (e) {
      //herper.errorSnackbar();
    }
  }

  void setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        AuthMethods().setInitialScreen(user);
      }
    });
  }

  void manuallyChackEmail() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      AuthMethods().setInitialScreen(user);
    }
  }
}
