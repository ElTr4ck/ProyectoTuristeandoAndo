import 'package:flutter/material.dart';
import 'package:turisteando_ando/pantallas/mapa_simple.dart';
import 'package:turisteando_ando/pantallas/ubicacion_usuario.dart';
import 'package:turisteando_ando/pantallas/buscar_lugares.dart';
import 'package:turisteando_ando/pantallas/lugares_cercanos.dart';
import 'package:turisteando_ando/pantallas/rutas.dart';
import 'package:turisteando_ando/pantallas/busquedaGPF.dart';
class InicioPantalla extends StatefulWidget {
  const InicioPantalla({super.key});

  @override
  State<InicioPantalla> createState() => _InicioPantallaState();
}

class _InicioPantallaState extends State<InicioPantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Google Maps"),
        centerTitle: true,
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return const SimpleMapScreen();
                }));
                }, child: const Text("Mapa simple")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return const CurrentLocationScreen();
                }));
              }, child: const Text("Ubicación actual")),
              ElevatedButton(onPressed: (){
                /*Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return MyApp();
                }));*/
              }, child: const Text("Busca lugares")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return const NearByPlacesScreen();
                }));
              }, child: const Text("Lugares cercanos")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return const PolylineScreen();
                }));
              }, child: const Text("Rutas"))

            ],
        ),
      ),
    );
  }
}
