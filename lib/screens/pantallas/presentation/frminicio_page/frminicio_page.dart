import 'package:get/get.dart';
import 'dart:convert';
import 'package:turisteando_ando/repositories/auth/controlers/signout_controller.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmwelcome_screen/frmwelcome_screen.dart';

import '../frminicio_page/widgets/ninety_item_widget.dart';
import '../frminicio_page/widgets/recommended_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_drop_down.dart';
import 'package:turisteando_ando/widgets/custom_search_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminfolugar_screen/frminfolugar_screen.dart';

// ignore_for_file: must_be_immutable
class FrminicioPage extends StatelessWidget {
  FrminicioPage({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController searchController = TextEditingController();

  final controller = Get.put(SignoutController());

  void signout() async {
    await controller.signout();
    Get.to(FrmwelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillOnPrimary,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30.v),
                    child: ListView(
                      children: [
                        Column(children: [
                          SizedBox(height: 2.v),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 5.h),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            signout();
                                          },
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.only(right: 50),
                                          ),
                                          child: const Text(
                                            'Cerrar sesión',
                                            style: TextStyle(
                                              color: Colors.red, // Color rojo
                                              fontSize:
                                                  14.0, // Tamaño de fuente
                                              fontWeight:
                                                  FontWeight.bold, // Negrita
                                            ),
                                          ),
                                        ),
                                        Text("Bienvenido",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',)),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 41.h),
                                            child: CustomDropDown(
                                                width: 93.h,
                                                icon: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 6.h),
                                                    child: CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgArrowdown,
                                                        height: 16.adaptSize,
                                                        width: 16.adaptSize)),
                                                hintText: "UserNameXx",
                                                items: dropdownItemList,
                                                onChanged: (value) {}))
                                      ]))),
                          SizedBox(height: 15.v),
                          _buildEightyThree(context),
                          SizedBox(height: 18.v),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF9CD2D3), // Puedes cambiar este color según tus preferencias
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0), // Ajusta este valor según tus preferencias
                                    child: Icon(Icons.search_sharp, color: Colors.white, size: 24.0), // Icono de lupa
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintText: "¿Buscas hacer algo en particular en ... ",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(16.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 31.v),
                          _buildComponentNuevDest(context),
                          SizedBox(height: 40.v),
                          _buildComponentIntereses(context)
                        ]),
                      ],
                    )))));
  }

  /// Section Widget
  Widget _buildEightyThree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CustomImageView(
              imagePath: ImageConstant.imgArrowDown2,
              height: 10.v,
              width: 5.h,
              margin: EdgeInsets.symmetric(vertical: 14.v)),
          Container(
              margin: EdgeInsets.only(left: 17.h),
              decoration: AppDecoration.outlineBlack,
              child:
                  Text("¿A dónde vamos?", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito',)))
        ]));
  }

  /// Section Widget
  Widget _buildComponentNuevDest(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("De acuerdo con tus preferencias te recomendamos...",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito',)),
          SizedBox(height: 20.v),
          /*SizedBox(
              height: 240.v,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 8.h);
                  },
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // Aquí puedes manipular la información de cada elemento
                    // Cambia la lógica según tus necesidades
                    String itemText = "Elemento $index"; // Ejemplo de texto diferente para cada elemento
                    return NinetyItemWidget(itemText: itemText);
                  }))*/
          CarouselWithInfo(),
        ]));
  }

  /// Section Widget
  Widget _buildComponentIntereses(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 6.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(left: 9.h),
              child: Text("Tambien te podría interesar...",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito',))),
          SizedBox(height: 14.v),
          /*SizedBox(
              height: 138.v,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 13.h);
                  },
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return RecommendedItemWidget(onTapImgAcuarioInbursa: () {
                      onTapImgAcuarioInbursa(context);
                    });
                  }))*/
          CarouselWithInfo2(),
        ]));
  }

  /// Navigates to the frminfolugarScreen when the action is triggered.
  /*onTapImgAcuarioInbursa(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frminfolugarScreen);
  }*/
}

class HeartButton extends StatefulWidget {
  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool isHeartRed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Cambia el color del corazón al contrario del estado actual
          isHeartRed = !isHeartRed;
        });
        // Lógica cuando se presiona el botón de corazón
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // Cambia el color de fondo del círculo aquí
          border: Border.all(
            color: Colors.white,
            //color: Colors.white, // Cambia el color del contorno aquí
            width: 0.5,
          ),
        ),
        child: Icon(
          Icons.favorite,
          color: isHeartRed ? Colors.red : Colors.grey, // Cambia el color del corazón aquí
          size: 27.0,
        ),
      ),
    );
  }
}


class CarouselWithInfo extends StatefulWidget {
  @override
  _CarouselWithInfoState createState() => _CarouselWithInfoState();
}

