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
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  "$name $lastname", //Modificar el nombre de acuerdo a la BD
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                ),
                const Text(
                  'Turisteando Ando',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.save,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
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
            leading: const Icon(
              Icons.update,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
              'Reciente',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(
              Icons.rate_review,
              color:  Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
              'Tus reseñas',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.frmtusreseAsScreen);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share,
              color:Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
              'Compartir',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(
              Icons.place,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
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
            leading: const Icon(
              Icons.question_answer_rounded,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
              'FAQs',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.frmfaqsScreen);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color:  Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
              'Preferencias',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.frmCuestionario);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
              'Idioma',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_support,
              color:Color.fromARGB(255, 128, 128, 128),
            ),
            title:const Text(
              'Obtener ayuda',
              style: TextStyle(
                fontFamily: 'Nunito',
              ),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: const Color.fromARGB(255, 128, 128, 128),
            ),
            title: const Text(
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
