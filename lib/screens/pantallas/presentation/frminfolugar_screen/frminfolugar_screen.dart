import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import '../frminfolugar_screen/widgets/componentlugares_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_page/frminicio_page.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:turisteando_ando/pantallas/rutaUno.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmrese_a_tab_container_screen/frmrese_a_tab_container_screen2.dart';
import 'package:turisteando_ando/screens/frm_ruta_propia.dart';

// ignore_for_file: must_be_immutable
class FrminfolugarScreen extends StatefulWidget {
  final String id;

  FrminfolugarScreen({required this.id, Key? key}) : super(key: key);

  @override
  _FrminfolugarScreenState createState() => _FrminfolugarScreenState();
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

class _FrminfolugarScreenState extends State<FrminfolugarScreen> {
  Map<String, dynamic>? jsonData;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Tu lógica para obtener datos desde la API
    String url =
        'https://places.googleapis.com/v1/places/${widget.id}?fields=rating,websiteUri,regularOpeningHours,displayName,formattedAddress,nationalPhoneNumber,editorialSummary,photos,id&languageCode=es&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
    // Los datos que enviarás en el cuerpo de la solicitud POST

    print("Hola");
    // Las cabeceras de la solicitud
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM',
      // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask': 'id,displayName',
    };

    // Realiza la solicitud POST
    try {
      var response = await http.get(
        Uri.parse(url),
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta aquí
        print('Respuesta exitosa: ${response.body}');
        Map<String, dynamic> jsonData = json.decode(response.body);
        //print('${jsonData["places"][0]["displayName"]["text"]}');
        //print('${jsonData["places"][0]["formattedAddress"]}');
      } else {
        // Hubo un error en la solicitud, puedes manejarlo aquí
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      // Maneja las excepciones que puedan ocurrir durante la solicitud
      print('Error: $e');
    }
    try {
      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        setState(() {
          jsonData = json.decode(response.body);
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget build(BuildContext context) {
    // Verifica si jsonData no es nulo
    if (jsonData != null) {
      print(jsonData);
      mediaQueryData = MediaQuery.of(context);
      return SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(context),
          body: Container(
            width: double.infinity,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(jsonData?["displayName"]["text"],
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 20, 76, 95),
                                fontFamily: 'Nunito',
                              )),
                        )),
                    SizedBox(height: 5.v),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            //margin: EdgeInsets.only(left: 14.h, right: 35.h),
                            child: Text(jsonData?["formattedAddress"],
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Nunito',
                                )))),
                    //_buildComponentLugares(context),
                    SizedBox(height: 21.v),
                    _buildFortyTwo(context),
                    SizedBox(height: 20.v),
                    _buildComponentAcciones(context),
                    SizedBox(height: 10.v),
                    _buildComponentAcciones2(context),
                    SizedBox(height: 10.v),
                    _buildComponentInfo(context),
                    SizedBox(height: 9.v),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Si jsonData es nulo, puedes devolver un indicador de carga o lo que prefieras
      return CustomCircularProgressIndicator(size: 1.0);
    }
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 60.v,
      leadingWidth: 24.h,
      leading: Padding(
          padding: EdgeInsets.only(top: 7.v, bottom: 16.v),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(
                    context); //pop para no volver a cargar la pantalla
              },
              child: Icon(
                Icons.arrow_back_outlined,
                size: 30.h,
                color: Colors.grey,
              ))),
    );
  }

  /// Section Widget
  Widget _buildComponentLugares(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
            height: 22.v,
            child: ListView.separated(
                padding: EdgeInsets.only(left: 19.h),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 5.h);
                },
                itemCount: 7,
                itemBuilder: (context, index) {
                  return ComponentlugaresItemWidget();
                })));
  }

  /// Section Widget
  Widget _buildFortyTwo(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.network(
              'https://places.googleapis.com/v1/${jsonData?["photos"][0]["name"]}/media?maxHeightPx=400&maxWidthPx=400&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM',
              height: 231.v,
              width: 188.h,
              fit: BoxFit.cover, // Ajusta según tus necesidades
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // La imagen se cargó con éxito
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
            ),
          ),
          Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.network(
                'https://places.googleapis.com/v1/${jsonData?["photos"][1]["name"]}/media?maxHeightPx=400&maxWidthPx=400&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM',
                height: 109.v,
                width: 142.h,
                fit: BoxFit.cover, // Ajusta según tus necesidades
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // La imagen se cargó con éxito
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 7.v),
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.network(
                'https://places.googleapis.com/v1/${jsonData?["photos"][2]["name"]}/media?maxHeightPx=400&maxWidthPx=400&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM',
                height: 115.v,
                width: 142.h,
                fit: BoxFit.cover, // Ajusta según tus necesidades
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // La imagen se cargó con éxito
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
              ),
            )
          ])
        ]));
  }

  /// Section Widget
  Widget _buildComponentAcciones2(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 5.v),
            decoration: AppDecoration.fillErrorContainer1
                .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: appTheme.yellow700,
                ),
                SizedBox(
                    width:
                        5), // Ajusta el espacio entre la estrella y el número
                Text(
                  '${jsonData?["rating"]}', // Puedes cambiar esto al número que desees
                  style: TextStyle(
                    fontSize: 16.0, // Ajusta el tamaño del número
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Puedes cambiar el color del número
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          CustomElevatedButton(
              height: 24.v,
              width: 125.h,
              text: "Reseñas",
              margin:
                  EdgeInsets.only(right: 13.h), //ChIJeTrFnori0YURXup_x_Ws2t8
              buttonStyle: CustomButtonStyles.fillPrimary,
              buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
              onPressed: () {
                print('Elemento del carrusel presionado: ${widget.id}');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  //String aux = '${prediction.lat}, ${prediction.lng}';
                  return FrmreseATabContainerScreen2(
                    id: widget.id,
                    index: 0,
                  );
                }));
              },
              alignment: Alignment.bottomRight),
        ]));
  }

  Widget _buildComponentAcciones(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.h),
        child: Center(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            CustomElevatedButton(
              height: 24.v,
              width: 80.h,
              text: "Ruta",
              //margin: EdgeInsets.only(left: 23.h),
              leftIcon: Container(
                  margin: EdgeInsets.only(right: 6.h),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgFlechita,
                      height: 12.adaptSize,
                      width: 12.adaptSize)),
              buttonStyle: CustomButtonStyles.fillPrimary,
              buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  //String aux = '${prediction.lat}, ${prediction.lng}';
                  return MyApp(jsonData?["displayName"]["text"] as String);
                }));
                // Agrega la lógica que deseas ejecutar cuando se presiona el botón
              },
            ),
            CustomElevatedButton(
              height: 24.v,
              width: 110.h,
              text: "Itinerario",
              //margin: EdgeInsets.only(left: 23.h),
              leftIcon: Container(
                  margin: EdgeInsets.only(right: 6.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgFrameAgregarruta,
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                    color: Colors.white,
                  )),
              buttonStyle: CustomButtonStyles.fillTeal,
              buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
              onPressed: () async{
              DateTime hoy = DateTime.now();
              DateTime? it = await showDatePicker(
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
                initialDate: hoy,
                firstDate: DateTime(hoy.year-10),
                lastDate: DateTime(hoy.year+10),
              );
              if(it != null){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FrmRutaPropia(it)));
                guardarEnItinerario(widget.id, it);
              }
              
            },
            ),
            HeartButtonV2(itemId: widget.id),
            Hecho(itemId: widget.id),
            
          ]),
        ));
  }

  /// Section Widget
  Widget _buildComponentInfo(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 5.v),
        decoration:
            BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 3.v),
          Container(
              height: 2.v,
              width: 32.h,
              decoration: BoxDecoration(
                  color: appTheme.blueGray100,
                  borderRadius: BorderRadius.circular(1.h))),
          SizedBox(height: 3.v),
          /* Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 15.h),
                  child: Text(jsonData?["displayName"]["text"],
                      style: theme.textTheme.titleMedium))),
          SizedBox(height: 3.v),
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: 266.h,
                  margin: EdgeInsets.only(left: 14.h, right: 35.h),
                  child: Text(jsonData?["formattedAddress"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodySmallDMSansOnError
                          .copyWith(height: 1.80)))),
          SizedBox(height: 2.v), */
          SizedBox(
              height: 23.v,
              width: 312.h,
              child: Stack(alignment: Alignment.bottomLeft, children: [
                SizedBox(height: 5.v),
                /* Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(width: 307.h, child: Divider())), */
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Detalles",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 20, 76, 95),
                          fontFamily: 'Nunito',
                        )))
              ])),
          //SizedBox(height: 8.v),
          SizedBox(
              height: 320.v,
              width: 315.h,
              child: Stack(alignment: Alignment.topCenter, children: [
                /*CustomElevatedButton(
                    height: 16.v,
                    width: 53.h,
                    text: "Reseñas",
                    margin: EdgeInsets.only(
                        right: 13.h), //ChIJeTrFnori0YURXup_x_Ws2t8
                    buttonStyle: CustomButtonStyles.fillTeal,
                    buttonTextStyle: theme.textTheme.labelSmall!,
                    onPressed: () {
                      print('Elemento del carrusel presionado: ${widget.id}');
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        //String aux = '${prediction.lat}, ${prediction.lng}';
                        return FrmreseATabContainerScreen2(
                          id: widget.id,
                          index: 0,
                        );
                      }));
                    },
                    alignment: Alignment.bottomRight),*/
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: 315.h,
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "${jsonData?["editorialSummary"] != null ? '${jsonData?["editorialSummary"]["text"]}' : 'No hay una descripción disponible para este lugar.'}\n\n",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Nunito',
                                    color: Colors.black,
                                  )),
                              TextSpan(
                                  text:
                                      '${jsonData?["regularOpeningHours"] != null ? '${jsonData?["regularOpeningHours"]["openNow"] == true ? 'Abierto: \n' : 'Cerrado: \n'}' : 'No se conoce el estado actual del lugar (Abierto/Cerrado) \n'}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                    color:
                                        jsonData?["regularOpeningHours"] != null
                                            ? (jsonData?["regularOpeningHours"]
                                                        ["openNow"] ==
                                                    true
                                                ? Colors.green
                                                : Colors.red)
                                            : Colors.red,
                                  )),
                              TextSpan(
                                text:
                                    "${jsonData?["regularOpeningHours"] != null ? '${jsonData?["regularOpeningHours"]["weekdayDescriptions"][0]}\n${jsonData?["regularOpeningHours"]["weekdayDescriptions"][1]}\n${jsonData?["regularOpeningHours"]["weekdayDescriptions"][2]}\n${jsonData?["regularOpeningHours"]["weekdayDescriptions"][3]}\n${jsonData?["regularOpeningHours"]["weekdayDescriptions"][4]}\n${jsonData?["regularOpeningHours"]["weekdayDescriptions"][5]}\n${jsonData?["regularOpeningHours"]["weekdayDescriptions"][6]}.' : 'No hay una descripción de horarios disponibles para este lugar.'}\n\n${jsonData?["nationalPhoneNumber"] != null ? '${jsonData?["nationalPhoneNumber"]}\n' : 'No hay un número de contacto disponible para este lugar.\n'}\n",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Nunito',
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text:
                                    "${jsonData?["websiteUri"] != null ? '${jsonData?["websiteUri"]}' : 'No se tiene una página de contacto'}",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  color: Color(0xFF114C5F), // Color del enlace
                                  decoration: TextDecoration
                                      .underline, // Subrayado del enlace
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final Uri _url =
                                        Uri.parse(jsonData?["websiteUri"]);
                                    if (!await launchUrl(_url)) {
                                      throw Exception('Could not launch $_url');
                                    }
                                  },
                              ),
                            ]),
                            textAlign: TextAlign.justify)))
              ]))
        ]));
  }

  /// Section Widget
  Future<void> guardarEnItinerario(String lugarId, DateTime sel) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var fechaActual = sel; // Obtiene la fecha y hora actual
      var docRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('itinerario')
          .doc(lugarId);
      try {
        var doc = await docRef.get();
        if (!doc.exists) {
          await docRef.set({
            'id': lugarId,
            'fechaSeleccionado':
                DateTime(fechaActual.year, fechaActual.month, fechaActual.day)
                    .toIso8601String()
          });
          print('Lugar guardado con éxito en el itinerario');
        } else {
          print('El lugar ya está en el itinerario');
        }
      } catch (e) {
        print('Error al guardar en el itinerario: $e');
      }
    } else {
      print('Usuario no autenticado');
    }
  }

  /// Navigates to the frmmarcadoresScreen when the action is triggered.
  onTapRegresar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmmarcadoresScreen);
  }

  /// Navigates to the frmnewreseAScreen when the action is triggered.
  onTapReseas(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmnewreseAScreen);
  }
}

