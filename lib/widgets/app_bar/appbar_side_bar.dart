import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF114C5F),
            ),
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  'Ramses Federico',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                ),
                Text(
                  'Turisteando Ando',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                ),
              ],
            ),
            alignment: Alignment.center,
          ),
          ListTile(
            leading: Icon(
              Icons.save,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'Por visitar',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/frmporvisitar_screen');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.update,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'Reciente',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.rate_review,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'Tus reseñas',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'Compartir',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.place,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'Rutas',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer_rounded,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'FAQs',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'Idioma',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.contact_support,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'Obtener ayuda',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
