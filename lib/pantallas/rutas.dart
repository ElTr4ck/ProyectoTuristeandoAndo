import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turisteando_ando/pantallas/rutaUno.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
//import 'package:google_maps_webservice/places.dart';
//import 'package:google_api_headers/google_api_headers.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminfolugar_screen/frminfolugar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

const kGoogleApiKey = 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _PolylineScreenState extends State<PolylineScreen> {
  static const CameraPosition initialPosition = CameraPosition(
      target: LatLng(19.36965534943562, -98.96226746584259), zoom: 14);


  final Completer<GoogleMapController> _controller = Completer();

  String totalDistance = "";
  String totalTime = "";

  String apiKey = "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM";

  LatLng origin = LatLng(0, 0);
  LatLng destination = LatLng(0, 0);

  double destinolat = 0.0;
  double destinolon = 0.0;

  //PolylineResponse polylineResponse = PolylineResponse();

  //Set<Polyline> polylinePoints = {};

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  Set<Marker> markersList = {};

  late GoogleMapController googleMapController;

  List<LatLng> points = [
    LatLng(19.36663909454925, -98.96088344601702),
    LatLng(19.50481109220203, -99.14636592039268)
    //LatLng(45.851254420031296, 14.624331708344428),
    //LatLng(45.84794984187217, 14.605434384742317)
  ];

  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  String googleApiKey = 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
  String totalDistances = 'No route';
  Color _iconColor = Colors.grey;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            polylines: route.routes,
            zoomControlsEnabled: false,
            initialCameraPosition: initialPosition,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          Container(
            height: 125,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              // Ajusta la opacidad y el color del fondo difuminado
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.2))
              ], // Efecto de desenfoque
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20), // Espacio interno
                  Container(
                    alignment: Alignment.center,
                    // Centrar horizontal y verticalmente
                    child: Text(
                      "¿Qué deseas hacer el día de hoy?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  placesAutoCompleteTextField(),
                ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black.withOpacity(0.2)),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Tal vez podría interesarte...",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  CarouselWithInfo(),
                ],
              ),
            ),
          ),
        ],

      ),

    );
  }

  void drawPolyline(double destinationlat, double destinationlon) async {
    Position position = await _determinePosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    //origin = LatLng(latitude, longitude);
    //destination = LatLng(destinationlat, destinationlon);
    List<LatLng> points = [
      LatLng(latitude, longitude),
      LatLng(destinationlat, destinationlon)
      //LatLng(45.851254420031296, 14.624331708344428),
      //LatLng(45.84794984187217, 14.605434384742317)
    ];
    await route.drawRoute(
        points, 'Test routes', Color.fromRGBO(130, 78, 210, 1.0), googleApiKey,
        travelMode: TravelModes.walking);
    setState(() {
      totalDistance =
          distanceCalculator.calculateRouteDistance(points, decimals: 1);

      //totalTime =
    });
    /*var response = await http.post(Uri.parse("https://maps.googleapis.com/maps/api/directions/json?key=" +
        apiKey +
        "&units=metric&origin=" +
        origin.latitude.toString() +
        "," +
        origin.longitude.toString() +
        "&destination=" +
        destination.latitude.toString() +
        "," +
        destination.longitude.toString() +
        "&mode=driving"));

    print(response.body);

    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));

    totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
    totalTime = polylineResponse.routes![0].legs![0].duration!.text!;

    for (int i = 0; i < polylineResponse.routes![0].legs![0].steps!.length; i++) {
      polylinePoints.add(Polyline(polylineId: PolylineId(polylineResponse.routes![0].legs![0].steps![i].polyline!.points!), points: [
        LatLng(
            polylineResponse.routes![0].legs![0].steps![i].startLocation!.lat!, polylineResponse.routes![0].legs![0].steps![i].startLocation!.lng!),
        LatLng(polylineResponse.routes![0].legs![0].steps![i].endLocation!.lat!, polylineResponse.routes![0].legs![0].steps![i].endLocation!.lng!),
      ],width: 3,color: Colors.red));
    }

    setState(() {});*/
  }

  Future<Position> _determinePosition() async {
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

  Widget buildButtonHome(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        // Coloca aquí la acción que quieres que ocurra al presionar el botón
        print('Acción del botón');
      },
    );
  }

  Widget buildButtonMap(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        // Coloca aquí la acción que quieres que ocurra al presionar el botón
        print('Acción del botón');
      },
    );
  }

  Widget buildButtonFav(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        // Coloca aquí la acción que quieres que ocurra al presionar el botón
        print('Acción del botón');
      },
    );
  }

  Widget buildButtonUsser(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        // Coloca aquí la acción que quieres que ocurra al presionar el botón
        print('Acción del botón');
      },
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: "AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM",
        inputDecoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Sugerencia: Museos',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Nunito',
            fontStyle: FontStyle.italic,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            // Agrega este bloque para el border general
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.transparent),
          ),

          fillColor: Colors.white,
          // Ajusta el color del fondo según tus necesidades
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),

        debounceTime: 400,
        countries: ["mx"],
        isLatLngRequired: false,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print("placeDetails" + prediction.lat.toString());
        },

        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
          fetchData(prediction.description as String);
          /*Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
            //String aux = '${prediction.lat}, ${prediction.lng}';
            return MyApp(prediction.description as String);
          }));*/
        },
        seperatedBuilder: Divider(
          color: Colors.transparent,
        ),
        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                Container(
                  width: 7,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(child: Text("${prediction.description ?? ""}"))
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }

  Future<void> fetchData(data) async {
    // Tu lógica para obtener datos desde la API
    String dataloc = data;
    String url = 'https://places.googleapis.com/v1/places:searchText';
    // Los datos que enviarás en el cuerpo de la solicitud POST

    print(dataloc);
    // Las cabeceras de la solicitud
    Map<String, dynamic> requestData = {"textQuery": "$data"};
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM',
      // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask': 'places.id',
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
        print('Respuesta exitosa: ${response.body}');
        Map<String, dynamic> jsonData = json.decode(response.body);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          //String aux = '${prediction.lat}, ${prediction.lng}';
          return FrminfolugarScreen(id: jsonData["places"][0]["id"]);
        }));
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
  }
}

