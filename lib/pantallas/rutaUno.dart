import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:google_maps_widget/google_maps_widget.dart';

final GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM");

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
      routes: {
        'rutaNav': (_) => RutaUno(
              predictionDescription: predictionDescription,
              selectedDate: DateTime.now(),
            )
      },
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

class SelectLocationScreen extends StatefulWidget {
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LatLng _currentLocation = LatLng(0, 0);
  final TextEditingController _searchController = TextEditingController();
  Set<Marker> _markers = {};
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
      _currentLocation = currentLantLng;
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

        LatLng newLocation =
            LatLng(place.geometry!.location.lat, place.geometry!.location.lng);
        setState(() {
          _currentLocation = newLocation;
          _markers.clear();
          _markers.add(Marker(
            markerId: const MarkerId("Ubicacion"),
            position: newLocation,
            infoWindow: InfoWindow(title: place.name),
          ));
          _mapController!
              .animateCamera(
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

  void _handleLongPress(LatLng position) {
    setState(() {
      _currentLocation = position;
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId("newMarker"),
        position: position,
        infoWindow: const InfoWindow(title: "Ubicacion"),
      ));
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
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar lugar',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchPlace(_searchController.text);
                    },
                  ),
                ),
                onSubmitted: _searchPlace,
              )),
          Expanded(
              child: GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            onTap: _selectLocation,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  0, 0), // Posición inicial, podría ser la ubicación actual
              zoom: 14,
            ),
            markers: _markers,
            onLongPress: _handleLongPress,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ))
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

final Set<Marker> _markers = {};
final Set<Marker> _markersItinerario = {};

class RutaUno extends StatefulWidget {
  final String predictionDescription;
  final DateTime selectedDate;
  final bool generarRuta;


  RutaUno({required this.predictionDescription, required this.selectedDate, this.generarRuta = false});
  @override
  _RutaUnoState createState() => _RutaUnoState();
}

