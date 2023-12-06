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

DateTime date = DateTime.now();

class FrmRutaPropia extends StatelessWidget {

  const FrmRutaPropia({super.key});

  @override
  Widget build(BuildContext context) {

    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Mis rutas', style: TextStyle(
              fontFamily: 'Monserrat',
              fontSize: 32,
            ),),
            const Text('Añade lugares a tu ruta, agenda el día y te generaremos tu ruta personalizada', style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w300,
            ),),
            const Fecha(),
            const Text('Tus lugares añadidos a la ruta:', style: TextStyle(
              fontFamily: 'Monserrat',
              fontSize: 20,
            ),),
            SizedBox(
              height: alto*0.6,
              child: const Visor(),
            ),
            BotonesInf(ancho: ancho),
          ],
        ),
      ),
    );
  }
}

class Fecha extends StatelessWidget {
  const Fecha({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Wrap(
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
                firstDate: DateTime(date.year-10),
                lastDate: DateTime(date.year+10),
              );
            },
            icon: const Icon(Icons.keyboard_arrow_down),
            label: Text('${date.day}/${date.month}/${date.year}'),
          ),
        ],
      ),
    );
  }
}

class Visor extends StatelessWidget {
  const Visor({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...lugares.map((lugar) => Tarjeta(url: lugar['imagen'], nombre: lugar['nombre'], fecha: lugar['fecha']))
        ],
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

class BotonesInf extends StatelessWidget {

  final double ancho;

  const BotonesInf({super.key, required this.ancho});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 10,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: const Color.fromRGBO(17, 76, 95, 1),
            child: InkWell(
              onTap: (){},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ancho*0.33, vertical: 10),
                child: const Text('Generar Ruta', style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontSize: 15,
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
              onTap: () async{
                //await Share.share('Hola', subject: 'Prueba');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ancho*0.101, vertical: 10),
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
                padding: EdgeInsets.symmetric(horizontal: ancho*0.101, vertical: 10),
                child: const Text('Buscar sugerencias', style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 12,
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}