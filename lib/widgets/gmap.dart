import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatefulWidget {
  final double lat;
  final double lng;
  final Set<Marker> markers;
  final Null Function(dynamic controller) onMapCreated;
  final Function(LatLng location) addMarker;

  const Gmap({
    Key? key,
    required this.lat,
    required this.lng,
    required this.markers,
    required this.onMapCreated,
    required this.addMarker,
  }) : super(key: key);

  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 16),
        onMapCreated: (controller) {
          _mapController = controller;
          widget.onMapCreated(controller);
        },
        markers: widget.markers,
        onTap: (location) {
          widget.addMarker(location);
        },
      ),
    );
  }
}