class _RutaUnoState extends State<RutaUno> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = LatLng(0, 0);
  LatLng _secondLocation = LatLng(0, 0); // Para la segunda ubicación
  String secondLocationName =
      'Buscar ubicación'; // Texto inicial del segundo botón
  String buttonText = 'Tu ubicacion';
  String travelTimeButton = "0"; // Valor inicial
  double km = 0.0;
  int x = 0;
  bool isDestinationButtonEnabled = true;
  String totalTravelTime= "0 min";
  String totalTravelTimecam= "0 min";
  String totalTravelTimetrans= "0 min";

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
      _currentLocation = currentLantLng;
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
    if (_currentLocation.latitude != 0 && _currentLocation.longitude != 0) {
      controller.animateCamera(
        CameraUpdate.newLatLng(_currentLocation),
      );
    }
  }

  Future<void> _selectLocation() async {
    Position position = await _determinePosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    LatLng selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectLocationScreen()),
    );
    print(
        "Ubicación seleccionada: $selectedLocation"); // Agregar esta línea para depuración
    if (selectedLocation != null) {
      String placeName =
          await getPlaceName(selectedLocation); // Obtén el nombre del lugar

      //Eliminar
      setState(() {
        _markers.removeWhere(
            (marker) => marker.markerId == MarkerId('inicialLocation'));
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
        _polylines.clear();
        _markers.add(updatedMarker);
      });
      _updateCameraPosition(
          selectedLocation); // Centra el mapa en la nueva ubicación
    }
  }

  Future<void> _selectLocationDefault() async {
    Position position = await _determinePosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    LatLng selectedLocation = LatLng(latitude,
        longitude); /*await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectLocationScreen()),
    );*/
    print(
        "Ubicación seleccionada: $selectedLocation"); // Agregar esta línea para depuración
    if (selectedLocation != null) {
      String placeName =
          await getPlaceName(selectedLocation); // Obtén el nombre del lugar

      //Eliminar
      setState(() {
        _markers.removeWhere(
            (marker) => marker.markerId == MarkerId('inicialLocation'));
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
        _polylines.clear();
        //_markers.clear();
        _markers.add(updatedMarker);
      });
      _updateCameraPosition(
          selectedLocation); // Centra el mapa en la nueva ubicación
    }
  }

  Future<void> _searchAndSelectSecondLocationDefault() async {
    LatLng defaults = LatLng(0, 0);
    String url = 'https://places.googleapis.com/v1/places:searchText';
    // Los datos que enviarás en el cuerpo de la solicitud POST
    Map<String, dynamic> requestData = {
      "textQuery": widget.predictionDescription as String
    };

    // Las cabeceras de la solicitud
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key':
          'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM', // Reemplaza 'API_KEY' con tu clave real
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
        //print('Respuesta exitosa: ${response.body}');
        Map<String, dynamic> jsonData = json.decode(response.body);
        //print('${jsonData["places"][0]["location"]["latitude"]}');
        double lat =
            double.parse('${jsonData["places"][0]["location"]["latitude"]}');
        //print('${jsonData["places"][0]["location"]["longitude"]}');
        double lon =
            double.parse('${jsonData["places"][0]["location"]["longitude"]}');
        defaults = LatLng(lat, lon);
        //print('AQUI ESTOY $lat');
        //print('${jsonData["places"][0]["formattedAddress"]}');
      } else {
        // Hubo un error en la solicitud, puedes manejarlo aquí
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      // Maneja las excepciones que puedan ocurrir durante la solicitud
      print('Error: $e');
    }

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestData),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    LatLng newLocation = defaults;
    print('AQUI ESTOY $newLocation');

    if (newLocation != null) {
      String placeName =
          await getPlaceName(newLocation); // Obtén el nombre del lugar
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
        _polylines.clear();
        //_markers.clear();
        _markers.add(searchedLocationMarker);
      });
    }
  }

  Future<void> _searchAndSelectSecondLocation() async {
    LatLng newLocation = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SelectLocationScreen()), // Asegúrate de que este widget permita seleccionar una ubicación
    );

    if (newLocation != null) {
      String placeName =
          await getPlaceName(newLocation); // Obtén el nombre del lugar
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
        _polylines.clear();
        //_markers.clear();
        _markers.add(searchedLocationMarker);
      });
    }
  }

  Future<String> getPlaceName(LatLng coordinates) async {
    String googleApiKey = 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.latitude},${coordinates.longitude}&key=$googleApiKey';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['results'] != null &&
            jsonResponse['results'].length > 0) {
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
    String url =
        "$baseUrl?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&mode=$mode&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM";

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
    var directions =
        await getDirections(_currentLocation, _secondLocation, 'driving');
    String encodedPolyline =
        directions['routes'][0]['overview_polyline']['points'];
    showRouteOnMap(encodedPolyline);
  }

  void _showRoutePie() async {
    var directions =
        await getDirections(_currentLocation, _secondLocation, 'walking');
    String encodedPolyline =
        directions['routes'][0]['overview_polyline']['points'];
    showRouteOnMap(encodedPolyline);
  }

  void _showRouteTrans() async {
    var directions =
        await getDirections(_currentLocation, _secondLocation, 'transit');
    String encodedPolyline =
        directions['routes'][0]['overview_polyline']['points'];
    showRouteOnMap(encodedPolyline);
  }

  final Set<Polyline> _polylines = {};

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
    LatLng startLocation = _currentLocation; // Tu ubicación de inicio
    LatLng endLocation = _secondLocation; // Tu ubicación de destino

    // Suponiendo que tienes una función para obtener las direcciones
    var directions = await getDirections(
        startLocation, endLocation, "driving"); // o "walking"

    // Obtener el polilíneo codificado de la respuesta
    String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];

    // Dibujar la ruta en el mapa
    showRouteOnMap(encodedPolyline);
  }


  void fetchPlaces() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('favoritos')
          .get();

      for (var doc in snapshot.docs) {
        String placeId = doc.data()['id'];
        var placeDetails = await fetchPlaceDetailsFromApi(placeId);
        _addMarker(placeDetails, placeId); // Pasar placeId a _addMarker
      }
    }
  }
  void _addMarker(Map<String, dynamic> placeDetails, String placeId) {
    final marker = Marker(
      markerId:
      MarkerId(placeId), // Usar placeId como identificador del marcador
      position: LatLng(placeDetails['latitude'], placeDetails['longitude']),
      infoWindow: InfoWindow(
          title: placeDetails['title']), // Usar 'title' que has definido
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRose), // Marcador rosa
    );

    setState(() {
      _markers.add(marker);
    });
  }

  List<LatLng> routePoints = [];
  void fetchPlacesItinerario(DateTime selectedDate) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print("El día es: $selectedDate");
    User? user = auth.currentUser;
    if (user != null) {
      var snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('itinerario')
          .where("fechaSeleccionado", isEqualTo: DateTime(selectedDate.year, selectedDate.month, selectedDate.day).toIso8601String())
          .get();
      print('Documentos encontrados: ${snapshot.docs.length}'); // Imprime la cantidad de documentos encontrados
      routePoints.clear();
      routePoints.add(_currentLocation);
      for (var doc in snapshot.docs) {;
        String placeId = doc.data()['id'];
        print('Lugar encontrado por la fecha: $placeId');
        var placeDetails = await fetchPlaceDetailsFromApi(placeId);
        _addMarkerItinerario(placeDetails, placeId); // Pasar placeId a
        print("Route Points: $routePoints");
        routePoints.add(LatLng(placeDetails['latitude'], placeDetails['longitude'])); // Añadir punto de ruta
      }
      drawOptimalRoute();
    }
  }
  void _addMarkerItinerario(Map<String, dynamic> placeDetails, String placeId) {
    final marker = Marker(
      markerId: MarkerId(placeId), // Usar placeId como identificador del marcador
      position: LatLng(placeDetails['latitude'], placeDetails['longitude']),
      infoWindow: InfoWindow(title: placeDetails['title']), // Usar 'title' que has definido
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan), // Marcador
    );
    setState(() {
      _markers.add(marker);
      _markersItinerario.add(marker);
    });
  }
  Future<void> drawOptimalRoute() async {
    List<LatLng> points = List.from(routePoints); // Copia para no modificar la lista original
    List<LatLng> optimalRoute = findOptimalRoute(points, _currentLocation);

    for (int i = 0; i < optimalRoute.length - 1; i++) {
      var directions = await getDirections(optimalRoute[i], optimalRoute[i + 1], "driving");
      if (directions != null && directions['routes'] != null && directions['routes'].isNotEmpty) {
        String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];
        addPolylineToMap(encodedPolyline);
      }
    }
    totalTravelTime = await calculateTotalTravelTime(optimalRoute, "driving");
    totalTravelTimecam = await calculateTotalTravelTime(optimalRoute, "walking");
    totalTravelTimetrans = await calculateTotalTravelTime(optimalRoute, "transit");
    setState(() {
      totalTravelTime = totalTravelTime; // Actualiza la variable de estado
      totalTravelTimecam= totalTravelTimecam;
      totalTravelTimetrans= totalTravelTimetrans;
    });
  }
  void addPolylineToMap(String encodedPolyline) {
    Polyline polyline = Polyline(
      polylineId: PolylineId("route_${_polylines.length}"),
      points: _decodePoly(encodedPolyline),
      width: 5,
      color: Colors.blue,
    );

    setState(() {
      _polylines.add(polyline);
    });
  }
  void _addPolylineToMap() async {
    _polylines.clear();

    List<LatLng> points = List.from(routePoints); // Copia para no modificar la lista original
    List<LatLng> optimalRoute = findOptimalRoute(points, _currentLocation);

    for (int i = 0; i < optimalRoute.length - 1; i++) {
      var directions = await getDirections(optimalRoute[i], optimalRoute[i + 1], "driving");
      if (directions != null && directions['routes'] != null && directions['routes'].isNotEmpty) {
        String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];
        addPolylineToMap(encodedPolyline);
      }
    }
  }
  void _addPolylineToMapPie() async {
    _polylines.clear();

    List<LatLng> points = List.from(routePoints); // Copia para no modificar la lista original
    List<LatLng> optimalRoute = findOptimalRoute(points, _currentLocation);

    for (int i = 0; i < optimalRoute.length - 1; i++) {
      var directions = await getDirections(optimalRoute[i], optimalRoute[i + 1], "walking");
      if (directions != null && directions['routes'] != null && directions['routes'].isNotEmpty) {
        String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];
        addPolylineToMap(encodedPolyline);
      }
    }
  }
  void _addPolylineToMapTrans() async {
    _polylines.clear();

    List<LatLng> points = List.from(routePoints); // Copia para no modificar la lista original
    List<LatLng> optimalRoute = findOptimalRoute(points, _currentLocation);

    for (int i = 0; i < optimalRoute.length - 1; i++) {
      var directions = await getDirections(optimalRoute[i], optimalRoute[i + 1], "transit");
      if (directions != null && directions['routes'] != null && directions['routes'].isNotEmpty) {
        String encodedPolyline = directions['routes'][0]['overview_polyline']['points'];
        addPolylineToMap(encodedPolyline);
      }
    }
  }

  List<LatLng> findOptimalRoute(List<LatLng> points, LatLng start) {
    List<LatLng> route = [];
    LatLng currentPoint = start;

    while (points.isNotEmpty) {
      final closestPoint = findClosestPoint(currentPoint, points);
      route.add(closestPoint);
      points.remove(closestPoint);
      currentPoint = closestPoint;
    }
    return route;
  }
  LatLng findClosestPoint(LatLng currentLocation, List<LatLng> points) {
    if (points.isEmpty) {
      throw Exception('La lista de puntos está vacía');
    }

    // Inicializa con el primer punto de la lista
    LatLng closestPoint = points.first;
    double minDistance = _calculateDistance(currentLocation, closestPoint);

    for (var point in points) {
      double distance = _calculateDistance(currentLocation, point);
      if (distance < minDistance) {
        minDistance = distance;
        closestPoint = point;
      }
    }
    return closestPoint;
  }
  double _calculateDistance(LatLng point1, LatLng point2) {
    var earthRadiusKm = 6371.0;
    var dLat = _degreesToRadians(point2.latitude - point1.latitude);
    var dLon = _degreesToRadians(point2.longitude - point1.longitude);
    var lat1 = _degreesToRadians(point1.latitude);
    var lat2 = _degreesToRadians(point2.latitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  Future<String> calculateTotalTravelTime(List<LatLng> route, String mode) async {
    int totalMinutes = 0;

    for (int i = 0; i < route.length - 1; i++) {
      String travelTimeSegment = await calculateTravelTime(route[i], route[i + 1], mode);
      int minutes = extractMinutesFromTravelTime(travelTimeSegment);
      totalMinutes += minutes;
    }

    return "$totalMinutes min";
  }
  int extractMinutesFromTravelTime(String travelTime) {
    var parts = travelTime.split(' ');
    if (parts.length >= 2) {
      return int.tryParse(parts[0]) ?? 0;
    }
    return 0;
  }
  Future<String> calculateTravelTime(LatLng start, LatLng end, String mode) async {
    try {
      var directions = await getDirections(start, end, mode); // Asegúrate de que 'mode' se pasa correctamente aquí
      if (directions['routes'] != null && directions['routes'].isNotEmpty) {
        var duration = directions['routes'][0]['legs'][0]['duration']['text'];
        return duration; // Devuelve una cadena como "15 mins"
      } else {
        return "No disponible";
      }
    } catch (e) {
      print('Error al calcular el tiempo de viaje: $e');
      return "Error";
    }
  }

  Future<Map<String, dynamic>> fetchPlaceDetailsFromApi(String placeId) async {
    String apiKey =
        'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM'; // Reemplaza con tu clave API de Google
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        if (json['status'] == 'OK') {
          var result = json['result'];

          double latitude = result['geometry']['location']['lat'];
          double longitude = result['geometry']['location']['lng'];
          String name = result['name']; // Nombre del lugar

          return {
            'latitude': latitude,
            'longitude': longitude,
            'title': name,
          };
        } else {
          throw Exception('Failed to load place details');
        }
      } else {
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      print('Error al obtener detalles del lugar: $e');
      return {}; // Retorna un mapa vacío o maneja el error como prefieras
    }
  }

  Widget buildButtonHome(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        // Coloca aquí la acción que quieres que ocurra al presionar el botón
        print('Acción del botón');
      },
    );
  }

  Widget buildButtonMap(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        // Coloca aquí la acción que quieres que ocurra al presionar el botón
        print('Acción del botón');
      },
    );
  }

  Widget buildButtonFav(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        // Coloca aquí la acción que quieres que ocurra al presionar el botón
        print('Acción del botón');
      },
    );
  }

  Widget buildButtonUsser(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        // Coloca aquí la acción que quieres que ocurra al presionar el botón
        print('Acción del botón');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _determineAndSetCurrentLocation().then((_) {
      _markers.clear();
      _polylines.clear();
      fetchPlaces();
      if(widget.generarRuta){
        fetchPlacesItinerario(widget.selectedDate);
        resetDestination();
      }
      _selectLocationDefault();
    });
    _searchAndSelectSecondLocationDefault();
  }

  void resetDestination() {
    setState(() {
      _secondLocation = LatLng(0.0, 0.0);
      secondLocationName = 'RUTA';
      isDestinationButtonEnabled = false; // Deshabilita el botón
    });
  }
  Future<void> _determineAndSetCurrentLocation() async {
    Position position = await _determinePosition();
    _updateCameraPosition(LatLng(position.latitude, position.longitude));
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Widget build(BuildContext context) {
    print(widget.predictionDescription);
    print(widget.selectedDate);
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
            initialCameraPosition:
                CameraPosition(target: _currentLocation, zoom: 14),
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
          ),

          Container(
              //padding: const EdgeInsets.all(16.0),
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                // Ajusta la opacidad y el color del fondo difuminado
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black.withOpacity(0.2))
                ], // Efecto de desenfoque
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20), // Espacio interno
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 9.0),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return TextButton(
                                  onPressed: _selectLocation,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: constraints
                                          .maxWidth, // Limita el ancho del texto al ancho del botón
                                    ),
                                    child: Text(
                                      'Origen: $buttonText',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: 'Nunito',
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Añade esta línea
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(150.0, 50.0)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ))),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 9.0),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return TextButton(
                                  onPressed: isDestinationButtonEnabled ? _searchAndSelectSecondLocation : null,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: constraints
                                          .maxWidth, // Limita el ancho del texto al ancho del botón
                                    ),
                                    child: Text(
                                      'Destino: $secondLocationName',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: 'Nunito',
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Añade esta línea
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(150.0, 50.0)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ))),
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
                                    onPressed: (){
                                      _showRoute();
                                      _addPolylineToMap();
                                    },
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
                                            size: 18.0,
                                          ), // Tu condición aquí
                                          Expanded(
                                              child: Text(
                                            //Tiempo de transporte publico
                                            isDestinationButtonEnabled ? '${((((sqrt(pow((_secondLocation.latitude - _currentLocation.latitude), 2) + pow((_secondLocation.longitude - _currentLocation.longitude), 2))) * 100)) * 5).toStringAsFixed(0)} min': totalTravelTimecam,
                                            //travelTimeButton,
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: 'Nunito',
                                            ),
                                          ))
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
                                    onPressed: (){
                                      _showRouteTrans();
                                      _addPolylineToMapTrans();
                                    },
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
                                            size: 18.0,
                                          ),
                                          Expanded(
                                              child: Text(
                                            //Tiempo de transporte publico
                                            isDestinationButtonEnabled ? '${((((sqrt(pow((_secondLocation.latitude - _currentLocation.latitude), 2) + pow((_secondLocation.longitude - _currentLocation.longitude), 2))) * 100)) * 6).toStringAsFixed(0)} min': totalTravelTimetrans,
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: 'Nunito',
                                            ),
                                          ))
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
                                    onPressed: (){
                                      _showRoutePie();
                                      _addPolylineToMapPie();
                                    },
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
                                            size: 18.0,
                                          ),
                                          Expanded(
                                              child: Text(
                                            //Tiempo de transporte publico
                                            isDestinationButtonEnabled ? '${((((sqrt(pow((_secondLocation.latitude - _currentLocation.latitude), 2) + pow((_secondLocation.longitude - _currentLocation.longitude), 2))) * 100)) * 16).toStringAsFixed(0)} min': totalTravelTime,
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: 'Nunito',
                                            ),
                                          ))
                                        ])),
                                  ),
                                ))
                          ],
                        )),
                  ])),
        ]),
      ),
    );
  }
}
