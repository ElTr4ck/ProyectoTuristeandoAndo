import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LugarDestacado {
  String nombre;
  String imagen;
  String id;
  String descripcion;
  LatLng coordenadas;

  LugarDestacado.fromFirestore(DocumentSnapshot doc)
      : nombre = doc['nombre'],
        imagen = doc['imagen'],
        descripcion = doc['descripcion'],
        coordenadas = LatLng(doc['coordenadas'].latitude, doc['coordenadas'].longitude),
        id = doc['id'];
}

Future<List<LugarDestacado>> obtenerDatos() async {
  final snapshot = await FirebaseFirestore.instance.collection('rutaDestacada').doc('Guanajuato').collection('lugares').get();
  final lugares = snapshot.docs.map((doc) => LugarDestacado.fromFirestore(doc)).toList();

  return lugares;
}

Future<void> marcarComoVisitado(String lugarId, String userId) {
  return FirebaseFirestore.instance.collection('usuarios').doc(userId).collection('lugares_visitados').doc(lugarId).set({'visitado': true});
}

/*Future<String> verificarRecompensa(List<LugarDestacado> lugares, String userId) async {
  if (lugares.every((lugar) => lugar.visitado)) {
    final doc = await FirebaseFirestore.instance.collection('rutaDestacada').doc('Guanajuato').get();
    final recompensa = doc['recompensa'];

    return recompensa;
  }
  else {
    return '';
  }
}*/

Future<DateTime> obtenerFechaInicio() async {
  final doc = await FirebaseFirestore.instance.collection('rutaDestacada').doc('Guanajuato').get();
  return (doc['fechaInicio'] as Timestamp).toDate();
}

//Obtener el campo nombreRuta del documento Guanajuato
Future<String> obtenerNombreRuta() async {
  final doc = await FirebaseFirestore.instance.collection('rutaDestacada').doc('Guanajuato').get();
  return doc['nombreRuta'];
}

Future<bool> verificarRecompensa(List<LugarDestacado> lugares) async {
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    for (var lugar in lugares) {
      var doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('ViajeCompleto')
          .doc(lugar.id) // Asegúrate de que 'id' es el campo correcto en tu objeto LugarDestacado
          .get();

      if (!doc.exists) {
        // Si alguno de los lugares no está en la colección 'ViajeCompleto', retorna false
        return false;
      }
    }

    // Si todos los lugares están en la colección 'ViajeCompleto', retorna true
    return true;
  } else {
    return false;
  }
}



