import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:turisteando_ando/pantallas/rutaUno.dart';
import '../frminfolugar_screen/frminfolugar_screen.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_page/frminicio_page.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_side_bar.dart';

// ignore_for_file: must_be_immutable
class FrmmarcadoresScreen extends StatelessWidget {
  FrmmarcadoresScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: null,
      ),
      body: SizedBox(
          width: double.maxFinite,
          child: ListView(
            children: [
              Column(children: [
                Container(
                    decoration: AppDecoration.outlineBlack,
                    child: Text("Estos son tus marcadores",
                        style: theme.textTheme.headlineMedium)),
                SizedBox(height: 11.v),
                CustomElevatedButton(
                    height: 24.v,
                    width: 125.h,
                    text: "Ver en mapa",
                    buttonStyle: CustomButtonStyles.outlineBlack,
                    buttonTextStyle:
                        CustomTextStyles.labelLargeMontserratTeal400,
                    onPressed: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>RutaUno(predictionDescription: 'Mover',)),
                      );
                    }),
                SizedBox(height: 5.v),
                _buildComponentDest(context),
                SizedBox(height: 15.v),
                _buildComponentNuev(context),
                SizedBox(height: 5.v)
              ]),
            ],
          )),
      //bottomNavigationBar: _buildBottomBar(context)
    ));
  }
  /// Section Widget
  Widget _buildComponentDest(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Tus lugares favoritos",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              )),
          SizedBox(height: 20.v),
          CarouselWithInfo10(),
        ]));
  }

  Widget _buildComponentNuev(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Descubre nuevos lugares",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              )),
          SizedBox(height: 20.v),
          CarouselWithInfo9(),
        ]));
  }

  /// Navigates to the frmmarcmapaScreen when the action is triggered.
  onTapVerEnMapa(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmmarcmapaScreen);
  }
}

class CarouselWithInfo9 extends StatefulWidget {
  @override
  _CarouselWithInfoState9 createState() => _CarouselWithInfoState9();
}
class _CarouselWithInfoState9 extends State<CarouselWithInfo9> {
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
        // Obtenemos la posición actual del usuario
        Position position = await _determinePosition2();
        double latitude = position.latitude;
        double longitude = position.longitude;

        // Tipos de lugares específicamente turísticos
        List<String> tiposTurismo = ['tourist_attraction'];

        // Preparamos los datos de la solicitud enfocados en turismo
        requestData = {
          "includedTypes": tiposTurismo,
          "maxResultCount": 15, // Puedes ajustar el número de resultados según sea necesario
          "languageCode": "es",
          "locationRestriction": {
            "circle": {
              "center": {
                "latitude": latitude,
                "longitude": longitude,
              },
              "radius": 5000.0 // Establecemos el radio de búsqueda en 5000 metros
            }
          },
        };

