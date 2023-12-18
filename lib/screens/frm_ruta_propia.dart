import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pantallas/rutaUno.dart';

class FrmRutaPropia extends StatefulWidget {
  @override
  _FrmRutaPropiaState createState() => _FrmRutaPropiaState();
}

class _FrmRutaPropiaState extends State<FrmRutaPropia> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> lugares = [];
  bool generarRuta = false;

  @override
  void initState() {
    super.initState();
    fetchData(selectedDate);
  }

  Future<void> fetchData(DateTime date) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DateTime startOfDay = DateTime(date.year, date.month, date.day);
      DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      var docRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('itinerario')
          .where('fechaSeleccionado', isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('fechaSeleccionado', isLessThan: endOfDay.toIso8601String());
      try {
        var querySnapshot = await docRef.get();
        print('Documentos obtenidos: ${querySnapshot.docs.length}');
        List<String> placeIds = querySnapshot.docs
            .map((doc) => doc.data()['id'] as String? ?? 'ID predeterminado')
            .toList();
        List<String> fechas = querySnapshot.docs
            .map((doc) => doc.data()['fechaSeleccionado'] as String? ?? 'Fecha predeterminada')
            .toList();
        await fetchPlacesDetails(placeIds,fechas);
        // Pasar las fechas también
        print('IDs de lugares: $placeIds');
        print('IDs de lugares: $fechas');

      } catch (e) {
        print('Error al obtener datos de Firestore: $e');
      }
    }
  }

  String formatoFecha(String fechaIso){
    DateTime fecha = DateTime.parse(fechaIso);
    String formattedDate = DateFormat('yyyy-MM-dd').format(fecha);
    return formattedDate;
  }

  Future<void> fetchPlacesDetails(List<String> placeIds, List<String> fechas) async {
    List<Map<String, dynamic>> nuevosLugares = [];
    for (int i = 0; i < placeIds.length; i++) {
      String id = placeIds[i];
      String fecha = formatoFecha(fechas[i]); // Asumiendo que tienes una fecha correspondiente a cada ID
      try {
        Map<String, dynamic> placeDetails = await fetchPlaceDetailsFromApi(id);
        print('Detalles del lugar: $placeDetails');
        nuevosLugares.add({
          'nombre': placeDetails['title'] ?? 'Nombre no disponible',
          'fecha': fecha, // Aquí usas la fecha de Firestore
          'imagen': placeDetails['image'] ?? 'URL_imagen_por_defecto',
          'id': id,
        });
      } catch (e) {
        print('Error al obtener detalles del lugar: $e');
      }
    }
    setState(() {
      lugares = nuevosLugares;
      print('Lugares actualizados: $lugares');
    });
  }
  Future<Map<String, dynamic>> fetchPlaceDetailsFromApi(String placeId) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data['result'];

      // Obteniendo el nombre y la calificación del lugar
      String title = result['name']; // Nombre del lugar
      // Construyendo la descripción con la calificación

      // URL de la imagen del lugar
      String imageUrl = result['photos'] != null
          ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${result['photos'][0]['photo_reference']}&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM'
          : 'URL_imagen_por_defecto';
      return {
        'title': title,
        'image': imageUrl
      };
    } else {
      return {
        'title': 'Información no disponible',
        'image': 'url_de_imagen_por_defecto'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Mis rutas',
                style: TextStyle(fontFamily: 'Monserrat', fontSize: 32),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Añade lugares a tu ruta, agenda el día y te generaremos tu ruta personalizada',
                style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            Fecha(
              selectedDate: selectedDate,
              onDateSelected: (newDate) {
                setState(() {
                  selectedDate = newDate;
                });
                fetchData(newDate);
              },
            ),
            const Text(
              'Tus lugares añadidos a la ruta:',
              style: TextStyle(fontFamily: 'Monserrat', fontSize: 20),
            ),
            Expanded(
              child: Visor(
                  lugares: lugares,
                  state: this,
              ),
            ),
            BotonesInf(ancho: ancho, selectedDate: selectedDate),
          ],
        ),
      ),
    );
  }
}

class Fecha extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  Fecha({Key? key, required this.selectedDate, required this.onDateSelected}) : super(key: key);

  @override
  _FechaState createState() => _FechaState();
}
class _FechaState extends State<Fecha> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              'Fecha prevista para esta ruta:',
              style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w300),
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: widget.selectedDate,
                firstDate: DateTime(widget.selectedDate.year - 10),
                lastDate: DateTime(widget.selectedDate.year + 10),
                // Asegúrate de que tu localización del dispositivo esté en español o establece manualmente la localización
                locale : const Locale("es","ES"),
              );
              if (picked != null && picked != widget.selectedDate) {
                widget.onDateSelected(picked);
              }
            },
            icon: Icon(Icons.calendar_today),
            label: Text("${widget.selectedDate.toLocal()}".split(' ')[0]),
          ),
        ],
      ),
    );
  }
}

class Visor extends StatelessWidget {
  final List<Map<String, dynamic>> lugares;

  // Pasamos una referencia al estado del widget FrmRutaPropia
  final _FrmRutaPropiaState state;

  Visor({Key? key, required this.lugares, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: lugares.map((lugar) {
          return Tarjeta(
            url: lugar['imagen'],
            nombre: lugar['nombre'],
            fecha: lugar['fecha'],
            id: lugar['id'],
            state: state, // Pasar el estado a Tarjeta
          );
        }).toList(),
      ),
    );
  }
}

class Tarjeta extends StatelessWidget {
  final String url;
  final String nombre;
  final String fecha;
  final String id;

  // Pasamos una referencia al estado del widget FrmRutaPropia
  final _FrmRutaPropiaState state;

