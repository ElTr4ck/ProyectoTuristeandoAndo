import 'package:cloud_firestore/cloud_firestore.dart';

class Marcador {
  final String x;
  final String y;
  const Marcador({
    required this.x,
    required this.y,
  });
  //json to object
  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
  static Marcador formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Marcador(
      x: snapshot['x'],
      y: snapshot['y'],
    );
  }
}
