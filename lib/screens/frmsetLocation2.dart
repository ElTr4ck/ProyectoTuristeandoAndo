import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turisteando_ando/blocs/autocomplete/auto_complete_bloc.dart';
import 'package:turisteando_ando/blocs/place/place_bloc.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/frmCuestionario.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/barraBusquedaUbicacion.dart';

class FrmSetLocation extends StatelessWidget {
  const FrmSetLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Selecciona tu ubicación'),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.my_location_rounded),
              )
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
          ),

        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: const GoogleMap(
                initialCameraPosition: CameraPosition(target: LatLng(10, 10), zoom: 14),
                myLocationButtonEnabled: true,
                ),
            ),
            const BarraBusquedaUbicacion()
          ]
          

        ),  
      )
    );
  }
}