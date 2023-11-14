import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turisteando_ando/screens/frmCuestionario.dart';

class frmSetLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          // MAPA DE GOOGLE MAPS
          const Scaffold(
              //body: GoogleMap(),
              ),
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
                            padding: EdgeInsets.fromLTRB(16, 12, 5, 0),
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Ingrese su ubicación',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF114C5F),
                        onPrimary: Colors.white,
                        minimumSize: const Size(300,
                            50), // Ajusta el ancho (200) y el alto (50) del botón
                        padding: const EdgeInsets.all(16.0), // Relleno
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Borde redondeado
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
      )),
    );
  }
}