class CarouselWithInfo extends StatefulWidget {
  @override
  _CarouselWithInfoState createState() => _CarouselWithInfoState();
}

class _CarouselWithInfoState extends State<CarouselWithInfo> {
  List<Widget> carouselItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    //Position position = await _determinePosition2();
    //double latitude = position.latitude;
    //double longitude = position.longitude;
    FirebaseAuth auth = FirebaseAuth.instance;
    List ubicacionActual = [];

    try {
      // Verificamos si hay un usuario autenticado
      User? user = auth.currentUser;
      if (user != null) {
        // Obtenemos el ID del usuario autenticado
        String uid = user.uid;
        // Referencia a la colección "usuarios" y subcolección "ubicacion_actual"
        CollectionReference ubicacionCollection = FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .collection('Ubicacion');

        // Realizamos la consulta para obtener la ubicación actual del usuario
        QuerySnapshot ubicacionSnapshot = await ubicacionCollection.get();

        // Lista para almacenar la ubicación actual

        // Iteramos sobre los documentos y accedemos a los datos de ubicación actual
        ubicacionSnapshot.docs.forEach((doc) {
          // Asegúrate de ajustar según la estructura real de tu documento de ubicación_actual
          double latitud = doc['latitud'] ?? 0.0;
          double longitud = doc['longitud'] ?? 0.0;
          ubicacionActual.add(latitud);
          ubicacionActual.add(longitud);
        });
      } else {
        print('No hay usuario autenticado');
      }
    } catch (e) {
      print('Error al obtener preferencias: $e');
    }
    print(ubicacionActual);
    // Tu lógica para obtener datos desde la API
    String url = 'https://places.googleapis.com/v1/places:searchNearby';
    // Los datos que enviarás en el cuerpo de la solicitud POST
    Map<String, dynamic> requestData = {
      "includedTypes": ["tourist_attraction", "museum", "hotel", "restaurant"],
      "maxResultCount": 5,
      //"rankPreference": "DISTANCE",
      "languageCode": "es",
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": ubicacionActual[0],
            "longitude": ubicacionActual[1],
          },
          "radius": 2000.0
        }
      },
    };

    // Las cabeceras de la solicitud
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key':
          'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM', // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask':
          'places.displayName,places.formattedAddress,places.location,places.currentOpeningHours,places.photos,places.primaryTypeDisplayName,places.id',
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
      String title = place["displayName"]["text"] +
          '-' +
          place["primaryTypeDisplayName"]["text"];
      print(title);
      String description = place["formattedAddress"];
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
        height: 190.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
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
          //String aux = '${prediction.lat}, ${prediction.lng}';
          return FrminfolugarScreen(id: id);
        }));
        // Aquí puedes agregar la lógica adicional que desees
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0), // Borde ovalado
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100.0, // Ajusta el ancho según tus necesidades
              height: 200.0, // Ajusta la altura según tus necesidades
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito'),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 5.0),
                    Text(
                      description,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'Nunito',
                          overflow: TextOverflow.ellipsis),
                      maxLines: 3,
                    ),
                  ],
                ),
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
