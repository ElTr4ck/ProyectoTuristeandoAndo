import 'package:cloud_firestore/cloud_firestore.dart';

class Marcador {
  final GeoPoint point;
  final String nombre;

  const Marcador({this.point = const GeoPoint(0, 0), this.nombre = ""});
  //json to object
  Map<String, dynamic> toJson() => {
        "point": point,
        "nombre": nombre,
      };
  static Marcador formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Marcador(
      point: snapshot['point'],
    );
  }
}
