import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turisteando_ando/core/app_export.dart';

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
        "Museos", "Obras contemporáneas y nacionales.", Icons.account_balance),
    ElementItem("Cines", "El séptimo arte, más explicación no hay.",
        Icons.local_movies),
    ElementItem(
        "Parques", "Una caminata tranquila, ¿por qué no?.", Icons.park_rounded),
    ElementItem("Exposiciones", "Siempre se puede descubrir algo nuevo.",
        FontAwesomeIcons.palette),
    ElementItem("Conciertos", "Artistas, bandas y las mejores experiencias.",
        Icons.my_library_music),
    ElementItem("Hoteles", "Los mejores hospedajes y buffetes.",
        FontAwesomeIcons.hotel),
    ElementItem("Alimentos", "Recuerda que panza llena, corazón contento.",
        Icons.fastfood),
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
                  'Elige tus tipos de lugares favoritos y disfruta de recomendaciones personalizadas',
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
                  // Lógica para el botón "Finalizar"
                },
                child: const Text(
                  'Recordarmelo más tarde',
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
  bool isLiked = false;

  ElementItem(this.name, this.subtitle, this.icon);

  @override
  _ElementItemState createState() => _ElementItemState();
}

class _ElementItemState extends State<ElementItem> {
  @override
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
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 16,
          ),
        ),
        leading: Icon(widget.icon),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.favorite,
                color: widget.isLiked ? Colors.red : Colors.grey,
              ),
              onTap: () {
                setState(() {
                  widget.isLiked = !widget.isLiked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
