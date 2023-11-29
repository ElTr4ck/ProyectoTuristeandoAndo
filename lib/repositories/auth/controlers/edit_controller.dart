import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';

class EditController extends GetxController {
  static EditController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
}
