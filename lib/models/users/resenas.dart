import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turisteando_ando/models/users/fotos.dart';
import 'package:turisteando_ando/models/users/user.dart' as model;

class Review {
  final String idplace;
  final String comentario;
  final int calificacion;
  final Timestamp fecha;
  final List<String>? fotos;
  final String? idu;

  const Review(
      {required this.idplace,
      required this.comentario,
      required this.calificacion,
      required this.fecha,
      this.fotos,
      this.idu});
  //json to object
  Map<String, dynamic> toJson() => {
        "idplace": idplace,
        "comentario": comentario,
        "calificacion": calificacion,
        "fecha": fecha,
        "fotos": fotos,
        "idu": idu
      };
  static Review formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Review(
        idplace: snapshot['idplace'],
        comentario: snapshot['comentario'],
        calificacion: snapshot['calificacion'],
        fecha: snapshot['fecha'],
        fotos: List<String>.from(snapshot['fotos']),
        idu: snapshot['idu']);
  }
}
