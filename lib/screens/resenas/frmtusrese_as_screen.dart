import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turisteando_ando/models/users/user.dart' as model;
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/utils.dart';
import '../resenas/widgets/srcoll_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';

class FrmtusreseAsScreen extends StatefulWidget {
  const FrmtusreseAsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<FrmtusreseAsScreen> createState() => _FrmtusreseAsScreenState();
}

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size; // Tamaño personalizado del indicador

  CustomCircularProgressIndicator({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF114C5F)),
          strokeWidth: 6.0,
          backgroundColor: Colors.grey,
          // Utiliza el parámetro radius para ajustar el tamaño del indicador
          // El valor por defecto es 10.0
          // Puedes ajustar este valor según tus necesidades
          value: size / 10.0,
        ),
      ),
    );
  }
}

class _FrmtusreseAsScreenState extends State<FrmtusreseAsScreen> {
  List<Map<String, dynamic>> listaDatos =
      []; //guarda las reviews que ha hecho el usuario
  List<Map<String, dynamic>> places =
      []; //guarda la informacion del lugar de cada review
  model.User? user;
  @override
  void initState() {
    super.initState();
    fetchReviews();

    fetchUser();
  }

  void update(index) {
    //borrar un widget sin reiniciar la pantalla
    setState(() {
      listaDatos.removeAt(index);
      places.removeAt(index);
    });
    if (listaDatos.isEmpty) {
      Navigator.of(context).pop();
      showSnackBar("Sin reseñas", context);
    }
  }

  Future<void> fetchUser() async {
    //obtengo los datos del usuario
    try {
      model.User data = await AuthMethods().getUserDetails();
      print('user: $user');
      setState(() {
        user = data;
      });
    } catch (e) {
      print('Error al obtener información del usuario: $e');
      throw e; // Re-lanza la excepción para que sea capturada por FutureBuilder
    }
  }

  Future<List<Map<String, dynamic>>> fetchReviews() async {
    //obtengo todas sus reviews
    try {
      listaDatos.clear();

      QuerySnapshot<Map<String, dynamic>> reviewsSnapshot =
          await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('reviews')
              .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> reviewsDocumentos =
          reviewsSnapshot.docs;

      for (QueryDocumentSnapshot<Map<String, dynamic>> reviewDocumento
          in reviewsDocumentos) {
        Map<String, dynamic> review = reviewDocumento.data();
        review['id'] =
            reviewDocumento.id; //necesito saber su id para eliminar la review
        listaDatos.add(review);
      }
      print(listaDatos);
      fetchPlace();
      return listaDatos;
    } catch (e) {
      print('Error al obtener preferencias: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchPlaceDetailsFromApi(String placeId) async {
    //obtengo los datos del lugar de la review
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data['result'];

      // Obteniendo el nombre y la calificación del lugar
      String title = result['name']; // Nombre del lugar
      double rating = result['rating'].toDouble() ??
          0.0; // Calificación del lugar, 0.0 si no está disponible

      // Construyendo la descripción con la calificación
      String description = '${rating.toStringAsFixed(1)}';

      // URL de la imagen del lugar
      String imageUrl = result['photos'] != null
          ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${result['photos'][0]['photo_reference']}&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM'
          : 'URL_imagen_por_defecto';

      return {'title': title, 'description': description, 'image': imageUrl};
    } else {
      return {
        'title': 'Información no disponible',
        'description': 'No se pudo obtener la descripción',
        'image': 'url_de_imagen_por_defecto'
      };
    }
  }

  fetchPlace() async {
    List<Map<String, dynamic>> aux = [];
    for (Map<String, dynamic> dato in listaDatos) {
      aux.add(await fetchPlaceDetailsFromApi(
          dato['idplace'])); //obtengo los datos del lugar
    }
    setState(() {
      places.addAll(aux);
    });
    if (places.isEmpty) {
      Navigator.of(context).pop();
      showSnackBar("Sin reseñas", context);
    }
    print('places: $places');
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    if (user != null && listaDatos.isNotEmpty && places.isNotEmpty) {
      return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 21.h),
            child: Column(
              children: [
                SizedBox(height: 1.v),
                Container(
                  width: 285.h,
                  margin: EdgeInsets.only(
                    left: 17.h,
                    right: 15.h,
                  ),
                  child: Text(
                    "Explora todas las reseñas que has creado. \n\n ¡Gracias por contribuir con tus valiosas opiniones!",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: 20.v),
                _buildSrcoll(context),
              ],
            ),
          ),
        ),
      );
    } else {
      return CustomCircularProgressIndicator(size: 1.0);
    }
  }

  /// Section Widget
  /*PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 70.v,
      leadingWidth: 23.h,
      leading: Padding(
          padding: EdgeInsets.only(top: 7.v, bottom: 16.v),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  //String aux = '${prediction.lat}, ${prediction.lng}';
                  return FrminicioPage();
                }));
              },
              child: Icon(
                Icons.arrow_back_outlined,
                size: 30.h,
                color: Colors.grey,
              ))),
      centerTitle: true,
      title: AppbarTitle(
        text: "Tus reseñas",
      ),
    );
  }*/
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 60.v,
        leadingWidth: 24.h,
        leading: Padding(
            padding: EdgeInsets.only(top: 7.v, bottom: 16.v),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_outlined,
                  size: 30.h,
                  color: Colors.grey,
                ))),
        centerTitle: true,
        title: Text(
          "Información del lugar",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Nunito'),
        ));
  }

  /// Section Widget
  Widget _buildSrcoll(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 1.h),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 20.v,
            );
          },
          itemCount: listaDatos.length, //check the dinamic scroll
          //number controller
          itemBuilder: (context, index) {
            return SrcollItemWidget(
                //genero todos los widgets
                place: places[index], //informacion del lugar
                user: user, //informacion del usuario
                review: listaDatos[index], //informacion de la review
                update: update, //fucion para actualizar la lista
                index: index); //index para eleminar el item
          },
        ),
      ),
    );
  }
}
