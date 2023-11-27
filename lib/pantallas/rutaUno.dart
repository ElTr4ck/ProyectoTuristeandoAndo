import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:google_maps_widget/google_maps_widget.dart';

final GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM");

/*void main() {
  runApp(const MyApp());
}*/

class MyApp extends StatelessWidget {
  final String predictionDescription;

  MyApp(this.predictionDescription);
  @override
  Widget build(BuildContext context) {
    //print(predictionDescription);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turisteando Ando',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: 'rutaNav',
      routes: {'rutaNav': (_) => RutaUno(predictionDescription: predictionDescription,)},
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
    LatLng currentLantLng = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentLocation=currentLantLng;
    });
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
            myLocationButtonEnabled: true,
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
final Set<Marker> _markers={};

class RutaUno extends StatefulWidget{
  final String predictionDescription;

  RutaUno({required this.predictionDescription});
  @override
  _RutaUnoState createState() =>_RutaUnoState();
}

class _RutaUnoState extends State<RutaUno> {

  GoogleMapController? _mapController;
  LatLng _currentLocation = LatLng(19.434394864500188, -99.13458543861476);
  LatLng _secondLocation = LatLng(0, 0); // Para la segunda ubicación
  String secondLocationName = 'Buscar ubicación'; // Texto inicial del segundo botón
  String buttonText = 'Tu ubicacion';
  String travelTimeButton = "0"; // Valor inicial
  double km = 0.0;


  /*void initState() {
    super.initState();
    _determinePosition();
  }*/

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

