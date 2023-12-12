import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turisteando_ando/models/users/marcadores.dart';

class RutaDestacada {
  final Timestamp fechaInicio;
  final String nombre;
  final String id;
  final String recompensa;
  RutaDestacada({
    required this.fechaInicio,
    required this.nombre,
    required this.id,
    required this.recompensa,
  });
  //json to object
  Map<String, dynamic> toJson() => {
        "fechaInicio": fechaInicio,
        "nombre": nombre,
        "id": id,
        "recompensa": recompensa,
      };
  static RutaDestacada formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return RutaDestacada(
      fechaInicio: snapshot['fechaInicio'],
      nombre: snapshot['nombre'],
      id: snapshot['id'],
      recompensa: snapshot['recompensa'],
    );
  }
}
