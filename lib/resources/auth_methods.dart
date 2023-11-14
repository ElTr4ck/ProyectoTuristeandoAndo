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
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
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
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'email-already-in-use') {
        res = 'Este nombre de usuario ya esta en uso';
      }
      if (e.code == 'invalid-email') {
        res = 'email invalido';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //log in
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'error';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
        print(_auth.currentUser!.uid.toString());
      } else {
        res = 'enter all the fields';
      }
    } on FirebaseException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        res = 'user not found';
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
        res = 'Ingresa todos los campos';
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'invalid-email') {
        res = 'ivalid-email';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