    LatLng currentLantLng = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentLocation=currentLantLng;
    });
    _updateCameraPosition(LatLng(position.latitude, position.longitude));

    return position;

  }

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


  Future<void> _selectLocation() async {
    Position position = await _determinePosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    LatLng selectedLocation = LatLng(latitude, longitude);/*await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectLocationScreen()),
    );*/
    print("Ubicación seleccionada: $selectedLocation"); // Agregar esta línea para depuración
    if (selectedLocation != null) {
      String placeName = await getPlaceName(selectedLocation); // Obtén el nombre del lugar

      //Eliminar
      setState(() {
        _markers.removeWhere((marker) => marker.markerId==MarkerId('inicialLocation'));
      });

      Marker updatedMarker = Marker(
        markerId: MarkerId('inicialLocation'),
        position: selectedLocation,
        infoWindow: InfoWindow(title: 'Ubicacion de inicio'),
      );

      setState(() {
        _currentLocation = selectedLocation;
        buttonText = placeName;
        // buttonText es la variable que almacena el texto del botón
        _markers.add(updatedMarker);
      });
      _updateCameraPosition(selectedLocation); // Centra el mapa en la nueva ubicación
    }
  }

  Future<void> _searchAndSelectSecondLocation() async {
    LatLng newLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectLocationScreen()), // Asegúrate de que este widget permita seleccionar una ubicación
    );

    if (newLocation != null) {
      String placeName = await getPlaceName(newLocation); // Obtén el nombre del lugar
      Marker searchedLocationMarker = Marker(
        markerId: MarkerId('searchedLocation'),
        position: newLocation,
        infoWindow: InfoWindow(title: 'Ubicacion final'),
      );

      setState(() {
        _secondLocation = newLocation;
        print(newLocation.latitude);
        print(newLocation.longitude);
        secondLocationName = placeName; // Actualiza el texto del segundo botón
        _markers.add(searchedLocationMarker);
      });
    }
  }

  Future<String> getPlaceName(LatLng coordinates) async {
    String googleApiKey = 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.latitude},${coordinates.longitude}&key=$googleApiKey';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['results'] != null && jsonResponse['results'].length > 0) {
          // Asume que el primer resultado es el nombre del lugar más relevante
          return jsonResponse['results'][0]['formatted_address'];
        } else {
          return "Nombre del Lugar no encontrado";
        }
      } else {
        return "Error de respuesta: ${response.statusCode}";
      }
    } catch (e) {
      return "Error al obtener el nombre del lugar: $e";
    }
  }

  Future getDirections(LatLng start, LatLng end, String mode) async {
    String baseUrl = "https://maps.googleapis.com/maps/api/directions/json";
    String url = "$baseUrl?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&mode=$mode&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Manejo de errores
      print('Error al obtener las direcciones: ${response.statusCode}');
      return null;
    }
  }

  void _showRoute() async {
    var directions = await getDirections(_currentLocation, _secondLocation,'driving');
    String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];
    showRouteOnMap(encodedPolyline);
  }

  void _showRoutePie() async {
    var directions = await getDirections(_currentLocation, _secondLocation,'walking');
    String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];
    showRouteOnMap(encodedPolyline);
  }

  void _showRouteTrans() async {
    var directions = await getDirections(_currentLocation, _secondLocation,'transit');
    String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];
    showRouteOnMap(encodedPolyline);
  }

  Set<Polyline> _polylines = {};

  void showRouteOnMap(String encodedPolyline) {
    Polyline polyline = Polyline(
      polylineId: PolylineId("route"),
      points: _decodePoly(encodedPolyline),
      width: 5,
      color: Colors.orangeAccent,
    );

    setState(() {
      _polylines.clear();
      _polylines.add(polyline);
    });
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = new LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      points.add(p);
    }

    return points;
  }

  Future<void> drawRoute() async {
    LatLng startLocation= _currentLocation; // Tu ubicación de inicio
    LatLng endLocation= _secondLocation; // Tu ubicación de destino

    // Suponiendo que tienes una función para obtener las direcciones
    var directions = await getDirections(startLocation, endLocation, "driving"); // o "walking"

    // Obtener el polilíneo codificado de la respuesta
    String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];

    // Dibujar la ruta en el mapa
    showRouteOnMap(encodedPolyline);
  }

  Future<String> calculateTravelTime(LatLng start, LatLng end, String mode) async {
    try {
      var directions = await getDirections(start, end, mode);
      if (directions['routes'] != null && directions['routes'].isNotEmpty) {
        // El tiempo total de viaje está en la primera 'leg' de la ruta
        var duration = directions['routes'][0]['legs'][0]['duration']['text'];
        return duration; // Esto devolverá una cadena como "15 mins"
      } else {
        return "No disponible";
      }
    } catch (e) {
      print('Error al calcular el tiempo de viaje: $e');
      return "Error";
    }
  }

  void _updateTravelTime() async {
    String travelTime = await calculateTravelTime(_currentLocation, _secondLocation, "driving");
    setState(() {
      travelTimeButton = travelTime; // Actualiza el estado con el tiempo de viaje
    });
  }

  void onLocationSelected(LatLng start, LatLng end) {
    _currentLocation = start;
    _secondLocation = end;
    _updateTravelTime();
  }

  @override
  void initState() {
    super.initState();
    _selectLocation();
  }
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
              markers: Set<Marker>.of(_markers),
              mapType: MapType.terrain,
              polylines: Set<Polyline>.of(_polylines),
              initialCameraPosition: CameraPosition(
                target: _currentLocation,
                zoom: 14
              ),
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
          ),

          Container(
              //padding: const EdgeInsets.all(16.0),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                // Ajusta la opacidad y el color del fondo difuminado
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.2))
                ], // Efecto de desenfoque
              ),
              //width: MediaQuery.of(context).size.width,
              //height: 140,
              //padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 45), // Espacio interno
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 9.0),
                          child: TextButton(
                            onPressed: _selectLocation,
                            child: Text(
                              buttonText,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Nunito',
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                              minimumSize: MaterialStateProperty.all(Size(150.0, 50.0)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            ),
                          ),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 9.0),
                          child: TextButton(
                            onPressed: _searchAndSelectSecondLocation,
                            child: Text(
                              secondLocationName,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Nunito',
                              ),
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(150.0, 50.0)),
                              backgroundColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  )),
                            ),
                          ),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.all(10.0)),
                            Container(
                                width: 105,
                                height: 30,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 7.0),
                                  child: ElevatedButton(
                                    //Transporte
                                    onPressed:_showRoute,
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
                                        child: Row(children: <Widget>[
                                          Icon(
                                            Icons.directions_car,
                                            color: const Color(0xFF114C5F),
                                            size: 20.0,
                                          ), // Tu condición aquí
                                          Text(
                                            //Tiempo de transporte publico
                                            '${((((sqrt(pow((_secondLocation.latitude-_currentLocation.latitude), 2) + pow((_secondLocation.longitude - _currentLocation.longitude), 2)))*100))*5).toStringAsFixed(0)} min',
                                            //travelTimeButton,
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
                                width: 105,
                                height: 30,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 7.0),
                                  child: ElevatedButton(
                                    //Transporte
                                    onPressed: _showRouteTrans,
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
                                            '${((((sqrt(pow((_secondLocation.latitude-_currentLocation.latitude), 2) + pow((_secondLocation.longitude - _currentLocation.longitude), 2)))*100))*6).toStringAsFixed(0)} min',
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
                                width: 105,
                                height: 30,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 7.0),
                                  child: ElevatedButton(
                                    //Transporte
                                    onPressed: _showRoutePie,
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
                                            '${((((sqrt(pow((_secondLocation.latitude-_currentLocation.latitude), 2) + pow((_secondLocation.longitude - _currentLocation.longitude), 2)))*100))*16).toStringAsFixed(0)} min',
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
        ]),
      ),
    );
  }
}
