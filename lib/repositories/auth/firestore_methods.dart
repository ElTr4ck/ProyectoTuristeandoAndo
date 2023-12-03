import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turisteando_ando/models/users/marcadores.dart';
import 'package:turisteando_ando/models/users/rutaDestacada.dart';

class StoreMethods {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> macador({required point, required nombre}) async {
    Marcador marcador = Marcador(point: point, nombre: nombre);
    await _firestore
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('marcadores')
        .doc(nombre)
        .set(marcador.toJson());
  }

  Future<void> rudaDestacada(
      {required fechaInicio,
      required nombre,
      required id,
      required recompensa}) async {
    RutaDestacada ruta = RutaDestacada(
        fechaInicio: fechaInicio,
        nombre: nombre,
        id: id,
        recompensa: recompensa);
    await _firestore
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('rutaDestacada')
        .doc(id)
        .set(ruta.toJson());
  }
}
