import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turisteando_ando/models/users/marcadores.dart';

class User {
  final String name;
  final String lastName;
  final String email;
  final String uid;
  final String photo;
  User({
    required this.name,
    required this.lastName,
    required this.email,
    required this.uid,
    required this.photo,
  });
  //json to object
  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastName,
        "emal": email,
        "uid": uid,
        "photo": photo,
      };
  static User formSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapshot['name'],
      lastName: snapshot['lastname'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      photo: snapshot['photos'],
    );
  }
}
