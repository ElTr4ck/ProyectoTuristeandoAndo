import 'dart:convert';

import '../frminfolugar_screen/widgets/componentlugares_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frminicio_page/frminicio_page.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class FrminfolugarScreen extends StatefulWidget {
  final String id;


  FrminfolugarScreen({required this.id, Key? key}) : super(key: key);

  @override
  _FrminfolugarScreenState createState() => _FrminfolugarScreenState();
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

class _FrminfolugarScreenState extends State<FrminfolugarScreen> {
  Map<String, dynamic>? jsonData;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Tu lógica para obtener datos desde la API
    String url = 'https://places.googleapis.com/v1/places/${widget.id}?fields=websiteUri,currentOpeningHours,displayName,formattedAddress,nationalPhoneNumber,editorialSummary,photos&languageCode=es&key=AIzaSyBdskHJgjgw7fAn66BFZ6-II0k0ebC9yCM';
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
          appBar: _buildAppBar(context),
          body: SizedBox(
            width: double.maxFinite,
            child: ListView(
              children: [
                Column(
                  children: [
                    _buildComponentLugares(context),
                    SizedBox(height: 21.v),
                    _buildFortyTwo(context),
                    SizedBox(height: 7.v),
                    _buildComponentAcciones(context),
                    SizedBox(height: 9.v),
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
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown2,
            margin: EdgeInsets.only(left: 19.h, top: 12.v, bottom: 22.v),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                //String aux = '${prediction.lat}, ${prediction.lng}';
                return FrminicioPage();
              }));
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Información"));
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
          CustomImageView(
              imagePath: ImageConstant.imgRectangle994,
              height: 231.v,
              width: 188.h,
              radius: BorderRadius.circular(24.h)),
          Column(children: [
            CustomImageView(
                imagePath: ImageConstant.imgRectangle992,
                height: 109.v,
                width: 142.h,
                radius: BorderRadius.circular(24.h)),
            SizedBox(height: 7.v),
            CustomImageView(
                imagePath: ImageConstant.imgRectangle993,
                height: 115.v,
                width: 142.h,
                radius: BorderRadius.circular(24.h))
          ])
        ]));
  }

  /// Section Widget
  Widget _buildComponentAcciones(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 5.v),
              decoration: AppDecoration.fillErrorContainer1
                  .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
              child:
                  CustomRatingBar(initialRating: 5, color: appTheme.yellow700)),
          CustomElevatedButton(
              height: 17.v,
              width: 88.h,
              text: "Indicaciones",
              margin: EdgeInsets.only(left: 23.h),
              leftIcon: Container(
                  margin: EdgeInsets.only(right: 6.h),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgFlechita,
                      height: 12.adaptSize,
                      width: 12.adaptSize)),
              buttonStyle: CustomButtonStyles.fillPrimary,
              buttonTextStyle: CustomTextStyles.bodySmallRegular),
          CustomImageView(
              imagePath: ImageConstant.imgFrameAgregarruta,
              height: 20.v,
              width: 19.h,
              margin: EdgeInsets.only(left: 23.h)),
          CustomImageView(
              imagePath: ImageConstant.imgVectorvisitado,
              height: 16.v,
              width: 15.h,
              margin: EdgeInsets.only(left: 23.h)),
          CustomImageView(
              imagePath: ImageConstant.imgVectorfavoritos,
              height: 16.v,
              width: 19.h,
              margin: EdgeInsets.only(left: 23.h))
        ]));
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
          Align(
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
                  child: Text(
                      "Av. P.º de la Reforma 51, Polanco, Bosque de Chapultepec I Secc, Miguel Hidalgo, 11580 Ciudad de México, CDMX",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodySmallDMSansOnError
                          .copyWith(height: 1.80)))),
          SizedBox(height: 2.v),
          SizedBox(
              height: 23.v,
              width: 312.h,
              child: Stack(alignment: Alignment.bottomLeft, children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(width: 307.h, child: Divider())),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Detalles",
                        style: CustomTextStyles.titleMediumMedium))
              ])),
          SizedBox(height: 8.v),
          SizedBox(
              height: 232.v,
              width: 315.h,
              child: Stack(alignment: Alignment.topCenter, children: [
                CustomElevatedButton(
                    height: 16.v,
                    width: 53.h,
                    text: "Reseñas",
                    margin: EdgeInsets.only(right: 13.h),
                    buttonStyle: CustomButtonStyles.fillTeal,
                    buttonTextStyle: theme.textTheme.labelSmall!,
                    onPressed: () {
                      onTapReseas(context);
                    },
                    alignment: Alignment.bottomRight),
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: 315.h,
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "Reconocido museo de arte contemporáneo que exhibe pinturas, escultura y fotografía.\nEs el primer museo en México construido con fondos privados, y ha sido administrado por el Instituto Nacional de Bellas Artes (INBA) desde 1986. Rufino Tamayo, nacido en Oaxaca en 1899, comenzó a coleccionar obras de arte en la década de 1960 con la intención declarada de brindar más arte del siglo XX a los mexicanos.\n",
                                  style: theme.textTheme.bodyMedium),
                              TextSpan(
                                  text: "Cerrado ",
                                  style: CustomTextStyles.bodyMediumRed900),
                              TextSpan(
                                  text:
                                      "Abre a las 10 a. m. del mié\n+52(55) 4122-8200\ninfo@museotamayo.org\n",
                                  style: CustomTextStyles.bodyMediumCyan900)
                            ]),
                            textAlign: TextAlign.left)))
              ]))
        ]));
  }



  /// Section Widget

  /// Navigates to the frmmarcadoresScreen when the action is triggered.
  onTapRegresar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmmarcadoresScreen);
  }

  /// Navigates to the frmnewreseAScreen when the action is triggered.
  onTapReseas(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmnewreseAScreen);
  }
}

