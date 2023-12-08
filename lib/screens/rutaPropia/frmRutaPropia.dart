import 'package:flutter/material.dart';

const lugares = <Map<String,dynamic>>[
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
  {'imagen':'https://lh3.googleusercontent.com/p/AF1QipPxoRDsz7KDFBqchprvPlU3fH2Sylbxtiqgz5tn=s680-w680-h510',
  'nombre':'Bellas artes',
  'fecha':'25/10/2011'},
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: RutaPropia(),
    );
  }
}

class RutaPropia extends StatelessWidget {
  const RutaPropia({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Mis rutas', style: TextStyle(
                fontFamily: 'Monserrat',
                fontSize: 32,
              ),),
              const SizedBox(height: 0,width: 0),
              const Text('Añade lugares a tu ruta, agenda el día y te generaremos tu ruta personalizada', style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w300,
              ),),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 8),
                child: Wrap(
                  spacing: 20,
                  alignment: WrapAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text('Fecha prevista para esta ruta:', style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w300,
                      ),),
                    ),
                    TextButton.icon(
                      onPressed: () async{
                        DateTime? fechaSel = await showDatePicker(
                          //locale: const Locale('es', 'ES'),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Color.fromRGBO(17, 76, 95, 1)
                                )
                              ), 
                              child: child!
                            );
                          },
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(date.year),
                          lastDate: DateTime(date.year+5),
                        );
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                      label: Text('${date.day}/${date.month}/${date.year}'),
                    ),
                  ],
                ),
                
              ),
              const SizedBox(height: 0,width: 0),
              const Text('Tus lugares añadidos a la ruta:', style: TextStyle(
                fontFamily: 'Monserrat',
                fontSize: 20,
              ),),

              SizedBox(
                height: height*0.5,
                width: width,
                child: SingleChildScrollView(

                  child: Column(

                    children: [
                      ...lugares.map((lugar) => Tarjeta(url: lugar['imagen'], nombre: lugar['nombre'], fecha: lugar['fecha']))
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                        color: const Color.fromRGBO(17, 76, 95, 1),
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width*0.25, vertical: 5),
                            child: const Text('Generar Ruta', style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 15,
                            )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 45, right: 43),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Material(
                            color: const Color.fromRGBO(242, 230, 207, 1),
                            child: InkWell(
                              onTap: (){},
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: width*0.101, vertical: 10),
                                child: const Text('Compartir', style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                )),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Material(
                            color: const Color.fromRGBO(242, 230, 207, 1),
                            child: InkWell(
                              onTap: (){},
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: width*0.03, vertical: 10),
                                child: const Text('Buscar Sugerencias', style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),)
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class Tarjeta extends StatelessWidget {
  final String url;
  final String nombre;
  final String fecha;

  const Tarjeta({super.key, required this.url, required this.nombre, required this.fecha});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
                url,
                width: 80,
            ),
            Column(
              children: [
                Text(nombre),
                Text('Añadido el $fecha')
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outline_outlined)),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.access_time_rounded)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.check_box_outlined)),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border_rounded)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}