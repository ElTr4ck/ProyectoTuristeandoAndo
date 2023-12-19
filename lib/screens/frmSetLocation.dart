import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turisteando_ando/blocs/geolocation/geolocation_bloc.dart';
import 'package:turisteando_ando/blocs/place/place_bloc.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/barraBusquedaUbicacion.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/gmap.dart';

class FrmSetLocation extends StatefulWidget {
  const FrmSetLocation({super.key});

  @override
  State<FrmSetLocation> createState() => _FrmSetLocationState();
}

class _FrmSetLocationState extends State<FrmSetLocation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seleccionar ubicación'),
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
                          lng: state.position.longitude, onMapCreated: (controller) {  }, addMarker: (LatLng location) {  }, markers: {}, //Modificar cuando se tenga que
                        );
                      } else {
                        return const Text('Algo ha salido mal');
                      }
                    },
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
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.frmCuestionario);
                                /*
                                Navigator.pushReplacement(
                                  context, 
                                  MaterialPageRoute(builder: (context) => AppRoutes.routes[AppRoutes.frmCuestionario]!(context))
                                );*/
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
            } else if (state is PlaceLoaded) {
              return Stack(
                children: [
                  //Mapa de google sin geolocalizacion, con el place cargado
                  Gmap(
                    lat: state.place.lat,
                    lng: state.place.lon, onMapCreated: (controller) {  }, addMarker: (LatLng location) {  }, markers: { }, //Modificar cuando sea posible
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
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.frmCuestionario);
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
}
