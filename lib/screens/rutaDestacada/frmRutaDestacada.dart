import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/models/rutaDestacada/rutaDestacadaModel.dart';
import 'package:turisteando_ando/models/users/user.dart';

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
                FutureBuilder<DateTime>(
                  future: obtenerFechaInicio(),
                  builder: (context, snapshotFechaInicio) {
                    if (snapshotFechaInicio.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshotFechaInicio.hasError) {
                      return Text('Error: ${snapshotFechaInicio.error}');
                    } else {
                      final fechaFin = snapshotFechaInicio.data!.add(const Duration(days: 30));
                      return Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
                            builder: (context, snapshot) {
                              final duracion = fechaFin.difference(DateTime.now());
                              final dias = duracion.inDays;
                              final horas = duracion.inHours % 24;
                              final minutos = duracion.inMinutes % 60;
                              final segundos = duracion.inSeconds % 60;

                              return Text(
                                '${dias}d${horas}h${minutos}m${segundos}s',
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            //Titulo de 'RUTA MENSUAL
            FutureBuilder(
              future: obtenerNombreRuta(), 
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                }
                else{
                  return Container(
                    padding: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Ruta mensual: ${snapshot.data}',
                      style: CustomTextStyles.titleLargeNunito,
                      textAlign: TextAlign.left,
                    ),
                  );
                }
              }),
           
            //TARJETAS DE LUGAR
            Expanded(
              child: FutureBuilder<List<LugarDestacado>>(
                future: obtenerDatos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: snapshot.data!.map((lugar) => PlaceCardDestacada(lugar: lugar)).toList(),
                    );
                  }
                },
              ),
            ),
            CustomElevatedButton(
              text: 'Agendar ruta completa',
              buttonStyle: CustomButtonStyles.fillPrimaryTL22,
              buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
              margin: EdgeInsets.only(top: 20, left: 25.h, right: 25.h),
              height: 40.v,
              onPressed: () {
                
              },
            ),
            CustomElevatedButton(
              text: 'Canjear recompensa',
              buttonStyle: CustomButtonStyles.fillPrimaryTL22,
              isDisabled: true,
              buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
              margin: EdgeInsets.only(top: 5, left: 25.h, right: 25.h),
              height: 40.v,
            )
          ],
        ),
      ),
    );
  }
}

//TARJETAS DE LA RUTA ESTACADA
class PlaceCardDestacada extends StatelessWidget {
  final LugarDestacado lugar;

  const PlaceCardDestacada({required this.lugar, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                  child: Image.network(
                    lugar.imagen,
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
                     Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          lugar.nombre,
                          style: const TextStyle(
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
                    const BtnVisitado(), // Ajusta el espacio horizontal aquí
                    const BtnMarcadores(),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 280,
                    child: Text(
                      lugar.descripcion,
                      style: const TextStyle(
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

class BtnVisitado extends StatefulWidget {
  const BtnVisitado({super.key});

  @override
  _BtnVisitadoState createState() => _BtnVisitadoState();
}

class _BtnVisitadoState extends State<BtnVisitado> {
  bool presionado = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          presionado = !presionado;
        });
      },
      color: presionado ? Colors.green : Colors.grey,
      icon: presionado ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outlined),
    );
  }
}

class BtnMarcadores extends StatefulWidget {
  const BtnMarcadores({super.key});

  @override
  _BtnMarcadoresState createState() => _BtnMarcadoresState();
}

class _BtnMarcadoresState extends State<BtnMarcadores> {
  bool presionado = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          presionado = !presionado;
        });
      },
      color: presionado ? Colors.red : Colors.grey,
      icon: presionado ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
    );
  }
}
