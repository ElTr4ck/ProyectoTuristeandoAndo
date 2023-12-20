import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turisteando_ando/screens/frmSetLocationINSIDE.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmwelcome_screen/frmwelcome_screen.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_container_screen/frminicio_container_screen.dart';

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
    if (user == null) {
      return FrmwelcomeScreen();
    } else {
      return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Muestra un indicador de carga mientras se espera la respuesta
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
          } else {
            if (snapshot.data!.data() is Map && (snapshot.data!.data() as Map).containsKey('nuevoUsuario') && (snapshot.data!.data() as Map)['nuevoUsuario'] == false) {
              return FrminicioContainerScreen();
            } else {
              return FrmSetLocation2();
            }
          }
        },
      );
    }
  }
} 