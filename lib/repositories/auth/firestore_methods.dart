import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:turisteando_ando/models/users/fotos.dart';
import 'package:turisteando_ando/models/users/marcadores.dart';
import 'package:turisteando_ando/models/users/rutaDestacada.dart';
import 'package:turisteando_ando/models/users/resenas.dart' as model;
import 'package:turisteando_ando/models/users/user.dart' as model;
import 'package:turisteando_ando/repositories/auth/storage_methods.dart';

class StoreMethods {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(Uint8List image, String path) async {
    UploadTask uploadTask = _storage.ref(path).putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

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

  Future<DocumentReference> review(
      {required idplace,
      required comentario,
      required calificacion,
      required fecha,
      required nombre,
      required List<Uint8List> files}) async {
    List<String> fotosUrls = []; // lista para almacenar las URL de las imágenes
    for (var file in files) {
      String fotoUrl = await uploadImage(file,
          'fotos/${_auth.currentUser!.uid}/$idplace/${DateTime.now().toIso8601String()}.jpg');
      fotosUrls.add(fotoUrl);
    }

    model.Review reviewUser = model.Review(
        idplace: idplace,
        comentario: comentario,
        calificacion: calificacion,
        fecha: fecha,
        fotos: fotosUrls);

    DocumentReference docRef = _firestore
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('reviews')
        .doc();

    await docRef.set(reviewUser.toJson());

    return docRef;
  }

  Map<String, dynamic> toJson() => {
        "uid": _auth.currentUser!.uid,
      };

  Future<List<String>> getReviews({required idplace}) async {
    DocumentSnapshot snap =
        await _firestore.collection('reviews').doc(idplace).get();
    if (snap.exists) {
      var snapshot = snap.data() as Map<String, dynamic>;
      return List<String>.from(snapshot['usuarios']);
    }
    return List.empty();
  }

  Future<List<model.Review>> getReviewsUsuarioPlace(
      {required idu, required idplace}) async {
    QuerySnapshot snaps = await _firestore
        .collection('usuarios')
        .doc(idu)
        .collection('reviews')
        .where('idplace', isEqualTo: idplace)
        .get();
    // From each document snapshot, convert to a Review object
    return snaps.docs.map((doc) => model.Review.formSnap(doc)).toList();
  }

  Future<model.User> getUser({required idu}) async {
    DocumentSnapshot snap =
        await _firestore.collection('usuarios').doc(idu).get();
    return model.User.formSnap(snap);
  }

  Future<List<Map<String, dynamic>>> getFAQS() async {
    try {
      List<Map<String, dynamic>> listaDatos = [];
      QuerySnapshot<Map<String, dynamic>> preguntasCollection =
          await _firestore.collection('preguntasFrecuentes').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> preguntas =
          preguntasCollection.docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> preguntaDocumento
          in preguntas) {
        listaDatos.add(preguntaDocumento.data());
      }
      return listaDatos;
    } catch (e) {
      print('Error al obtener faqs: $e');
      rethrow;
    }
  }

  Future<void> deleteReview(String id) async {
    try {
      _firestore
          .collection('usuarios')
          .doc(_auth.currentUser!.uid)
          .collection('reviews')
          .doc(id)
          .delete();
    } catch (e) {
      print('Error al obtener faqs: $e');
      rethrow;
    }
  }
}