class HeartButtonV2 extends StatefulWidget {
  final String itemId;
  HeartButtonV2({required this.itemId});

  @override
  _HeartButtonStateV2 createState() => _HeartButtonStateV2();
}
class _HeartButtonStateV2 extends State<HeartButtonV2> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorited();
  }

  void checkIfFavorited() async {
    // Lógica para verificar si el ítem está en los favoritos del usuario
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('favoritos')
          .doc(widget.itemId)
          .get();

      setState(() {
        isFavorited = doc.exists;
      });
    }
  }

  void toggleFavorite() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var docRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('favoritos')
          .doc(widget.itemId);

      if (isFavorited) {
        // Si ya es favorito, eliminar de la base de datos
        await docRef.delete();
      } else {
        // Si no es favorito, agregar a la base de datos
        await docRef.set({'id': widget.itemId});
      }

      setState(() {
        isFavorited = !isFavorited;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
      color: isFavorited ? Colors.red : Colors.black87, // Color del icono según el estado
      onPressed: toggleFavorite, // Llamada a la función para cambiar el estado
      iconSize: 27.0, // Tamaño del icono
    );
  }
}

class Hecho extends StatefulWidget {
  final String itemId;
  Hecho({required this.itemId});

  @override
  _Hecho createState() => _Hecho();
}
class _Hecho extends State<Hecho> {
  bool isAcompletado = false;

  @override
  void initState() {
    super.initState();
    checkIfAcompletado();
  }

  void checkIfAcompletado() async {
    // Lógica para verificar si el ítem está en los favoritos del usuario
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('ViajeCompleto')
          .doc(widget.itemId)
          .get();

      setState(() {
        isAcompletado = doc.exists;
      });
    }
  }

  void toggleFavorite() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var docRef = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('ViajeCompleto')
          .doc(widget.itemId);

      if (isAcompletado) {
        // Si ya es favorito, eliminar de la base de datos
        await docRef.delete();
      } else {
        // Si no es favorito, agregar a la base de datos
        await docRef.set({'id': widget.itemId});
      }

      setState(() {
        isAcompletado = !isAcompletado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isAcompletado ? Icons.add_location_alt_outlined : Icons.add_location_alt_outlined),
      color: isAcompletado ? Colors.blue : Colors.black87, // Color del icono según el estado
      onPressed: toggleFavorite, // Llamada a la función para cambiar el estado
      iconSize: 27.0, // Tamaño del icono
    );
  }
}