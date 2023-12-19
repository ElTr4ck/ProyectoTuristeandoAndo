import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/models/users/user.dart' as model;
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/firestore_methods.dart';
import 'package:turisteando_ando/repositories/auth/storage_methods.dart';
import 'package:http/http.dart' as http;
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import '../frmrese_a_tab_container_screen/frmrese_a_tab_container_screen2.dart';

class FrmnewreseAScreen extends StatefulWidget {
  final String id;
  const FrmnewreseAScreen({required this.id, Key? key}) : super(key: key);

  @override
  State<FrmnewreseAScreen> createState() => _FrmnewreseAScreenState();
}

class _FrmnewreseAScreenState extends State<FrmnewreseAScreen> {
  late Future<String> placeNameFuture;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<model.User?> userFuture;
  String name = "";
  int calificacion = 5;
  String lastname = "";
  String avatar = "";
  Uint8List? _file;
  model.User? infoUser;
  TextEditingController comentarioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("ID del lugar: " + widget.id);
    // Llama a fetchPlaceName y guarda el Future
    placeNameFuture = fetchPlaceName(widget.id);
    userFuture = getUser();
    // Resto de tu código...
  }

  Future<model.User> getUser() async {
    try {
      model.User data = await AuthMethods().getUserDetails();
      name = data.name;
      lastname = data.lastName;
      avatar = data.photo;
      infoUser = data;
      return data;
    } catch (e) {
      print('Error al obtener información del usuario: $e');
      throw e; // Re-lanza la excepción para que sea capturada por FutureBuilder
    }
  }

  Future<Map<String, dynamic>> fetchPlaceDetailsFromApi(String placeId) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data['result'];

      // Obteniendo el nombre y la calificación del lugar
      String title = result['name']; // Nombre del lugar
      double rating = result['rating'] ??
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

  Future<String> fetchPlaceName(String id) async {
    try {
      Map<String, dynamic> placeDetails = await fetchPlaceDetailsFromApi(id);
      return placeDetails['title'];
    } catch (e) {
      print('Excepción al obtener el nombre del lugar: ${e.toString()}');
      return 'Error al buscar el nombre del lugar';
    }
  }

  List<Uint8List> _images = [];

  bool _isLoading = false; //variable para mostrar CircularProgressIndicator

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 20.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 286.h,
                          margin: EdgeInsets.only(left: 18.h, right: 19.h),
                          child: Text(
                              "¡Nos encantaría conocer tu opinión acerca de este lugar! Comparte tu experiencia y ayuda a otros a descubrir lo que hace especial a este destino.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium)),
                      SizedBox(height: 35.v),
                      _buildReview(context),
                      Spacer(),
                      CustomElevatedButton(
                        width: 104.h,
                        text: "Agregar fotos",
                        buttonStyle: CustomButtonStyles.fillTealTL12,
                        buttonTextStyle: theme.textTheme.labelMedium!,
                        onPressed: () async {
                          Uint8List file = await StorageMethods()
                              .pickImage(ImageSource.gallery);
                          _images.add(file);
                          setState(() {});
                          print("Subido");
                        },
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.memory(_images[index]),
                            );
                          },
                        ),
                      ),
                      Text("Califica este lugar",
                          style: theme.textTheme.titleLarge),
                      SizedBox(height: 15.v),
                      Container(
                          margin: EdgeInsets.only(
                              left: 61.h, right: 64.h, bottom: 12.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.h, vertical: 10.v),
                          decoration: AppDecoration.fillErrorContainer1
                              .copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder27),
                          child: CustomRatingBar(
                            initialRating: 5,
                            onRatingUpdate: (rating) {
                              print(rating);
                              calificacion = rating.toInt();
                            },
                            itemSize: 34,
                            color: appTheme.yellow700,
                          )),
                      SizedBox(height: 25.v),
                      CustomElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              DocumentReference reviewDocRef =
                                  await StoreMethods().review(
                                      idplace: widget.id,
                                      comentario: comentarioController.text,
                                      calificacion: calificacion,
                                      fecha: Timestamp.fromDate(DateTime.now()),
                                      nombre: name,
                                      files: _images);

                              // ignore: use_build_context_synchronously
                              print("entro");
                              Navigator.pop(context);
                            }
                          },
                          text: _isLoading
                              ? '     Cargando'
                              : 'Aceptar', //condiciones para CircularProgressIndicator
                          leftIcon: _isLoading
                              ? const SizedBox(
                                  width: 5,
                                  height: 5,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          margin: EdgeInsets.only(left: 44.h, right: 45.h),
                          buttonStyle: CustomButtonStyles.fillPrimaryTL16),
                      SizedBox(height: 15.v),
                      CustomElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: "Cancelar",
                          margin: EdgeInsets.only(left: 44.h, right: 45.h),
                          buttonStyle: CustomButtonStyles.fillTealTL16),
                      SizedBox(height: 2.v)
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 23.h,
      // leading: AppbarLeadingImage(
      //     imagePath: ImageConstant.imgArrowDown2,
      //     margin: EdgeInsets.only(left: 18.h, top: 5.v, bottom: 41.v),
      //     onTap: () {
      //       Navigator.of(context)
      //           .push(MaterialPageRoute(builder: (BuildContext context) {
      //         //String aux = '${prediction.lat}, ${prediction.lng}';
      //         return FrmreseATabContainerScreen2(id: widget.id);
      //       }));
      //     }),
      leading: Padding(
          padding: EdgeInsets.only(top: 7.v, bottom: 16.v),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  //String aux = '${prediction.lat}, ${prediction.lng}';
                  return FrmreseATabContainerScreen2(id: widget.id, index: 0,);
                }));
              },
              child: Icon(
                Icons.arrow_back_outlined,
                size: 30.h,
                color: Colors.grey,
              ))),
      centerTitle: true,
      title: FutureBuilder<String>(
        future: placeNameFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // mostrar un indicador de carga
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            return AppbarSubtitleTwo(text: snapshot.data!);
          }
        },
      ),
    );
  }

  /// Section Widget
  /// Section Widget
  Widget _buildReview(BuildContext context) {
    return FutureBuilder<model.User?>(
      future: userFuture,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text(
              'Error al obtener información del usuario: ${snapshot.error}');
        } else {
          return Container(
              width: 317.h,
              margin: EdgeInsets.only(right: 7.h),
              padding: EdgeInsets.all(12.h),
              decoration: AppDecoration.fillGray
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder33),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 17,
                              backgroundImage: NetworkImage(avatar),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 6.h, top: 5.v, bottom: 7.v),
                                child: Text(name + " " + lastname,
                                    style: theme.textTheme.titleMedium))
                          ]),
                      SizedBox(height: 8.v),
                      Container(
                          width: 277.h,
                          margin: EdgeInsets.only(right: 15.h),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration.collapsed(
                                hintText: "Comparte tu experiencia"),
                            minLines:
                                3, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: comentarioController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo obligatorio";
                              }
                              return null;
                            },
                          )),
                      SizedBox(height: 15.v)
                    ]),
              ));
        }
      },
    );
  }
}