  Tarjeta({
    Key? key,
    required this.url,
    required this.nombre,
    required this.fecha,
    required this.id,
    required this.state, // Nuevo parámetro
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(url, width: 80),
            Column(
              children: [
                Text(nombre),
                Text('Añadido el $fecha'),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await eliminarLugar(id);
                        state.fetchData(state.selectedDate); // Actualizar la lista después de eliminar un lugar
                      },
                      icon: Icon(Icons.delete_outline_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        mostrarDatePickerYEditarFecha(context, id);
                      },
                      icon: Icon(Icons.access_time_rounded),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Hecho(itemId: id),
                    HeartButtonV2(itemId: id),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> editarFechaItinerario(String lugarId, String nuevaFecha) async {
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    var docRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('itinerario')
        .doc(lugarId);
    try {
      await docRef.update({
        'fechaSeleccionado': nuevaFecha, // nuevaFecha ya debe ser una cadena en formato ISO 8601
      });
      print('Fecha del itinerario actualizada con éxito');
    } catch (e) {
      print('Error al actualizar la fecha del itinerario: $e');
    }
  } else {
    print('Usuario no autenticado');
  }
}
Future<void> mostrarDatePickerYEditarFecha(BuildContext context, String lugarId) async {
  final DateTime? fechaSeleccionada = await showDatePicker(
    context: context, // Aquí se pasa el BuildContext correcto
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (fechaSeleccionada != null) {
    String fechaIso = fechaSeleccionada.toIso8601String();
    await editarFechaItinerario(lugarId, fechaIso);

    // Actualizar la lista después de cambiar la fecha
    final _FrmRutaPropiaState? state = context.findAncestorStateOfType<_FrmRutaPropiaState>();
    if (state != null) {
      state.fetchData(state.selectedDate);
    }
  }
}

Future<void> eliminarLugar(String id) async {
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    var docRef = FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .collection('itinerario')
        .doc(id);

    try {
      await docRef.delete();
      print('Lugar eliminado con éxito.');
    } catch (e) {
      print('Error al eliminar lugar de Firestore: $e');
    }
  }
}

class HeartButtonV2 extends StatefulWidget {
  final String itemId;
  HeartButtonV2({required this.itemId});

  @override
  _HeartButtonStateV2 createState() => _HeartButtonStateV2();
}
class _HeartButtonStateV2 extends State<HeartButtonV2> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorited();
  }

  void checkIfFavorited() async {
    // Lógica para verificar si el ítem está en los favoritos del usuario
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('favoritos')
          .doc(widget.itemId)
          .get();

      setState(() {
        isFavorited = doc.exists;
      });
    }
  }

  void toggleFavorite() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var docRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('favoritos')
          .doc(widget.itemId);

      if (isFavorited) {
        // Si ya es favorito, eliminar de la base de datos
        await docRef.delete();
      } else {
        // Si no es favorito, agregar a la base de datos
        await docRef.set({'id': widget.itemId});
      }

      setState(() {
        isFavorited = !isFavorited;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2), // Espaciado entre el borde y el ícono
      child: IconButton(
        icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
        color: isFavorited ? Colors.red : Colors.black87, // Color del icono según el estado
        onPressed: toggleFavorite, // Llamada a la función para cambiar el estado
        iconSize: 27.0, // Tamaño del icono
      ),
    );
  }
}

class Hecho extends StatefulWidget {
  final String itemId;
  Hecho({required this.itemId});

  @override
  _Hecho createState() => _Hecho();
}
class _Hecho extends State<Hecho> {
  bool isAcompletado = false;

  @override
  void initState() {
    super.initState();
    checkIfAcompletado();
  }

  void checkIfAcompletado() async {
    // Lógica para verificar si el ítem está en los favoritos del usuario
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('ViajeCompleto')
          .doc(widget.itemId)
          .get();

      setState(() {
        isAcompletado = doc.exists;
      });
    }
  }

  void toggleFavorite() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var docRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('ViajeCompleto')
          .doc(widget.itemId);

      if (isAcompletado) {
        // Si ya es favorito, eliminar de la base de datos
        await docRef.delete();
      } else {
        // Si no es favorito, agregar a la base de datos
        await docRef.set({'id': widget.itemId});
      }

      setState(() {
        isAcompletado = !isAcompletado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2), // Espaciado entre el borde y el ícono
      child: IconButton(
        icon: Icon(isAcompletado ? Icons.check_box_outlined : Icons.check_box_outlined),
        color: isAcompletado ? Colors.blue : Colors.black87, // Color del icono según el estado
        onPressed: toggleFavorite, // Llamada a la función para cambiar el estado
        iconSize: 27.0, // Tamaño del icono
      ),
    );
  }
}

class BotonesInf extends StatelessWidget {
  final double ancho;
  final DateTime selectedDate;
  const BotonesInf({Key? key, required this.ancho, required this.selectedDate,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 10,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: const Color.fromRGBO(17, 76, 95, 1),
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>RutaUno(predictionDescription: 'Cambio de pantalla',selectedDate: selectedDate,generarRuta: true,)),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ancho*0.33, vertical: 10),
                child: const Text('Generar Ruta', style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontSize: 15,
                )),
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: const Color.fromRGBO(242, 230, 207, 1),
            child: InkWell(
              onTap: () async{
                //await Share.share('Hola', subject: 'Prueba');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ancho*0.101, vertical: 10),
                child: const Text('Compartir', style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                )),
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: const Color.fromRGBO(242, 230, 207, 1),
            child: InkWell(
              onTap: (){},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ancho*0.101, vertical: 10),
                child: const Text('Buscar sugerencias', style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}