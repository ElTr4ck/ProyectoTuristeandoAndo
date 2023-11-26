import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:turisteando_ando/blocs/autocomplete/auto_complete_bloc.dart';
import 'package:turisteando_ando/blocs/place/place_bloc.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/frmCuestionario.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/barraBusquedaUbicacion.dart';

class FrmSetLocation extends StatefulWidget {
  const FrmSetLocation({super.key});

  @override
  State<FrmSetLocation> createState() => _FrmSetLocationState();
}

class _FrmSetLocationState extends State<FrmSetLocation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          /*appBar: AppBar(
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
          ),*/
          appBar: CustomAppBar(
            //key: key,
            title: const Text('Selecciona tu ubicación'),
            height: kToolbarHeight,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.my_location_rounded),
              )
            ],
            leading: const Icon(Icons.arrow_back),
          ),
          body: BlocBuilder<PlaceBloc, PlaceState>(
            builder: (context, state) {
              if (state is PlaceLoading) {
                return Stack(
                  children: [
                    //Barra de busqueda
                    const BarraBusquedaUbicacion(),
                    BlocBuilder<AutoCompleteBloc, AutoCompleteState>(
                      builder: (context, state) {
                        if (state is AutoCompleteLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AutoCompleteLoaded) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(8, 1, 8, 8),
                            height: 200,
                            color: state.autocomplete.isNotEmpty
                                ? Colors.white.withOpacity(0.4)
                                : Colors.transparent,
                            child: ListView.builder(
                                itemCount: state.autocomplete.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(Icons.location_pin),
                                    title: Text(
                                      state.autocomplete[index].descripcion,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                    onTap: () {
                                      context.read<PlaceBloc>().add(LoadPlace(
                                          placeId: state
                                              .autocomplete[index].placeId));
                                    },
                                  );
                                }),
                          );
                        } else {
                          return const Text('Algo salio mal...');
                        }
                      },
                    ),

                    // Columna con elementos abajo
                    Column(
                      children: [
                        //Mapa de MAPS
                        const GoogleMap(
                            initialCameraPosition:
                                CameraPosition(target: LatLng(10, 10))),
                        //Boton de continuar
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF114C5F),
                            onPrimary: Colors.white,
                            minimumSize: const Size(300,
                                50), // Ajusta el ancho (200) y el alto (50) del botón
                            padding: const EdgeInsets.all(16.0), // Relleno
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Borde redondeado
                            ),
                          ), //Style
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => frmCuestionario()));
                          },
                          child: const Text(
                            'Continuar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Contenido en la parte inferior
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              //Este widget column es el cuadro de sugerencias de autocompletado
                              Column(
                                children: [
                                  BarraBusquedaUbicacion(),
                                  BlocBuilder<AutoCompleteBloc,
                                      AutoCompleteState>(
                                    builder: (context, state) {
                                      if (state is AutoCompleteLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (state is AutoCompleteLoaded) {
                                        return Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 8),
                                          height: 100,
                                          color: state.autocomplete.isNotEmpty
                                              ? Colors.white.withOpacity(0.6)
                                              : Colors.transparent,
                                          child: ListView.builder(
                                              itemCount:
                                                  state.autocomplete.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(
                                                    state.autocomplete[index]
                                                        .descripcion,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily: 'Nunito',
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    context
                                                        .read<PlaceBloc>()
                                                        .add(LoadPlace(
                                                            placeId: state
                                                                .autocomplete[
                                                                    index]
                                                                .placeId));
                                                  },
                                                );
                                              }),
                                        );
                                      } else {
                                        return const Text('Algo salio mal...');
                                      }
                                    },
                                  )
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF114C5F),
                                  onPrimary: Colors.white,
                                  minimumSize: const Size(300,
                                      50), // Ajusta el ancho (200) y el alto (50) del botón
                                  padding:
                                      const EdgeInsets.all(16.0), // Relleno
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Borde redondeado
                                  ),
                                ), //Style
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              frmCuestionario()));
                                },
                                child: const Text(
                                  'Continuar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Lógica para usar la ubicación actual
                                },
                                child: const Text(
                                  'Quiero continuar con mi ubicación actual',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF31B6D4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else if (state is PlaceLoaded) {
                return Stack(
                  children: [
                    // MAPA DE GOOGLE MAPS CON LAS COORDENADAS DE LA UBICACION HAY QUE MODIFICARLO
                    GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(state.place.lat, state.place.lon),
                            zoom: 16)),
                    // Contenido en la parte inferior
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              const Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Alinea los textos a la izquierda
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: Text(
                                      'Selecciona tu ubicación',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Alinea los textos a la izquierda
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 12, 5, 0),
                                      child: Text(
                                        'Esto nos ayudará a darte recomendaciones personalizadas.\nPuedes optar por ingresar una ubicación manualmente o dejarnos mostrarte sugerencias mediante tu ubicación actual.',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              //Este widget column es el cuadro de sugerencias de autocompletado
                              Column(
                                children: [
                                  BarraBusquedaUbicacion(),
                                  BlocBuilder<AutoCompleteBloc,
                                      AutoCompleteState>(
                                    builder: (context, state) {
                                      if (state is AutoCompleteLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (state is AutoCompleteLoaded) {
                                        return Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 8),
                                          height: 100,
                                          color: state.autocomplete.isNotEmpty
                                              ? Colors.white.withOpacity(0.6)
                                              : Colors.transparent,
                                          child: ListView.builder(
                                              itemCount:
                                                  state.autocomplete.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(
                                                    state.autocomplete[index]
                                                        .descripcion,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily: 'Nunito',
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    context
                                                        .read<PlaceBloc>()
                                                        .add(LoadPlace(
                                                            placeId: state
                                                                .autocomplete[
                                                                    index]
                                                                .placeId));
                                                  },
                                                );
                                              }),
                                        );
                                      } else {
                                        return const Text('Algo salio mal...');
                                      }
                                    },
                                  )
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF114C5F),
                                  onPrimary: Colors.white,
                                  minimumSize: const Size(300,
                                      50), // Ajusta el ancho (200) y el alto (50) del botón
                                  padding:
                                      const EdgeInsets.all(16.0), // Relleno
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Borde redondeado
                                  ),
                                ), //Style
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              frmCuestionario()));
                                },
                                child: const Text(
                                  'Continuar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Lógica para usar la ubicación actual
                                },
                                child: const Text(
                                  'Quiero continuar con mi ubicación actual',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF31B6D4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return const Text('Algo salio mal...');
              }
            },
          )),
    );
  }
}

//Esta clase nos sirve para los permisos de ubicacion

class Localizador {
  Future<LatLng> determinatePosition() async {
    LocationPermission permission;
    permission = await Geolocator
        .checkPermission(); // Se checa si el permiso ya esta habilitado
    if (permission == LocationPermission.denied) {
      permission = await Geolocator
          .requestPermission(); // En caso de que no este habilitado, se solicita
      if (permission == LocationPermission.denied) {
        // Esto es en caso de que se niegue el permiso de localizacion a la aplicacion
        return const LatLng(19.4326, -99.1332); // Coordenadas del zocalo CDMX
      }
    }
    Position posicion = await Geolocator
        .getCurrentPosition(); //TODO: Faltaria un try y catch de esto por si la app no puede obtener la ubicacion
    LatLng latLng = LatLng(posicion.latitude, posicion.longitude);
    return latLng;
  }

  // Este metodo retorna la ubicacion actual del ususario
  Future<LatLng> getCurrentLocation() async {
    LatLng position = await determinatePosition();
    return position;
  }
}

class AppBarSetLocation extends StatelessWidget {
  const AppBarSetLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tu ubicacion'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          )
        ],
      ),
    );
  }
}
