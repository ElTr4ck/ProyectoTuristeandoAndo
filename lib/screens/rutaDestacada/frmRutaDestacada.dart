import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/frm_ruta_propia.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/models/rutaDestacada/rutaDestacadaModel.dart';

ValueNotifier<bool> checkButtonNotifier = ValueNotifier<bool>(false);

class FrmRutaDestacada extends StatelessWidget {
  const FrmRutaDestacada({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Ruta destacada',
                style: TextStyle(
                  fontFamily: 'Monserrat',
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'Completa la ruta destacada de este mes para ganar recompensas canjeables',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w100),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Tiempo restante: ',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
                FutureBuilder<DateTime>(
                  future: obtenerFechaInicio(),
                  builder: (context, snapshotFechaInicio) {
                    if (snapshotFechaInicio.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshotFechaInicio.hasError) {
                      return Text('Error: ${snapshotFechaInicio.error}');
                    } else {
                      final fechaFin = snapshotFechaInicio.data!
                          .add(const Duration(days: 30));
                      return Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: StreamBuilder(
                            stream: Stream.periodic(
                                const Duration(seconds: 1), (i) => i),
                            builder: (context, snapshot) {
                              final duracion =
                                  fechaFin.difference(DateTime.now());
                              final dias = duracion.inDays;
                              final horas = duracion.inHours % 24;
                              final minutos = duracion.inMinutes % 60;
                              final segundos = duracion.inSeconds % 60;

                              return Text(
                                '${dias}d${horas}h${minutos}m${segundos}s',
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            //Titulo de 'RUTA MENSUAL
            FutureBuilder(
                future: obtenerNombreRuta(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Container(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, bottom: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Ruta mensual: ${snapshot.data}',
                        style: CustomTextStyles.titleLargeNunito,
                        textAlign: TextAlign.left,
                      ),
                    );
                  }
                }),

            //TARJETAS DE LUGAR
            Expanded(
              child: FutureBuilder<List<LugarDestacado>>(
                future: obtenerDatos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: snapshot.data!
                          .map((lugar) => PlaceCardDestacada(lugar: lugar))
                          .toList(),
                    );
                  }
                },
              ),
            ),
            FutureBuilder<List<LugarDestacado>>(
              future: obtenerDatos(), // Tu función que devuelve Future<List<LugarDestacado>>
              builder: (BuildContext context, AsyncSnapshot<List<LugarDestacado>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Muestra un indicador de carga mientras se espera la respuesta
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
                } else {
                  return CustomElevatedButton(
                    text: 'Agendar ruta completa',
                    buttonStyle: CustomButtonStyles.fillPrimaryTL22,
                    buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
                    margin: EdgeInsets.only(top: 20, left: 25.h, right: 25.h),
                    height: 40.v,
                    onPressed: () async {
                      DateTime hoy = DateTime.now();
                      DateTime? it = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(17, 76, 95, 1)
                              ),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: hoy,
                        firstDate: DateTime(hoy.year - 10),
                        lastDate: DateTime(hoy.year + 10),
                      );
                      if (it != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FrmRutaPropia(it)
                        ));
                        guardarEnItinerario(snapshot.data!, it,); // Pasa la lista de lugares destacados a guardarEnItinerario
                      }
                    },
                  );
                }
              },
            ),
            FutureBuilder<List<LugarDestacado>>(
              future: obtenerDatos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Muestra un mensaje de error si algo sale mal
                } else {
                  final lugares = snapshot.data;
                  return BtnCajeaRecompensa(lugares: lugares!);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

//TARJETAS DE LA RUTA ESTACADA
class PlaceCardDestacada extends StatelessWidget {
  final LugarDestacado lugar;

  const PlaceCardDestacada({required this.lugar, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 247, 249, 248),
      ),
      height: 100,
      width: MediaQuery.of(context).size.width - 40,
      //Contenido dentro de la tarjeta
      child: Row(
        children: [
          //Imagen de la tarjeta
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: 49,
              height: 49,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    lugar.imagen,
                    fit: BoxFit.cover,
                    height: 49,
                    width: 49,
                  )),
            ),
          ),
          //Textis de la tarjeta
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            width: MediaQuery.of(context).size.width - 115,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          lugar.nombre,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 18,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BtnVisitado(
                      itemId: lugar.id,
                    ), // Ajusta el espacio horizontal aquí
                    BtnMarcadores(itemId: lugar.id),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 280,
                    child: Text(
                      lugar.descripcion,
                      style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Color.fromARGB(255, 122, 144, 138)),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BtnVisitado extends StatefulWidget {
  final String itemId;
  BtnVisitado({required this.itemId});

  @override
  _BtnVisitadoState createState() => _BtnVisitadoState();
}

