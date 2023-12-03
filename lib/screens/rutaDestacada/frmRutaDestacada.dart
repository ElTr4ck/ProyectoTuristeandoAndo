import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/theme/custom_text_style.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';

class FrmRutaDestacada extends StatelessWidget {
  const FrmRutaDestacada({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Ruta destacada',
                style: TextStyle(
                  fontFamily: 'Monserrat',
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'Completa la ruta destacada de este mes para ganar recompensas canjeables',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w100),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Tiempo restante: ',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Text(
                      '27d15h23m', //TODO: Poner el timer de acuerdo a la BD
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ],
            ),
            //Titulo de 'RUTA MENSUAL
            Container(
              padding: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
              alignment: Alignment.topLeft,
              child: Text(
                'Ruta mensual: NOMBRE',
                style: CustomTextStyles.titleLargeNunito,
                textAlign: TextAlign.left,
              ),
            ),

            //TARJETAS DE LUGAR
            SizedBox(
              height: 400,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate( //Codigo piloto, esto se debe de llenar desde la BD
                  5, 
                  (index) => PlaceCardDestacada())
              ),
            ),
            CustomElevatedButton(
              text: 'Agendar ruta completa',
              buttonTextStyle: theme.textTheme.titleLarge!,
              margin:  EdgeInsets.only(top: 20, left: 25.h, right: 25.h),
              height: 40.v,
            ),
            CustomElevatedButton(
              text: 'Canjear recompensa',
              isDisabled: true,
              buttonTextStyle: theme.textTheme.titleLarge!,
              margin:  EdgeInsets.only(top: 5, left: 25.h, right: 25.h),
              height: 40.v,
            )
          ],
        ),
      ),
    );
  }
}

class PlaceCardDestacada extends StatelessWidget {
  const PlaceCardDestacada({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20,0,20,10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 247, 249, 248),
      ),
      height: 100,
      width: MediaQuery.of(context).size.width - 40,
      //Contenido dentro de la tarjeta
      child: Row(
        children: [
          //Imagen de la tarjeta
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: 49,
              height: 49,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'lib/assets/images/imgPruebaRutaDes.png',
                    fit: BoxFit.cover,
                    height: 49,
                    width: 49,
                  )),
            ),
          ),
          //Textis de la tarjeta
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            width: MediaQuery.of(context).size.width - 115,
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Titulo de lugar 1',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 18,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        //Logica para el boton de visitado (sonsultar caso de uso)
                      },
                      icon: const Icon(Icons.check_box_outlined),
                    ),// Ajusta el espacio horizontal aquí
                    IconButton(
                      onPressed: () {
                        //logica para el boton de añadir a marcadores
                      },
                      icon: const Icon(
                          Icons.favorite_border_outlined),
                    ),
                  ],
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 280,
                    child: Text(
                      'Descripción del lugar random aqui se debe de llenar con la api de places xdxdxd',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Color.fromARGB(255, 122, 144, 138)),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
