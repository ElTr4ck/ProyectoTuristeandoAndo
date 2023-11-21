import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:turisteando_ando/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String lastName,
  }) async {
    String res = "Ocurrio un error";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          lastName.isNotEmpty) {
        //registrer user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        //add user
        /*
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);
        */
        await _firestore.collection('usuarios').doc(cred.user!.uid).set({
          'name': name,
          'lastName': lastName,
          'email': email,
          'uid': cred.user!.uid,
          'photoUrl':
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
        });
        res = "success";
      } else {
        res = 'Ingresa todos los campos';
        return res;
      }
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      await FirebaseAuth.instance.currentUser?.reload();
      res = "Te hemos enviado un correo electrónico para verificar la cuenta";
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        res = 'Usuario no registrado';
      } else if (e.code == 'wrong-password') {
        res = 'Contraseña incorrecta';
      } else if (e.code == 'email-already-in-use') {
        res = 'Este correo ya esta asociado a una cuenta';
      } else if (e.code == 'invalid-email') {
        res = 'Correo electrónico invalido';
      } else if (e.code == 'weak-password') {
        res = 'La contraseña debe contener al menos 6 caracteres';
      } else if (e.code == 'network-request-failed') {
        res = 'Verifica tu conexión a internet';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> logInAnonymously() async {
    String res = 'Error';
    try {
      final userCredential = await _auth.signInAnonymously();
      print(userCredential);
      res = "Ingresando como usuario invitado";
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
    return res;
  }

  Future<String> signUpAnonymously(
      {required String emailAddress, required String password}) async {
    String res = 'error';
    try {
      //_auth.currentUser!.isAnonymous;
      final credential =
          EmailAuthProvider.credential(email: emailAddress, password: password);
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
      res = "successs";
    } on FirebaseAuthException catch (e) {
      res = e.code;
    }
    return res;
  }

  //log in
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Error';
    bool verificado = false;
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        if (_auth.currentUser!.emailVerified) {
          res = 'success';
          verificado = true;
          print(_auth.currentUser!.uid.toString());
        } else {
          await _auth.signOut();
          res = 'Verifica tu correo electronico';
        }
      } else {
        res = 'Ingresa todos los campos';
      }
    } on FirebaseException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        res = 'Usuario no registrado';
      } else if (e.code == 'wrong-password') {
        res = 'Contraseña incorrecta';
      } else if (e.code == 'email-already-in-use') {
        res = 'Este correo ya esta asociado a una cuenta';
      } else if (e.code == 'invalid-email') {
        res = 'Correo electrónico invalido';
      } else if (verificado) {
        res = 'Verifica tu correo electronico';
      } else if (e.code == 'weak-password') {
        res = 'La contraseña debe contener al menos 6 caracteres';
      } else if (e.code == 'network-request-failed') {
        res = 'Verifica tu conexión a internet';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
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

  Future<void> resetPassword() async {
    /*_auth.sendPasswordResetEmail(email: _auth.currentUser!.email.toString()).then((link) => {
    return sendCustomPasswordResetEmail(userEmail, displayName, link);})*/
    await _auth.sendPasswordResetEmail(
        email: _auth.currentUser!.email.toString());
    //_auth.verifyPasswordResetCode(code);
  }

  Future<void> confirmPassword(
      {required String code, required String newPassword}) async {
    await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
  }

  Future<void> signOut() async {
    _auth.signOut();
  }
}
