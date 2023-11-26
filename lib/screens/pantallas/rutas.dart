import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turisteando_ando/modelo/polyline_response.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  static const CameraPosition initialPosition = CameraPosition(target: LatLng(19.36965534943562, -98.96226746584259), zoom: 14);

  final Completer<GoogleMapController> _controller = Completer();

  String totalDistance = "";
  String totalTime = "";

  String apiKey = "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM";

  LatLng origin = LatLng(0, 0);
  LatLng destination = LatLng(31.5525789, 74.2813495);

  PolylineResponse polylineResponse = PolylineResponse();

  Set<Polyline> polylinePoints = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polyline"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            polylines: polylinePoints,
            zoomControlsEnabled: false,
            initialCameraPosition: initialPosition,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
            margin: const EdgeInsets.all(20),
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
          drawPolyline();
        },
        child: const Icon(Icons.directions),
      ),
    );
  }

  void drawPolyline() async {
    Position position = await _determinePosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    origin = LatLng(latitude, longitude);
    destination = const LatLng(19.36965534943562, -98.96226746584259);
    var response = await http.post(Uri.parse("https://maps.googleapis.com/maps/api/directions/json?key=$apiKey&units=metric&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving"));

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

    setState(() {});
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