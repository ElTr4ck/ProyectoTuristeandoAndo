import 'package:flutter/material.dart';

class FrmRutaDestacada extends StatelessWidget {
  const FrmRutaDestacada({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ruta destacada',
              style: TextStyle(
                fontFamily: 'Monserrat',
                fontSize: 32,
                color: Colors.black,
              ),
            ),
            Text(
              'Completa la ruta destacada de este mes para ganar\nrecompensas canjeables',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w100
              ),
            ),
            Row(
              children: [
                Text(
                  'Tiempo restante: ',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w100
                  ),
                ),
                Text(
                  '27d15h23m', //TODO: Poner el timer de acuerdo a la BD
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w100
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
