import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FrmCuestionario extends StatelessWidget {
  const FrmCuestionario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ElementList());
  }
}

class ElementList extends StatefulWidget {
  @override
  _ElementListState createState() => _ElementListState();
}

class _ElementListState extends State<ElementList> {
  List<ElementItem> elements = [
    ElementItem(
      icon: Icons.account_balance,
      name: "Museos",
      subtitle: "Obras contemporáneas y nacionales.",
      isLiked: ValueNotifier<bool>(false),
    ),
    ElementItem(
      icon: Icons.local_movies,
      name: "Cines",
      subtitle: "El séptimo arte, más explicación no hay.",
      isLiked: ValueNotifier<bool>(false),
    ),
    ElementItem(
      icon: Icons.park_rounded,
      name: "Parques",
      subtitle: "Una caminata tranquila, ¿por qué no?.",
      isLiked: ValueNotifier<bool>(false),
    ),
    ElementItem(
      icon: FontAwesomeIcons.palette,
      name: "Galerías de arte",
      subtitle: "Siempre se puede descubrir algo nuevo.",
      isLiked: ValueNotifier<bool>(false),
    ),
    ElementItem(
      icon: Icons.set_meal,
      name: "Acuarios",
      subtitle: "Bellos animales acuáticos, no te lo puedes perder!",
      isLiked: ValueNotifier<bool>(false),
    ),
    ElementItem(
      icon: Icons.cruelty_free,
      name: "Zoológicos",
      subtitle: "Disfruta de la naturaleza como nunca antes!",
      isLiked: ValueNotifier<bool>(false),
    ),
    ElementItem(
      icon: FontAwesomeIcons.hotel,
      name: "Hoteles",
      subtitle: "Los mejores hospedajes y buffetes.",
      isLiked: ValueNotifier<bool>(false),
    ),
    ElementItem(
      icon: Icons.fastfood,
      name: "Alimentos",
      subtitle: "Recuerda que panza llena, corazón contento.",
      isLiked: ValueNotifier<bool>(false),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Personaliza tus preferencias',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Nunito',
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  'Selecciona tus lugares preferidos y experimenta recomendaciones personalizadas según tus gustos.',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        ...elements,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF114C5F),
                  foregroundColor: Colors.white,
                  minimumSize: Size(400,
                      60), // Ajusta el ancho (200) y el alto (50) del botón
                  padding: const EdgeInsets.all(16.0), // Relleno
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Borde redondeado
                  ),
                ), //Style
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.frminicioContainerScreen);
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
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF9CD2D3),
                  onPrimary: Colors.white,
                  minimumSize: Size(400,
                      60), // Ajusta el ancho (200) y el alto (50) del botón
                  padding: const EdgeInsets.all(16.0), // Relleno
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Borde redondeado
                  ),
                ), //Style
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.frminicioContainerScreen);
                },
                child: const Text(
                  'Recordar más tarde',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ElementItem extends StatefulWidget {
  final String name;
  final String subtitle;
  final IconData icon;
  final ValueNotifier<bool> isLiked;

  ElementItem({
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.isLiked,
  });

  @override
  _ElementItemState createState() => _ElementItemState();
}

class _ElementItemState extends State<ElementItem> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    var nombre;
    if (widget.name == "Museos") {
      nombre = "museum";
    } else if (widget.name == "Cines") {
      nombre = "movie_theater";
    } else if (widget.name == "Parques") {
      nombre = "park";
    } else if (widget.name == "Galerías de arte") {
      nombre = "art_gallery";
    } else if (widget.name == "Acuarios") {
      nombre = "aquarium";
    } else if (widget.name == "Zoológicos") {
      nombre = "zoo";
    } else if (widget.name == "Hoteles") {
      nombre = "hotel";
    } else if (widget.name == "Alimentos") {
      nombre = "restaurant";
    }

    DocumentReference docRef = _firestore
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .collection('preferencias')
        .doc(nombre);

    var docSnapshot = await docRef.get();

    setState(() {
      widget.isLiked.value = docSnapshot.exists;
    });
  }

  Widget build(BuildContext context) {
    

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFFEEF8F6),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(2),
        title: Text(
          widget.name,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        leading: Icon(widget.icon),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: ValueListenableBuilder<bool>(
                valueListenable: widget.isLiked,
                builder: (context, value, child) {
                  return Icon(
                    Icons.favorite,
                    color: value ? Colors.red : Colors.grey,
                  );
                },
              ),
              onTap: () async {
                var nombre;
                if (widget.name == "Museos") {
                  nombre = "museum";
                } else if (widget.name == "Cines") {
                  nombre = "movie_theater";
                } else if (widget.name == "Parques") {
                  nombre = "park";
                } else if (widget.name == "Galerías de arte") {
                  nombre = "art_gallery";
                } else if (widget.name == "Acuarios") {
                  nombre = "aquarium";
                } else if (widget.name == "Zoológicos") {
                  nombre = "zoo";
                } else if (widget.name == "Hoteles") {
                  nombre = "hotel";
                } else if (widget.name == "Alimentos") {
                  nombre = "restaurant";
                }

                DocumentReference docRef = _firestore
                    .collection('usuarios')
                    .doc(_auth.currentUser!.uid)
                    .collection('preferencias')
                    .doc(nombre);

                var docSnapshot = await docRef.get();

                if (docSnapshot.exists) {
                  // El documento ya existe, así que lo eliminamos
                  await docRef.delete();
                } else {
                  // El documento no existe, así que lo creamos
                  await docRef.set({'nombre': nombre});
                }
                setState(() {
                  widget.isLiked.value = !widget.isLiked.value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
