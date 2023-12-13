import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_page/frminicio_page.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmrese_a_page/frmrese_a_page2.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title_searchview.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_bottom_bar.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmrese_GOOGLE_page/frmrese_GOOGLE_page.dart';
import 'package:http/http.dart' as http;
class FrmreseATabContainerScreen2 extends StatefulWidget {
  final String id;
  FrmreseATabContainerScreen2({required this.id, Key? key}) : super(key: key);

  @override
  FrmreseATabContainerScreenState createState() =>
      FrmreseATabContainerScreenState();
}

class FrmreseATabContainerScreenState extends State<FrmreseATabContainerScreen2>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabviewController;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  Map<String, dynamic>? jsonData;
  int ?finale = 0;
  int ?five = 0;
  int ?four = 0;
  int ?three = 0;
  int ?two = 0;
  int ?one = 0;
  double ?rating = 0.0;
  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
    fetchData();
  }
  Future<void> fetchData() async {
    int i = 0;
    int cinco = 0;
    int cuatro = 0;
    int tres = 0;
    int dos = 0;
    int uno = 0;
    // Tu lógica para obtener datos desde la API
    String url = 'https://places.googleapis.com/v1/places/${widget.id}?fields=id,displayName,reviews,userRatingCount,rating,photos&languageCode=es&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
    // Los datos que enviarás en el cuerpo de la solicitud POST

    print("Hola");
    // Las cabeceras de la solicitud
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM',
      // Reemplaza 'API_KEY' con tu clave real
      'X-Goog-FieldMask': 'id,displayName,reviews,userRatingCount,rating',
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
        while (jsonData?["reviews"] != null && i < jsonData["reviews"].length){
          if (jsonData?["reviews"][i]["rating"] == 5){
            cinco++;
          }else if(jsonData?["reviews"][i]["rating"] == 4){
            cuatro++;
          }else if(jsonData?["reviews"][i]["rating"] == 3){
            tres++;
          }else if(jsonData?["reviews"][i]["rating"] == 2){
            dos++;
          }else if(jsonData?["reviews"][i]["rating"] == 1){
            uno++;
          }
          print(jsonData?["reviews"][i]["rating"]);
          i++;
        }
        finale = i;
        one = uno;
        two = dos;
        three = tres;
        four = cuatro;
        five = cinco;
        rating = 1/i;
        print('Hola soy ${finale}');
        //print(jsonData?["reviews"][0]["text"]["text"]);
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
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    if (jsonData != null) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                _buildTwelve(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 16.v),
                    _buildComponentPlaceStars(context),
                    SizedBox(height: 5.v),
                    _buildComponentCalif(context),
                    SizedBox(height: 17.v),
                    Container(
                      height: 35.v,
                      width: 127.h,
                      margin: EdgeInsets.only(left: 21.h),
                      decoration: BoxDecoration(
                        color: appTheme.blueA4000c,
                        borderRadius: BorderRadius.circular(
                          17.h,
                        ),
                        border: Border.all(
                          color: appTheme.gray400,
                          width: 1.h,
                        ),
                      ),
                      child: TabBar(
                        controller: tabviewController,
                        labelPadding: EdgeInsets.zero,
                        tabs: [
                          Tab(
                            child: SizedBox(
                              height: 32.v,
                              width: 61.h,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgBg,
                                    height: 32.v,
                                    width: 61.h,
                                    radius: BorderRadius.circular(
                                      16.h,
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.h,
                                        bottom: 6.v,
                                      ),
                                      child: Text(
                                        "Google",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "App",
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildTabBarView(context),
                  ],
                ),
              ],
            ),
          ),
          //bottomNavigationBar: _buildBottomBar(context),
        ),
      );
    }else {
      // Si jsonData es nulo, puedes devolver un indicador de carga o lo que prefieras
      return CustomCircularProgressIndicator(size: 1.0);
    }
  }

  /// Section Widget
  Widget _buildTwelve(BuildContext context) {
    if (jsonData != null) {
      return SizedBox(
        height: 217.v,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(33.0),
              child: Image.network(
                'https://places.googleapis.com/v1/${jsonData?["photos"][0]["name"]}/media?maxHeightPx=400&maxWidthPx=400&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM',
                height: 217.v,
                width: 360.h,
                fit: BoxFit.cover, // Ajusta según tus necesidades
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // La imagen se cargó con éxito
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
              ),
            ),
            CustomAppBar(
              height: 70.v,
              leadingWidth: 30.h,
              leading: AppbarLeadingImage(
                imagePath: ImageConstant.imgArrowDown2,
                margin: EdgeInsets.only(
                  left: 25.h,
                  top: 15.v,
                  bottom: 20.v,
                ),
              ),
              centerTitle: true,
              /*title: AppbarTitleSearchview(
                hintText: "¿Buscas hacer algo ... ",
                controller: searchController,
              ),*/
            ),
          ],
        ),
      );
    }else {
      // Si jsonData es nulo, puedes devolver un indicador de carga o lo que prefieras
      return CustomCircularProgressIndicator(size: 1.0);
    }
  }

  /// Section Widget
  Widget _buildComponentPlaceStars(BuildContext context) {
    if (jsonData != null) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(
            left: 25.h,
            right: 17.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.v),
                child: Text(
                  "${jsonData?["displayName"]["text"]}",
                  style: CustomTextStyles.titleLargeNunito,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4.v),
                padding: EdgeInsets.symmetric(
                  horizontal: 4.h,
                  vertical: 8.v,
                ),
                decoration: AppDecoration.fillErrorContainer1.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRatingBar(
                      initialRating: jsonData?['rating'],
                      itemSize: 13,
                      color: appTheme.yellow700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }else {
      // Si jsonData es nulo, puedes devolver un indicador de carga o lo que prefieras
      return CustomCircularProgressIndicator(size: 1.0);
    }
  }

  /// Section Widget
  Widget _buildComponentCalif(BuildContext context) {
    double aux5 = rating!*(five!.toDouble());
    double aux4 = rating!*(four!.toDouble());
    double aux3 = rating!*(three!.toDouble());
    double aux2 = rating!*(two!.toDouble());
    double aux1 = rating!*(one!.toDouble());
    if (jsonData != null) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 65.h,
                margin: EdgeInsets.only(
                  top: 8.v,
                  bottom: 13.v,
                ),
                padding: EdgeInsets.symmetric(vertical: 7.v),
                decoration: AppDecoration.fillOnPrimary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${jsonData?["rating"]}",
                      style: CustomTextStyles.titleLargeInterBlack900,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgFrameYellow700,
                      height: 20.v,
                      width: 22.h,
                      margin: EdgeInsets.only(
                        left: 3.h,
                        top: 2.v,
                        bottom: 2.v,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 9.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "5",
                            style: theme.textTheme.labelLarge,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 13.h,
                                top: 3.v,
                                bottom: 2.v,
                              ),
                              child: Container(
                                height: 8.v,
                                width: 208.h,
                                decoration: BoxDecoration(
                                  color: appTheme.gray200,
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                  child: LinearProgressIndicator(
                                    value: aux5,
                                    backgroundColor: appTheme.gray200,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      appTheme.yellow700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "4",
                            style: theme.textTheme.labelLarge,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 13.h,
                                top: 3.v,
                                bottom: 2.v,
                              ),
                              child: Container(
                                height: 8.v,
                                width: 208.h,
                                decoration: BoxDecoration(
                                  color: appTheme.gray200,
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                  child: LinearProgressIndicator(
                                    value: aux4,
                                    backgroundColor: appTheme.gray200,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      appTheme.yellow700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "3",
                            style: theme.textTheme.labelLarge,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 13.h,
                                top: 3.v,
                                bottom: 2.v,
                              ),
                              child: Container(
                                height: 8.v,
                                width: 208.h,
                                decoration: BoxDecoration(
                                  color: appTheme.gray200,
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                  child: LinearProgressIndicator(
                                    value: aux3,
                                    backgroundColor: appTheme.gray200,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      appTheme.yellow700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "2",
                            style: theme.textTheme.labelLarge,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 13.h,
                                top: 3.v,
                                bottom: 2.v,
                              ),
                              child: Container(
                                height: 8.v,
                                width: 208.h,
                                decoration: BoxDecoration(
                                  color: appTheme.gray200,
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                  child: LinearProgressIndicator(
                                    value: aux2,
                                    backgroundColor: appTheme.gray200,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      appTheme.yellow700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "1",
                            style: theme.textTheme.labelLarge,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 16.h,
                                top: 3.v,
                                bottom: 2.v,
                              ),
                              child: Container(
                                height: 8.v,
                                width: 208.h,
                                decoration: BoxDecoration(
                                  color: appTheme.gray200,
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                  child: LinearProgressIndicator(
                                    value: aux1,
                                    backgroundColor: appTheme.gray200,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      appTheme.yellow700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }else {
      // Si jsonData es nulo, puedes devolver un indicador de carga o lo que prefieras
      return CustomCircularProgressIndicator(size: 1.0);
    }
  }

  /// Section Widget
  Widget _buildTabBarView(BuildContext context) {
    if (jsonData != null) {
      return SizedBox(
        height: 308.v,
        child: TabBarView(
          controller: tabviewController,
          children: [

            FrmreseAPageG(jsonData: jsonData),
            FrmreseAPage(id : jsonData?['id']),
          ],
        ),
      );
    }else {
      // Si jsonData es nulo, puedes devolver un indicador de carga o lo que prefieras
      return CustomCircularProgressIndicator(size: 1.0);
    }
  }

/// Section Widget
/*Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Iconlycurvedhome:
        return "/";
      case BottomBarEnum.Iconlylightticket:
        return AppRoutes.frminicioPage;
      case BottomBarEnum.Iconlylightoutlineheart:
        return "/";
      case BottomBarEnum.Iconlylightprofile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.frminicioPage:
        return FrminicioPage();
      default:
        return DefaultWidget();
    }
  }*/

}
class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;  // Tamaño personalizado del indicador

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