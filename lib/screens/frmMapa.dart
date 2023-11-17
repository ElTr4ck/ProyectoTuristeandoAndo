import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:turisteando_ando/screens/frmSetLocation.dart';
import 'package:google_maps_webservice/places.dart';



final GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM");
void main() {
  runApp(frmMapa());
}

class frmMapa extends StatefulWidget {
  @override
  _frmMapaState createState() => _frmMapaState();
}

class _frmMapaState extends State<frmMapa> {
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng _currentLocation = LatLng(-34.603722, -58.381592);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    try {
      _getCurrentLocation();
    } catch (e) {
      if (kDebugMode) {
        print("Error durante mapa");
      }
    }
  }

  void _getCurrentLocation() async {
    try {
      LatLng currentLocation = await Localizador().getCurrentLocation();
      setState(() {
        _currentLocation = currentLocation;
        _markers.add(Marker(markerId: MarkerId("currentLocation"),
        position: currentLocation,
        infoWindow: InfoWindow(title: "Mi Ubicacion"),));
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error al obtener la ubicación");
      }
    }
  }

  Future<List<String?>> _getAutocompleteSuggestions(String input) async {
    try {
      if (input.isEmpty) {
        return [];
      }

      final response = await places.autocomplete(input);
      if (response.isOkay && response.predictions.isNotEmpty) {
        return response.predictions.map((p) => p.description).toList();
      } else {
        return [];
      }
    } catch (e) {
      // Manejo de la excepción
      if (kDebugMode) {
        print('Error al obtener sugerencias de autocompletado:');
      }
      return [];
    }
  }

  List<String> _autocompleteSuggestions = [];
  final Set<Marker> _markers={};

  void _searchPlace(String placeName) async {
    print("BUSQUEDAA");
    try {
      PlacesSearchResponse response = await places.searchByText(placeName);

      if (_mapController == null) {
        print("El controlador del mapa no está disponible.");
        return;
      }
      if (response.status == "OK" && response.results.isNotEmpty) {
        PlacesSearchResult place = response.results.first;

        LatLng newLocation = LatLng(place.geometry!.location.lat, place.geometry!.location.lng);
        setState(() {
          _currentLocation = newLocation;
          _markers.clear();
          _markers.add(
            Marker(
                markerId: const MarkerId("Ubicacion"),
                position: newLocation,
                infoWindow: InfoWindow(title: place.name),
            )
          );
         _mapController!.animateCamera(
            CameraUpdate.newLatLng(newLocation),
          )
              .then((Result) {
            print("Camara Bien");
          }).catchError((e) {
            if (kDebugMode) {
              print("Error en camara");
            }
          });
        });
      } else {
        //errores
        print('No se encontraron lugares');
      }
    } catch (e) {
      print('Error al interactuar con el mapa');
      // Manejo adicional del error aquí
    }
  }

  void _onSearchChanged(String value) async {
    var suggestions = await _getAutocompleteSuggestions(value);
    setState(() {
      _autocompleteSuggestions = suggestions.whereType<String>().toList();
    });
  }


  void _handleLongPress(LatLng position){
    setState(() {
      _currentLocation = position;
      _markers.clear();
      _markers.add(
        Marker(
            markerId: const MarkerId("newMarker"),
            position: position,
            infoWindow: const InfoWindow(title: "Ubicacion"),
        )
      );
        _mapController!.animateCamera(

          CameraUpdate.newLatLng(position),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            // Mapa Google
            FutureBuilder<LatLng>(
                future: Localizador().getCurrentLocation(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Esperando la ubicación actual
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Error en la obtención de la ubicación
                  } else {
                    LatLng currentLocation = snapshot.data!;
                    return GoogleMap(
                      onMapCreated: _onMapCreated,
                      mapType: MapType.terrain,
                      initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 17),
                      markers: _markers,
                      onLongPress: _handleLongPress,
                      myLocationEnabled: true,
                      myLocationButtonEnabled:false,
                    );
                  }
                }),
            // Barra de búsqueda
            Column(
              children: <Widget>[
                Container(
                  color: Colors.white.withOpacity(0.5),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 18, 0, 5),
                            child: Text(
                              '¿Qué deseas hacer el día de hoy?',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito'),
                            ),
                          )),
                      const SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Sugerencia: Buscar museos cercanos',
                            prefixIcon:
                                Icon(Icons.search, color: Color(0xFF114C5F)),
                            border: InputBorder.none,
                          ),
                          onChanged: _onSearchChanged,
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _autocompleteSuggestions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.zero,
                              child: Container(
                                decoration: const BoxDecoration(
                                ),
                                child: ListTile(
                                  title: Text(
                                    _autocompleteSuggestions[index],
                                    style: const TextStyle(
                                      fontSize: 14, //Letra tamaño
                                      color: Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    _searchPlace(
                                        _autocompleteSuggestions[index]);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