class _BtnVisitadoState extends State<BtnVisitado> {
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

      // Actualiza el valor del ValueNotifier
      checkButtonNotifier.value = isAcompletado;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isAcompletado ? Icons.check_box : Icons.check_box_outlined),
      color: isAcompletado
          ? Colors.green
          : Colors.black87, // Color del icono según el estado
      onPressed: toggleFavorite, // Llamada a la función para cambiar el estado
      iconSize: 27.0, // Tamaño del icono
    );
  }
}

class BtnMarcadores extends StatefulWidget {
  final String itemId;
  BtnMarcadores({required this.itemId});

  @override
  _BtnMarcadoresState createState() => _BtnMarcadoresState();
}

class _BtnMarcadoresState extends State<BtnMarcadores> {
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
    return IconButton(
      icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
      color: isFavorited
          ? Colors.red
          : Colors.black87, // Color del icono según el estado
      onPressed: toggleFavorite, // Llamada a la función para cambiar el estado
      iconSize: 27.0, // Tamaño del icono
    );
  }
}

class BtnCajeaRecompensa extends StatefulWidget {
  //Crear el constructor con el parametro de la lista de lugares
  List<LugarDestacado> lugares;
  BtnCajeaRecompensa({required this.lugares});
  @override
  _BtnCajeaRecompensaState createState() =>
      _BtnCajeaRecompensaState(lugares: lugares);
}

class _BtnCajeaRecompensaState extends State<BtnCajeaRecompensa> {
  List<LugarDestacado> lugares;
  _BtnCajeaRecompensaState({required this.lugares});
  late Future<bool> verificarRecompensaFuture;

  @override
  void initState() {
    super.initState();
    verificarRecompensaFuture = verificarRecompensa(lugares);
    checkButtonNotifier.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    checkButtonNotifier.removeListener(_updateButtonState);
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      verificarRecompensaFuture = verificarRecompensa(lugares);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: verificarRecompensaFuture,
      builder: (context, snapshot) {
        bool isDisabled = true;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Maneja el error como desees
            print('Error: ${snapshot.error}');
          } else {
            isDisabled = !snapshot.data!;
          }
        }

        return CustomElevatedButton(
          text: 'Canjear recompensa',
          buttonStyle: CustomButtonStyles.fillTealTL16,
          isDisabled: isDisabled,
          buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
          margin: EdgeInsets.only(top: 5, left: 25.h, right: 25.h),
          height: 40.v,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    '¡Aqui tienes tu recompensa!',
                    textAlign: TextAlign.center,
                  ),
                  content: Center(
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Column(
                        children: [
                          QrImageView(
                            //obtener la data desde el campo de recompensa de la BD
                            data:
                                'https://youtu.be/T1S6ZlzLyGs?si=dKX5nBVzomBJRmvf',
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Escanea el código QR para obtener un descuento del 20% en restaurantes de: “La casa de Toño” ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w100),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    CustomElevatedButton(
                      text: '¡Lo tengo!',
                      buttonStyle: CustomButtonStyles.fillPrimaryTL16,
                      buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
                      margin: EdgeInsets.only(top: 5),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

Future<void> guardarEnItinerario(List<LugarDestacado> lugares, DateTime sel) async {
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    var fechaActual = sel; // Obtiene la fecha y hora actual
    for (var lugar in lugares) {
      var docRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('itinerario')
          .doc(lugar.id);
      try {
        var doc = await docRef.get();
        if (!doc.exists) {
          await docRef.set({
            'id': lugar.id,
            'fechaSeleccionado':
                DateTime(fechaActual.year, fechaActual.month, fechaActual.day)
                    .toIso8601String()
          });
          print('Lugar guardado con éxito en el itinerario');
        } else {
          print('El lugar ya está en el itinerario');
        }
      } catch (e) {
        print('Error al guardar en el itinerario: $e');
      }
    }
  } else {
    print('Usuario no autenticado');
  }
}
