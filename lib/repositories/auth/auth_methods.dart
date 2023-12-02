import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turisteando_ando/repositories/auth/firestore_methods.dart';
import 'package:turisteando_ando/repositories/exeptions/signup_email_failure.dart';
import 'dart:typed_data';
import 'package:turisteando_ando/repositories/auth/storage_methods.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/models/users/user.dart' as model;
import 'package:turisteando_ando/models/users/marcadores.dart';
import 'package:turisteando_ando/screens/frmSetLocation.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmcorreo_screen/frmcorreo_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frminvitado_screen/frminvitado_screen.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmwelcome_screen/frmwelcome_screen.dart';

class AuthMethods extends GetxController {
  static AuthMethods get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currenUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currenUser.uid).get();
    return model.User.formSnap(snap);
  }

  Future<void> sendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      String res = e.code;
      if (e.code == "too-many-requests") {
        res = "Revisa tu correo electrónico";
      }
      Get.showSnackbar(GetSnackBar(
        message: res,
        duration: const Duration(seconds: 5),
      ));
    }
  }

  //sign up user
  Future<void> signUpUser({
    required String email,
    required String password,
    required String name,
    required String lastName,
  }) async {
    try {
      //registrer user
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(cred.user!.uid);
      //add user
      /*
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);
        */
      model.User user = model.User(
        name: name,
        lastName: lastName,
        email: email,
        uid: cred.user!.uid,
        photo:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      );

      await _firestore
          .collection('usuarios')
          .doc(cred.user!.uid)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      final exp = SignupEmailFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION-${exp.message}');
      throw exp;
    } catch (_) {
      const exp = SignupEmailFailure();
      print('EXCEPTION-${exp.message}');
      throw exp;
    }
  }

  Future<bool> logInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      print(userCredential);
      //setInitialScreen(userCredential.user);
      return true;
    } on FirebaseAuthException catch (e) {
      String res;
      if (e.code == "network-request-failed") {
        res = "Verifica tu conexión a internet";
      } else {
        res = e.code;
      }
      Get.showSnackbar(GetSnackBar(
        message: res,
        duration: const Duration(seconds: 5),
      ));
      return false;
    }
  }

  Future<void> signUpAnonymously(
      {required String email,
      required String password,
      required String name,
      required String lastName}) async {
    try {
      //_auth.currentUser!.isAnonymous;
      final credential =
          EmailAuthProvider.credential(email: email, password: password);
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
      print(userCredential!.user!.uid);
      //add user
      /*
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);
        */
      model.User user = model.User(
        name: name,
        lastName: lastName,
        email: email,
        uid: userCredential.user!.uid,
        photo:
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      );
      await _firestore
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set(user.toJson());
    } on FirebaseAuthException catch (e) {
      final exp = SignupEmailFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION-${exp.message}');
      throw exp;
    } catch (_) {
      const exp = SignupEmailFailure();
      print('EXCEPTION-${exp.message}');
      throw exp;
    }
  }

  //log in
  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final exp = SignupEmailFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION-${exp.message}');
      throw exp;
    } catch (_) {
      const exp = SignupEmailFailure();
      print('EXCEPTION-${exp.message}');
      throw exp;
    }
  }

  Future<String> updateProfile(
      {required String email,
      required String password,
      required String address,
      required String name,
      //required String lastName,
      Uint8List? file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          address.isNotEmpty &&
          name.isNotEmpty) {
        /*User? user = _auth.currentUser;
        user?.updatePassword(password);
        user?.updateEmail(email);*/

        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (file != null) {
          String photoUrl =
              await StorageMethods().uploadImageToStorage('profilePics', file);
          await _firestore
              .collection('usuarios')
              .doc(cred.user!.uid)
              .update({'photoUrl': photoUrl});
          res = "success";
        }
        if (address.isNotEmpty) {
          await _firestore
              .collection('usuarios')
              .doc(cred.user!.uid)
              .update({'address': address});
          res = "success";
        }
        if (name.isNotEmpty) {
          await _firestore
              .collection('usuarios')
              .doc(cred.user!.uid)
              .update({'name': name});
          res = "success";
        }
      } else {
        res = 'Ingrese todos los campos';
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'invalid-email') {
        res = 'Correo electronico no valido';
      } else if (e.code == 'weak-password') {
        res = 'La contraseña debe contener al menos 6 caracteres';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> resetPassword(String emailReset) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailReset);
      /*Get.showSnackbar(const GetSnackBar(
        message: "Te hemos enviado un correo para cambiar la contraseña",
        duration: Duration(seconds: 5),
      ));*/
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.code,
        duration: const Duration(seconds: 3),
      ));
    }
  }

/*
  Future<void> confirmPassword(
      {required String code, required String newPassword}) async {
    await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
  }
*/
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.code,
        duration: const Duration(seconds: 5),
      ));
    }
  }

  bool checkEmail() {
    bool res = false;
    try {
      User? user = _auth.currentUser;
      res = user!.emailVerified;
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.code,
        duration: const Duration(seconds: 5),
      ));
    }
    return res;
  }

  Future<void> reload() async {
    await _auth.currentUser!.reload();
  }
}
