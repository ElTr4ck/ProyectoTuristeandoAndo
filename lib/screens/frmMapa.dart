import 'package:flutter/material.dart';

class frmMapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            // Fondo de pantalla
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/fondito2.png'), // Ruta de la imagen de fondo
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Contenedor blanco en la parte superior
            Column(
              children: <Widget>[
                Container(
                  color: Colors.white.withOpacity(0.5) ,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 18, 0, 5),
                          child: Text(
                            '¿Qué deseas hacer el día de hoy?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito'
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height: 8.0),
                      // Barra de búsqueda (personalízala según tus necesidades)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Sugerencia: Buscar museos cercanos',
                            prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF114C5F)
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}