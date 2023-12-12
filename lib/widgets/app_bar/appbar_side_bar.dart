import 'package:flutter/material.dart';
import 'package:turisteando_ando/models/users/user.dart' as model;
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/controlers/signout_controller.dart';
import 'package:turisteando_ando/repositories/auth/wrapper.dart';
import 'package:turisteando_ando/routes/app_routes.dart';

class SideBar extends StatefulWidget {
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String name = "";

  String lastname = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    model.User data = await AuthMethods().getUserDetails();
    setState(() {
      name = data.name;
      lastname = data.lastName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controllerSignOut = SignoutController(context: context);

    Future<void> signOut() async {
      await controllerSignOut.signout();
    }

    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF114C5F),
            ),
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  name + lastname, //Modificar el nombre de acuerdo a la BD
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
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.frm_ruta_propia);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.star,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
              'Ruta destacada',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.frmRutaDestacada);
            },
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
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: Text(
              'Cerrar sesión',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () async {
              await signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => new Wrapper()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
