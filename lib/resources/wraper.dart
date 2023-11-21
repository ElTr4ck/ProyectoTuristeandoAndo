import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import 'package:rxdart/rxdart.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  User? user;
  @override
  void initState() {
    super.initState();
    //Listen to Auth State changes
    FirebaseAuth.instance
        .authStateChanges()
        .startWith(FirebaseAuth.instance.currentUser)
        .listen((event) => updateUserState(event));
  }

  //Updates state when user state changes in the app
  updateUserState(event) {
    setState(() {
      user = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null)
      //return LoginScreen();
    else if (user!.emailVerified)
      //return EditProfileScreen();
    else
      //return LoginScreen();
  }
}
