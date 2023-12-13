import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> obtenerNombreUsuarioActual() async {
  final usuarioActual = FirebaseAuth.instance.currentUser;
  if (usuarioActual == null) {
    throw Exception('No hay usuario logueado');
  }

  final usuarioDoc = await FirebaseFirestore.instance.collection('usuarios').doc(usuarioActual.uid).get();
  return usuarioDoc.get('name') + ' ' + usuarioDoc.get('lastname');
}

//Obtener la imagen almacenada en la base de datos como un string
Future<String> obtenerImagenUsuarioActual() async {
  final usuarioActual = FirebaseAuth.instance.currentUser;
  if (usuarioActual == null) {
    throw Exception('No hay usuario logueado');
  }

  final usuarioDoc = await FirebaseFirestore.instance.collection('usuarios').doc(usuarioActual.uid).get();
  return usuarioDoc.get('photo');
}