class _CarouselWithInfoState extends State<CarouselWithInfo> {
  bool isHeartRed = false;
  List preferencias = [];
  List<Widget> carouselItems = [];
  Map<String, dynamic> requestData = {};
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      // Verificamos si hay un usuario autenticado
      User? user = auth.currentUser;
      if (user != null) {
        // Obtenemos el ID del usuario autenticado
        String uid = user.uid;

        // Referencia a la colección "usuarios" y subcolección "preferencias"
        CollectionReference preferenciasCollection = FirebaseFirestore.instance.collection('usuarios').doc(uid).collection('preferencias');;

        // Realizamos la consulta para obtener las preferencias del usuario
        QuerySnapshot querySnapshot = await preferenciasCollection.get();

        // Iteramos sobre los documentos y accedemos a los datos
        querySnapshot.docs.forEach((doc) {
          // Aquí puedes acceder a los datos de las preferencias del usuario
          //print('Preferencias - ID: ${doc.id}');
          preferencias.add(doc.id);
          //print('Preferencia - ID: ${doc.id}, Tipo: ${doc['tipo']}');
        });
      } else {
        print('No hay usuario autenticado');
      }
    } catch (e) {
      print('Error al obtener preferencias: $e');
    }
    //print(preferencias);
    //print(preferencias.length);
    Position position = await _determinePosition2();
    double latitude = position.latitude;
    double longitude = position.longitude;
    // Tu lógica para obtener datos desde la API
    String url = 'https://places.googleapis.com/v1/places:searchNearby';
    // Los datos que enviarás en el cuerpo de la solicitud POST
    if (preferencias.length == 1){
      requestData = {
        "includedTypes": preferencias,
        "maxResultCount": 3,
        //"rankPreference": "DISTANCE",
        "languageCode": "es",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": latitude,
              "longitude": longitude,
            },
            "radius": 1000.0
          }
        },
      };
    }
    else if (preferencias.length == 2){
      requestData = {
        "includedTypes": preferencias,
        "maxResultCount": 5,
        //"rankPreference": "DISTANCE",
        "languageCode": "es",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": latitude,
              "longitude": longitude,
            },
            "radius": 1000.0
          }
        },
      };
    }
    else if (preferencias.length >= 3){
      requestData = {
        "includedTypes": preferencias,
        "maxResultCount": 10,
        //"rankPreference": "DISTANCE",
        "languageCode": "es",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": latitude,
              "longitude": longitude,
            },
            "radius": 1000.0
          }
        },
      };
    }
    else {
      requestData = {
        "includedTypes": ['restaurant', 'hotel', 'museum'],
        "maxResultCount": 10,
        //"rankPreference": "DISTANCE",
        "languageCode": "es",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": latitude,
              "longitude": longitude,
            },
            "radius": 1000.0
          }
        },
      };
    }


    // Las cabeceras de la solicitud
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM', // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.location,places.currentOpeningHours,places.photos,places.primaryTypeDisplayName,places.id,places.rating',
    };

    // Realiza la solicitud POST
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestData),
        headers: headers,
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta aquí
        //print('Respuesta exitosa: ${response.body}');
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
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestData),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        updateCarouselItems(jsonData["places"]);
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateCarouselItems(List<dynamic> places) {
    List<Widget> items = [];
    for (var place in places) {
      String title = place["displayName"]["text"];// + '-' + place["primaryTypeDisplayName"]["text"];
      print(title);
      String description = place["rating"].toString();
      print(description);
      String photo = place["photos"][0]["name"];
      //print(photo);
      String image = 'https://places.googleapis.com/v1/$photo/media?maxHeightPx=400&maxWidthPx=400&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
      //print(image);
      //String image = 'imagen1.jpg';
      String id = place["id"];
      items.add(buildCarouselItem(title, description, image, id));
    }

    setState(() {
      carouselItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 395.0,
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 16/9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.6,
      ),
      items: carouselItems.isEmpty
          ? [buildLoadingItem()] // Puedes mostrar un indicador de carga mientras se obtienen los datos
          : carouselItems,
    );
  }

  Widget buildCarouselItem(String title, String description, String image, String id) {
    return GestureDetector(
      onTap: () {
        // Acción a realizar cuando se toca el elemento del carrusel
        print('Elemento del carrusel presionado: $id');
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          //String aux = '${prediction.lat}, ${prediction.lng}';
          return FrminfolugarScreen(id: id);
        }));
        // Aquí puedes agregar la lógica adicional que desees
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0), // Borde ovalado
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  bottomLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 4.0,
              right: 16.0,
              child: HeartButton(),
              /*child: GestureDetector(
                onTap: () {
                  setState(() {
                    // Cambia el color del corazón al contrario del estado actual
                    isHeartRed = !isHeartRed;
                  });
                  // Lógica cuando se presiona el botón de corazón
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Cambia el color de fondo del círculo aquí
                    border: Border.all(
                      color: isHeartRed ? Colors.red : Colors.grey,
                      //color: Colors.white, // Cambia el color del contorno aquí
                      width: 0.5,
                    ),
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: isHeartRed ? Colors.red : Colors.grey, // Cambia el color del corazón aquí
                    size: 27.0,
                  ),
                ),
              ),*/
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  SizedBox(height: 270.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFF4D5652), // Color del "fondo del botón"
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito', color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFF4D5652), // Color del "fondo del botón"
                      borderRadius: BorderRadius.circular(59),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow, // Puedes ajustar el color del icono
                        ),
                        SizedBox(width: 8), // Ajusta el espacio entre el icono y el texto
                        Text(
                          description,
                          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito', color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoadingItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  Future<Position> _determinePosition2() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
class CarouselWithInfo2 extends StatefulWidget {
  @override
  _CarouselWithInfoState2 createState() => _CarouselWithInfoState2();
}

class _CarouselWithInfoState2 extends State<CarouselWithInfo2> {
  List preferencias = [];
  List<Widget> carouselItems = [];
  Map<String, dynamic> requestData = {};
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      // Verificamos si hay un usuario autenticado
      User? user = auth.currentUser;
      if (user != null) {
        // Obtenemos el ID del usuario autenticado
        String uid = user.uid;

        // Referencia a la colección "usuarios" y subcolección "preferencias"
        CollectionReference preferenciasCollection = FirebaseFirestore.instance.collection('usuarios').doc(uid).collection('preferencias');;

        // Realizamos la consulta para obtener las preferencias del usuario
        QuerySnapshot querySnapshot = await preferenciasCollection.get();

        // Iteramos sobre los documentos y accedemos a los datos
        querySnapshot.docs.forEach((doc) {
          // Aquí puedes acceder a los datos de las preferencias del usuario
          //print('Preferencias - ID: ${doc.id}');
          preferencias.add(doc.id);
          //print('Preferencia - ID: ${doc.id}, Tipo: ${doc['tipo']}');
        });
      } else {
        print('No hay usuario autenticado');
      }
    } catch (e) {
      print('Error al obtener preferencias: $e');
    }
    //print(preferencias);
    //print(preferencias.length);
    Position position = await _determinePosition2();
    double latitude = position.latitude;
    double longitude = position.longitude;
    // Tu lógica para obtener datos desde la API
    String url = 'https://places.googleapis.com/v1/places:searchNearby';
    // Los datos que enviarás en el cuerpo de la solicitud POST
    if (preferencias.length == 1){
      requestData = {
        "excludedTypes": preferencias,
        "maxResultCount": 5,
        //"rankPreference": "DISTANCE",
        "languageCode": "es",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": latitude,
              "longitude": longitude,
            },
            "radius": 1000.0
          }
        },
      };
    }
    else if (preferencias.length >= 2){
      requestData = {
        "excludedTypes": preferencias,
        "maxResultCount": 5,
        //"rankPreference": "DISTANCE",
        "languageCode": "es",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": latitude,
              "longitude": longitude,
            },
            "radius": 1000.0
          }
        },
      };
    }
    else {
      requestData = {
        "includedTypes": ['park', 'movie_theater', 'aquarium', 'tourist_attraction', 'museum', 'market', 'night_club', 'historical_landmark', 'store'],
        "maxResultCount": 5,
        //"rankPreference": "DISTANCE",
        "languageCode": "es",
        "locationRestriction": {
          "circle": {
            "center": {
              "latitude": latitude,
              "longitude": longitude,
            },
            "radius": 1000.0
          }
        },
      };
    }


    // Las cabeceras de la solicitud
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM', // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.location,places.currentOpeningHours,places.photos,places.primaryTypeDisplayName,places.id,places.rating',
    };

    // Realiza la solicitud POST
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestData),
        headers: headers,
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        // La solicitud fue exitosa, puedes manejar la respuesta aquí
        //print('Respuesta exitosa: ${response.body}');
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
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestData),
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        updateCarouselItems(jsonData["places"]);
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateCarouselItems(List<dynamic> places) {
    List<Widget> items = [];
    for (var place in places) {
      String title = place["displayName"]["text"];// + '-' + place["primaryTypeDisplayName"]["text"];
      print(title);
      String description = place["rating"].toString();
      print(description);
      String photo = place["photos"][0]["name"];
      //print(photo);
      String image = 'https://places.googleapis.com/v1/$photo/media?maxHeightPx=400&maxWidthPx=400&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
      //print(image);
      //String image = 'imagen1.jpg';
      String id = place["id"];
      items.add(buildCarouselItem(title, description, image, id));
    }

    setState(() {
      carouselItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 16/9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 920),
        viewportFraction: 0.6,
      ),
      items: carouselItems.isEmpty
          ? [buildLoadingItem()] // Puedes mostrar un indicador de carga mientras se obtienen los datos
          : carouselItems,
    );
  }

  Widget buildCarouselItem(String title, String description, String image, String id) {
    return GestureDetector(
      onTap: () {
        // Acción a realizar cuando se toca el elemento del carrusel
        print('Elemento del carrusel presionado: $id');
        // Aquí puedes agregar la lógica adicional que desees
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0), // Borde ovalado
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF4D5652),
                        borderRadius: BorderRadius.circular(59),
                      ),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'Nunito', color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoadingItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  Future<Position> _determinePosition2() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
