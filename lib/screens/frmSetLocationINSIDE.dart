import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turisteando_ando/blocs/geolocation/geolocation_bloc.dart';
import 'package:turisteando_ando/blocs/place/place_bloc.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/frmCuestionario.dart';
import 'package:turisteando_ando/widgets/barraBusquedaUbicacion.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/gmap.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_page/frminicio_page.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:http/http.dart' as http;
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class FrmSetLocation2 extends StatefulWidget {
  const FrmSetLocation2({super.key});

  @override
  State<FrmSetLocation2> createState() => _FrmSetLocationState();
}

class _FrmSetLocationState extends State<FrmSetLocation2> {
  bool isButtonEnabled = false;
  late Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  LatLng _currentLocation = LatLng(0, 0);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Modifica tu ubicación'),
          titleTextStyle: CustomTextStyles.titleMediumOnPrimary17,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          backgroundColor: const Color.fromARGB(255, 20, 76, 95),
        ),
        body: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            if (state is PlaceLoading) {
              return Stack(
                children: [
                  //Mapa de google con geolocalizacion
                  BlocBuilder<GeolocationBloc, GeolocationState>(
                    builder: (context, state) {
                      if (state is GeolocationLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GeolocationLoaded) {
                        return Gmap(
                          lat: state.position.latitude,
                          lng: state.position.longitude,
                          markers: _markers,
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                          addMarker: _addMarker,
                        );
                      } else {
                        return const Text('Algo ha salido mal');
                      }
                    },
                  ),

                  //Barra de busqueda con autocompletado
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      // Ajusta la opacidad y el color del fondo difuminado
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.2))
                      ], // Efecto de desenfoque
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 8), // Espacio interno
                        Container(
                          alignment: Alignment.center,
                          // Centrar horizontal y verticalmente
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        placesAutoCompleteTextField(),
                      ],
                    ),
                  ),
                  //Botoneras
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //Logica para la geolocalizacion
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: 20.h, bottom: 20.h),
                              padding: const EdgeInsets.all(11),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: const Icon(
                                Icons.my_location,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                          CustomElevatedButton(
                            height: 41.v,
                            text: "Aceptar",
                            margin: EdgeInsets.only(
                                left: 30.h, right: 20.h, bottom: 10.h),
                            buttonStyle: CustomButtonStyles.fillPrimary,
                            buttonTextStyle:
                                CustomTextStyles.titleMediumOnPrimary17,
                            onPressed: isButtonEnabled
                                ? () async {
                                    // Deshabilita el botón después de la acción
                                    setState(() {
                                      isButtonEnabled = false;
                                    });
                                    User? user =
                                        FirebaseAuth.instance.currentUser;
                                    DocumentSnapshot userDoc =
                                        await FirebaseFirestore.instance
                                            .collection('usuarios')
                                            .doc(user!.uid)
                                            .get();
                                    if (userDoc.data() is Map &&
                                        (userDoc.data() as Map)
                                            .containsKey('nuevoUsuario') &&
                                        (userDoc.data()
                                                as Map)['nuevoUsuario'] ==
                                            false) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return FrminicioPage();
                                        }),
                                      );
                                    } else {
                                      await FirebaseFirestore.instance
                                          .collection('usuarios')
                                          .doc(user.uid)
                                          .set({'nuevoUsuario': false},
                                              SetOptions(merge: true));

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                          return FrmCuestionario();
                                        }),
                                      );
                                    }
                                  }
                                : null,
                          ),
                          CustomElevatedButton(
                              height: 41.v,
                              text: "Usar mi ubicación actual",
                              margin: EdgeInsets.only(
                                  left: 30.h, right: 20.h, bottom: 10.h),
                              buttonStyle: CustomButtonStyles.fillTeal,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumOnPrimary17,
                              onPressed: () async {
                                Position position = await _determinePosition();
                                LatLng ubicacion = LatLng(
                                    position.latitude, position.longitude);
                                _loadUbicacion(ubicacion);
                                User? user = FirebaseAuth.instance.currentUser;

                                DocumentSnapshot userDoc =
                                    await FirebaseFirestore.instance
                                        .collection('usuarios')
                                        .doc(user!.uid)
                                        .get();
                                if (userDoc.data() is Map &&
                                    (userDoc.data() as Map)
                                        .containsKey('nuevoUsuario') &&
                                    (userDoc.data() as Map)['nuevoUsuario'] ==
                                        false) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return FrminicioPage();
                                    }),
                                  );
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection('usuarios')
                                      .doc(user.uid)
                                      .set({'nuevoUsuario': false},
                                          SetOptions(merge: true));

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return FrmCuestionario();
                                    }),
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is PlaceLoaded) {
              return Stack(
                children: [
                  //Mapa de google sin geolocalizacion, con el place cargado
                  Gmap(
                    lat: state.place.lat,
                    lng: state.place.lon,
                    markers: _markers,
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    addMarker: _addMarker,
                  ),

                  //Barra de busqueda con autocompletado
                  BarraBusquedaUbicacion(),
                  //Botoneras
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //Regresar al evento de placeLoading
                              context
                                  .read<PlaceBloc>()
                                  .add(const LoadGeoPlace());
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: 20.h, bottom: 20.h),
                              padding: const EdgeInsets.all(11),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: const Icon(
                                Icons.my_location,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                          CustomElevatedButton(
                              height: 41.v,
                              text: "Aceptar",
                              margin: EdgeInsets.only(
                                  left: 30.h, right: 20.h, bottom: 10.h),
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumOnPrimary17,
                              onPressed: () async {
                                User? user = FirebaseAuth.instance.currentUser;

                                DocumentSnapshot userDoc =
                                    await FirebaseFirestore.instance
                                        .collection('usuarios')
                                        .doc(user!.uid)
                                        .get();
                                if (userDoc.data() is Map &&
                                    (userDoc.data() as Map)
                                        .containsKey('nuevoUsuario') &&
                                    (userDoc.data() as Map)['nuevoUsuario'] ==
                                        false) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return FrminicioPage();
                                    }),
                                  );
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection('usuarios')
                                      .doc(user.uid)
                                      .set({'nuevoUsuario': false},
                                          SetOptions(merge: true));

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return FrmCuestionario();
                                    }),
                                  );
                                }
                              }),
                          CustomElevatedButton(
                              height: 41.v,
                              text: "Usar mi ubicación actual",
                              margin: EdgeInsets.only(
                                  left: 30.h, right: 20.h, bottom: 10.h),
                              buttonStyle: CustomButtonStyles.fillTeal,
                              buttonTextStyle:
                                  CustomTextStyles.titleMediumOnPrimary17,
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Algo ha salido mal :(');
            }
          },
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      color: Colors.transparent,
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM",
        inputDecoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: '¡Puede ser una dirección o un lugar en específico!',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Nunito',
            fontStyle: FontStyle.italic,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            // Agrega este bloque para el border general
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),

          fillColor: Colors.white,
          // Ajusta el color del fondo según tus necesidades
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),

        debounceTime: 400,
        countries: ["mx"],
        isLatLngRequired: false,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print("placeDetails" + prediction.lat.toString());
        },

        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
          fetchData(prediction.description as String);
          /*Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            //String aux = '${prediction.lat}, ${prediction.lng}';
            return MyApp(prediction.description as String);
          }));*/
        },
        seperatedBuilder: Divider(
          color: Colors.transparent,
        ),
        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                Container(
                  width: 7,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }

  void _updateCameraPosition(LatLng location) {
    // Mover la cámara
    if (_mapController != null) {
      _mapController.animateCamera(CameraUpdate.newLatLng(location));
    }

    // Añadir un marcador en el nuevo lugar
    _addMarker(location);

    // Actualizar la posición de la cámara
    setState(() {
      _currentLocation = location;
    });
  }

  void _addMarker(LatLng location) {
    setState(() {
      _markers.clear(); // Limpiamos los marcadores existentes
      _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
      ));
    });

    // También puedes centrar la cámara en el nuevo marcador si lo deseas
    //_updateCameraPosition(location);
  }

  Future<void> fetchData(data) async {
    LatLng defaults = LatLng(0, 0);
    // Tu lógica para obtener datos desde la API
    String dataloc = data;
    String url = 'https://places.googleapis.com/v1/places:searchText';
    // Los datos que enviarás en el cuerpo de la solicitud POST

    print(dataloc);
    // Las cabeceras de la solicitud
    Map<String, dynamic> requestData = {"textQuery": "$data"};
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM',
      // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask': 'places.location',
    };

    // Realiza la solicitud POST
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestData),
        headers: headers,
      );
      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta aquí
        print('Respuesta exitosa: ${response.body}');
        Map<String, dynamic> jsonData = json.decode(response.body);
        //String aux = '${prediction.lat}, ${prediction.lng}';
        double lat =
            double.parse('${jsonData["places"][0]["location"]["latitude"]}');
        //print('${jsonData["places"][0]["location"]["longitude"]}');
        double lon =
            double.parse('${jsonData["places"][0]["location"]["longitude"]}');
        defaults = LatLng(lat, lon);
        _loadUbicacion(defaults);
        _updateCameraPosition(defaults);
        //print('${jsonData["places"][0]["displayName"]["text"]}');
        //print('${jsonData["places"][0]["formattedAddress"]}');
      } else {
        // Hubo un error en la solicitud, puedes manejarlo aquí
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      // Maneja las excepciones que puedan ocurrir durante la solicitud
      print('Error: $e');
    }
  }

  void _loadUbicacion(LatLng ubica) async {
    final _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    print(ubica);

    DocumentReference docRef = _firestore
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('Ubicacion')
        .doc('ubicacion_actual'); // Cambiado a un nombre más descriptivo

    // Actualizar o establecer los datos del documento
    await docRef.set({
      'latitud': ubica.latitude,
      'longitud': ubica.longitude,
      // Otros campos que desees almacenar
    });

    print('Ubicación guardada con éxito.');
    setState(() {
      isButtonEnabled = true;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
