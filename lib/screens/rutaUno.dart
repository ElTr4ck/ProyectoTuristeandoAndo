
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui';

import 'package:google_maps_widget/google_maps_widget.dart';

import 'frmSetLocation.dart';

final GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM");

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turisteando Ando',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: 'rutaNav',
      routes: {'rutaNav': (_) => RutaUno()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SelectLocationScreen extends StatefulWidget{
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen>{
  LatLng _currentLocation = LatLng(0, 0);
  final TextEditingController _searchController = TextEditingController();
  Set<Marker> _markers ={};
  GoogleMapController? _mapController;

  void initState() {
    super.initState();
    _determinePosition();
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación no están habilitados, no podemos obtener la ubicación.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Los permisos están denegados.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Los permisos están permanentemente denegados.
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _updateCameraPosition(LatLng(position.latitude, position.longitude));
  }

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

  // Este método actualiza la cámara del mapa para centrarse en la nueva ubicación.
  void _updateCameraPosition(LatLng location) {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(location));
    }
    setState(() {
      _currentLocation = location;
      _markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: location,
        infoWindow: InfoWindow(title: 'Tu Ubicación Actual'),
      ));
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

  void _selectLocation(LatLng location) {
    setState(() {
      _currentLocation = location;
    });
    // Aquí también puedes cerrar la pantalla y pasar la ubicación seleccionada de vuelta
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecciona una Ubicación"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:TextField(
             controller: _searchController,
             decoration: InputDecoration(
               hintText: 'Buscar lugar',
               suffixIcon: IconButton(
                 icon: Icon(Icons.search),
                 onPressed: (){
                   _searchPlace(_searchController.text);
                 },
               ),
             ),
             onSubmitted: _searchPlace,
            )
          ),
          Expanded(child:
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            onTap: _selectLocation,
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0), // Posición inicial, podría ser la ubicación actual
              zoom: 14,
            ),
            markers: _markers,
            onLongPress: _handleLongPress,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
          )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentLocation != null) {
            Navigator.pop(context, _currentLocation);
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class RutaUno extends StatefulWidget{
  _RutaUnoState createState() =>_RutaUnoState();
}

class _RutaUnoState extends State<RutaUno> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = LatLng(0, 0);

  void initState() {
    super.initState();
    _determinePosition();
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación no están habilitados, no podemos obtener la ubicación.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Los permisos están denegados.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Los permisos están permanentemente denegados.
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _updateCameraPosition(LatLng(position.latitude, position.longitude));
  }

  // Este método actualiza la cámara del mapa para centrarse en la nueva ubicación.
  void _updateCameraPosition(LatLng location) {
    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(location));
    }
    setState(() {
      _currentLocation = location;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if(_currentLocation.latitude != 0 && _currentLocation.longitude != 0){
      controller.animateCamera(
        CameraUpdate.newLatLng(_currentLocation),
      );
    }
  }

  void _handleLongPress(LatLng position){
    setState(() {
      _currentLocation = position;
      _mapController!.animateCamera(

        CameraUpdate.newLatLng(position),
      );
    });
  }

  void _getCurrentLocation() async{
    try {
      LatLng currentLocation = await Localizador().getCurrentLocation();
      setState(() {
        _currentLocation = currentLocation;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error al obtener la ubicación");
      }
    }
  }

  Future<void> _selectLocation() async {
    LatLng selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectLocationScreen()),
    );
    if (selectedLocation != null) {
      setState(() {
        _currentLocation = selectedLocation;
        // Actualizar el marcador

        // Actualizar el texto del botón "Tu ubicación"
        // ...
      });
      _updateCameraPosition(selectedLocation); // Para centrar el mapa en la nueva ubicación
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //key: _scafoldKey,
        body: Stack(children: [
          Positioned(
            top: 50.0,
            left: 50.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          // Fondo de pantalla
          GoogleMap(
            onMapCreated: _onMapCreated,
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: _currentLocation,
                zoom: 14
              ),
              onLongPress: _handleLongPress,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
          ),
          Container(
              //padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width,
              height: 140,
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        //  alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 9.0),
                          child: TextButton(
                            onPressed: _selectLocation,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                            ),

                            //Obtener nombre y coordenadas del lugar A con api
                            child: Align(
                                alignment: Alignment.centerLeft,
                                ),
                          ),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        //  alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 7.0),
                          child: TextButton(
                            onPressed: () async{
                              LatLng selectedLocation = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=> SelectLocationScreen()),
                              );
                              if (selectedLocation != null){
                                //Hacer algo con la ubicacion
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                            ),

                            //Obtener nombre del lugar B con api
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Jugos Lupita',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontFamily: 'Nunito',
                                  ),
                                )),
                          ),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.all(10.0)),
                            Container(
                                width: 120,
                                height: 30,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0, right: 16.0, top: 7.0),
                                  child: ElevatedButton(
                                    //Transporte
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return const Color(0xFF114C5F);
                                          return Colors.white;
                                        },
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                    ),

                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Row(children: [
                                          Icon(
                                            Icons.directions_car,
                                            color: const Color(0xFF114C5F),
                                            size: 20.0,
                                          ),
                                          Text(
                                            //Tiempo de transporte auto
                                            '46min',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: 'Nunito',
                                            ),
                                          )
                                        ])),
                                  ),
                                )),
                            Container(
                                width: 100,
                                height: 30,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 7.0),
                                  child: ElevatedButton(
                                    //Transporte
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return const Color(0xFF114C5F);
                                          return Colors.white;
                                        },
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                    ),

                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Row(children: [
                                          Icon(
                                            Icons.directions_bus,
                                            color: const Color(0xFF114C5F),
                                            size: 20.0,
                                          ),
                                          Text(
                                            //Tiempo de transporte publico
                                            '46min',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: 'Nunito',
                                            ),
                                          )
                                        ])),
                                  ),
                                )),
                            Container(
                                width: 100,
                                height: 30,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 7.0),
                                  child: ElevatedButton(
                                    //Transporte
                                    onPressed: () {},

                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return const Color(0xFF114C5F);
                                          return Colors.white;
                                        },
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      )),
                                    ),

                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(children: [
                                          Icon(
                                            Icons.directions_walk,
                                            color: const Color(0xFF114C5F),
                                            size: 20.0,
                                          ),
                                          Text(
                                            //Tiempo de transporte publico
                                            '46min',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: 'Nunito',
                                            ),
                                          )
                                        ])),
                                  ),
                                ))
                          ],
                        )),
                  ])),

          // Contenido en la parte inferior
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Alinea los textos a la izquierda
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                            child: Icon(
                              Icons.directions_bus,
                              color: const Color(0xFF114C5F),
                              size: 24.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: Text(
                              //Tiempo de transporte
                              '46 min (26km)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(100, 0, 0, 0),
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 14, 10, 10),
                          child: Text(
                            //Tiempo de transporte
                            'La ruta más rápida debido a las condiciones.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(100, 0, 0, 0),
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ]

            /*  floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),*/
            ),
      ),
    );
  }

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
