import 'package:cloud_firestore/cloud_firestore.dart';

class Foto {
  final String foto;
  //final String id;

  const Foto({required this.foto});
  //json to object
  Map<String, dynamic> toJson() => {
    "foto": foto,
  };
  static Foto formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Foto(
      foto: snapshot['foto'],
      //id: snapshot['id'],
    );
  }
}