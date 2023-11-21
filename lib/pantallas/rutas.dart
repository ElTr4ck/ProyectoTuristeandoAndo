import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:ahora_si_maps/modelo/polyline_response.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:google_maps_routes/google_maps_routes.dart';



class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);


  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}
const kGoogleApiKey = 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _PolylineScreenState extends State<PolylineScreen> {
  static const CameraPosition initialPosition = CameraPosition(
      target: LatLng(19.36965534943562, -98.96226746584259), zoom: 14);


  final Completer<GoogleMapController> _controller = Completer();

  String totalDistance = "";
  String totalTime = "";

  String apiKey = "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM";

  LatLng origin = LatLng(0, 0);
  LatLng destination = LatLng(0, 0);

  double destinolat = 0.0;
  double destinolon = 0.0;

  //PolylineResponse polylineResponse = PolylineResponse();

  //Set<Polyline> polylinePoints = {};

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;

  List<LatLng> points = [
    LatLng(19.36663909454925, -98.96088344601702),
    LatLng(19.50481109220203, -99.14636592039268)
    //LatLng(45.851254420031296, 14.624331708344428),
    //LatLng(45.84794984187217, 14.605434384742317)
  ];

  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  String googleApiKey = 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
  String totalDistances = 'No route';


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          GoogleMap(
            polylines: route.routes,
            zoomControlsEnabled: false,
            initialCameraPosition: initialPosition,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),

          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              // Ajusta la opacidad y el color del fondo difuminado
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.2))
              ], // Efecto de desenfoque
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 45), // Espacio interno
                Container(
                  alignment: Alignment.center,
                  // Centrar horizontal y verticalmente
                  child: Text(
                    "¿Qué deseas hacer el día de hoy?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _handlePressButton();// Aquí puedes manejar la lógica del botón
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Color de fondo del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey), // Icono de búsqueda
                          SizedBox(width: 10),
                          Text(
                            'Sugerencia: Museos',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Nunito',
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                // La barra de búsqueda que diseñamos anteriormente
                /*Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Sugerencia: Museos',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Nunito',
                          fontStyle: FontStyle.italic,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        // Ajusta el color del fondo según tus necesidades
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                      onSubmitted: (value) {
                        _handlePressButton();
                      },
                    ),
                  ),
                ),*/

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 160),

            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Total Distance: " + totalDistance),
                Text("Total Time: " + totalTime),

              ],
            ),
          ),
        ],

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          drawPolyline(destinolat, destinolon);
        },
        child: const Icon(Icons.directions),
      ),
    );
  }


  void drawPolyline(double destinationlat, double destinationlon) async {
    Position position = await _determinePosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    //origin = LatLng(latitude, longitude);
    //destination = LatLng(destinationlat, destinationlon);
    List<LatLng> points = [
      LatLng(latitude, longitude),
      LatLng(destinationlat, destinationlon)
      //LatLng(45.851254420031296, 14.624331708344428),
      //LatLng(45.84794984187217, 14.605434384742317)
    ];
    await route.drawRoute(points, 'Test routes',
        Color.fromRGBO(130, 78, 210, 1.0), googleApiKey,
        travelMode: TravelModes.walking);
    setState(() {
      totalDistance =
          distanceCalculator.calculateRouteDistance(points, decimals: 1);


      //totalTime =

    });
    /*var response = await http.post(Uri.parse("https://maps.googleapis.com/maps/api/directions/json?key=" +
        apiKey +
        "&units=metric&origin=" +
        origin.latitude.toString() +
        "," +
        origin.longitude.toString() +
        "&destination=" +
        destination.latitude.toString() +
        "," +
        destination.longitude.toString() +
        "&mode=driving"));

    print(response.body);

    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));

    totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
    totalTime = polylineResponse.routes![0].legs![0].duration!.text!;

    for (int i = 0; i < polylineResponse.routes![0].legs![0].steps!.length; i++) {
      polylinePoints.add(Polyline(polylineId: PolylineId(polylineResponse.routes![0].legs![0].steps![i].polyline!.points!), points: [
        LatLng(
            polylineResponse.routes![0].legs![0].steps![i].startLocation!.lat!, polylineResponse.routes![0].legs![0].steps![i].startLocation!.lng!),
        LatLng(polylineResponse.routes![0].legs![0].steps![i].endLocation!.lat!, polylineResponse.routes![0].legs![0].steps![i].endLocation!.lng!),
      ],width: 3,color: Colors.red));
    }

    setState(() {});*/
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
  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'es',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country,"mx")]);


    displayPrediction(p!,homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {

    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    double lat2 = detail.result.geometry!.location.lat;
    double lng2 = detail.result.geometry!.location.lng;
    print(lat2);
    print(lng2);

    markersList.clear();
    markersList.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat2, lng2),infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat2, lng2), 14.0));
    //polylinePoints.clear();
    drawPolyline(lat2, lng2);

  }
}