        // Las cabeceras de la solicitud
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM', // Asegúrate de reemplazar esto con tu clave de API real
          'X-Goog-FieldMask': 'places.displayName,places.formattedAddress,places.location,places.currentOpeningHours,places.photos,places.primaryTypeDisplayName,places.id,places.rating',
        };

        // Realizamos la solicitud POST
        var response = await http.post(
          Uri.parse('https://places.googleapis.com/v1/places:searchNearby'),
          body: jsonEncode(requestData),
          headers: headers,
        );

        // Verifica el código de estado de la respuesta
        if (response.statusCode == 200) {
          // La solicitud fue exitosa, maneja la respuesta aquí
          Map<String, dynamic> jsonData = json.decode(response.body);
          updateCarouselItems(jsonData["places"]);
        } else {
          // Hubo un error en la solicitud, maneja el error aquí
          print('Error en la solicitud: ${response.statusCode}');
        }
      } else {
        print('No hay usuario autenticado');
      }
    } catch (e) {
      print('Error al obtener la posición o al hacer la solicitud: $e');
    }
  }
  void updateCarouselItems(List<dynamic> places) {
    List<Widget> items = [];
    for (var place in places) {
      String title = place["displayName"]
      ["text"]; // + '-' + place["primaryTypeDisplayName"]["text"];
      print(title);
      String description = place["rating"].toString();
      print(description);
      String photo = place["photos"][0]["name"];
      //print(photo);
      String image =
          'https://places.googleapis.com/v1/$photo/media?maxHeightPx=400&maxWidthPx=400&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
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
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.6,
      ),
      items: carouselItems.isEmpty
          ? [
        buildLoadingItem()
      ] // Puedes mostrar un indicador de carga mientras se obtienen los datos
          : carouselItems,
    );
  }

  Widget buildCarouselItem(
      String title, String description, String image, String id) {
    return GestureDetector(
      onTap: () {
        // Acción a realizar cuando se toca el elemento del carrusel
        print('Elemento del carrusel presionado: $id');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
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
              child: HeartButton(itemId: id),
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
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          color: Colors.white),
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
                          color: Colors
                              .yellow, // Puedes ajustar el color del icono
                        ),
                        SizedBox(
                            width:
                            8), // Ajusta el espacio entre el icono y el texto
                        Text(
                          description,
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                              color: Colors.white),
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

class CarouselWithInfo10 extends StatefulWidget {
  @override
  _CarouselWithInfoState10 createState() => _CarouselWithInfoState10();
}
class _CarouselWithInfoState10 extends State<CarouselWithInfo10> {
  bool isHeartRed = false;
  List preferencias = [];
  List<Widget> carouselItems = [];
  Map<String, dynamic> requestData = {};
  @override
  void initState() {
    super.initState();
    listenToFavorites();
  }

  void listenToFavorites() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('favoritos')
          .snapshots()
          .listen((snapshot) {
        List<String> placeIds = snapshot.docs.map((doc) => doc.data()['id'] as String).toList();
        fetchPlacesDetails(placeIds);
      });
    } else {
      print('No hay usuario autenticado');
    }
  }
  // Método para obtener los IDs de favoritos desde Firebase
  Future<void> fetchData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      try {
        var snapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .collection('favoritos')
            .get();

        List<String> placeIds = snapshot.docs.map((doc) => doc.data()['id'] as String).toList();

        await fetchPlacesDetails(placeIds);
      } catch (e) {
        print('Error al obtener datos de Firebase: $e');
      }
    } else {
      print('No hay usuario autenticado');
    }
  }

  // Método para obtener detalles de los lugares usando los IDs obtenidos
  Future<void> fetchPlacesDetails(List<String> placeIds) async {
    List<Widget> items = [];
    for (String id in placeIds) {
      try {
        Map<String, dynamic> placeDetails = await fetchPlaceDetailsFromApi(id);
        items.add(buildCarouselItem(placeDetails['title'], placeDetails['description'], placeDetails['image'], id));
      } catch (e) {
        print('Error al obtener detalles del lugar: $e');
      }
    }

    setState(() {
      carouselItems = items;
    });
  }

  // Método para hacer una llamada a la API y obtener los detalles de un lugar
  Future<Map<String, dynamic>> fetchPlaceDetailsFromApi(String placeId) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data['result'];

      // Obteniendo el nombre y la calificación del lugar
      String title = result['name']; // Nombre del lugar
      double rating = result['rating'] ?? 0.0; // Calificación del lugar, 0.0 si no está disponible

      // Construyendo la descripción con la calificación
      String description = '${rating.toStringAsFixed(1)}';

      // URL de la imagen del lugar
      String imageUrl = result['photos'] != null
          ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${result['photos'][0]['photo_reference']}&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM'
          : 'URL_imagen_por_defecto';

      return {
        'title': title,
        'description': description,
        'image': imageUrl
      };
    } else {
      return {
        'title': 'Información no disponible',
        'description': 'No se pudo obtener la descripción',
        'image': 'url_de_imagen_por_defecto'
      };
    }
  }

  void updateCarouselItems(List<dynamic> places) {
    List<Widget> items = [];
    for (var place in places) {
      String title = place["displayName"]
      ["text"]; // + '-' + place["primaryTypeDisplayName"]["text"];
      print(title);
      String description = place["rating"].toString();
      print(description);
      String photo = place["photos"][0]["name"];
      //print(photo);
      String image =
          'https://places.googleapis.com/v1/$photo/media?maxHeightPx=400&maxWidthPx=400&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
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
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.6,
      ),
      items: carouselItems.isEmpty
          ? [
        buildNoFavoritesMessage()
      ] // Puedes mostrar un indicador de carga mientras se obtienen los datos
          : carouselItems,
    );
  }

  Widget buildCarouselItem(
      String title, String description, String image, String id) {
    return GestureDetector(
      onTap: () {
        // Acción a realizar cuando se toca el elemento del carrusel
        print('Elemento del carrusel presionado: $id');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
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
              child: HeartButton(itemId: id),
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
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          color: Colors.white),
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
                          color: Colors
                              .yellow, // Puedes ajustar el color del icono
                        ),
                        SizedBox(
                            width:
                            8), // Ajusta el espacio entre el icono y el texto
                        Text(
                          description,
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                              color: Colors.white),
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

  Widget buildNoFavoritesMessage() {
    return Center(
      child: Text(
        'Ningún favorito agregado',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

}
