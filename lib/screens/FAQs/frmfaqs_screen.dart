import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title_image.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_drop_down.dart';

class FrmfaqsScreen extends StatefulWidget {
  FrmfaqsScreen({Key? key}) : super(key: key);

  @override
  _MyFrmfaqsScreenState createState() => _MyFrmfaqsScreenState();
}

// ignore: must_be_immutable
class _MyFrmfaqsScreenState extends State<FrmfaqsScreen> {
  List<bool> _isExpandedList = [
    false,
    false,
    false,
    false,
    false,
    false
  ]; // Inicializar con el número de preguntas

//QUESTIONS AND ANSWERS CREATED BY DOCUMENTATION TEAM
  //Check the "options", if is better only with the answer

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgLogo,
                    height: 150,
                    width: 150,
                    alignment: Alignment.topCenter,
                  ),
                  SizedBox(height: 13.v),
                  Container(
                    decoration: AppDecoration.outlineBlack,
                    child: Text("Estamos aquí para ayudarte",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 20, 76, 95),
                          fontFamily: 'Nunito',
                        )),
                  ),
                  SizedBox(height: 19.v),
                  Container(
                    width: 313.h,
                    margin: EdgeInsets.symmetric(horizontal: 23.h),
                    child: Text(
                      "La planificación de un viaje puede generar preguntas. No te preocupes, estamos aquí para ayudarte en cada etapa. Consulta nuestras preguntas frecuentes para respuestas rápidas y útiles.",
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                  //SizedBox(height: 1.h),
                  SizedBox(
                    //size: Size(double.infinity, double.infinity),
                    height: 510.v,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _buildQuestions(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: SizedBox(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            AppbarTitleImage(
              imagePath: ImageConstant.imgRegresar,
              margin: EdgeInsets.fromLTRB(5.h, 5.v, 318.h, 15.v),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildQuestions(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(6, (index) {
              return _buildQuestionTile(
                index,
                _getQuestion(index),
                _getAnswer(index),
              );
            }),
          ),
        ),
      ),
    );
  }

  String _getQuestion(int index) {
    switch (index) {
      case 0:
        return '¿Qué es TuristeandoAndo?';
      case 1:
        return '¿Cómo buscar lugares en TuristeandoAndo?';
      case 2:
        return '¿Cómo añadir un lugar a un itinerario?';
      case 3:
        return '¿Cómo visualizar un itinerario en TuristeandoAndo?';
      case 4:
        return '¿Cómo añadir y consultar favoritos?';
      case 5:
        return '¿Cómo cambiar las preferencias para visualizar lugares recomendados?';
      default:
        return '';
    }
  }

  String _getAnswer(int index) {
    switch (index) {
      case 0:
        return 'TuristeandoAndo es una aplicación diseñada con el objetivo de mejorar la experiencia de sus usuarios al momento de visitar una zona con fines turísticos. Desde consultar los lugares turísticos, personalizar recomendaciones según tus preferencias e intereses; armar itinerarios de viaje; consultar tiempos de recorrido de un punto a otro, ya sea que se elija ir a pie, en transporte público o en automóvil, TuristeandoAndo te proporciona rutas trazadas en un mapa interactivo para una mayor comodidad en tus viajes a lo largo de toda la república mexicana.';
      case 1:
        return 'Encuentra lugares de tu interés para visualizar la cercanía que tienes con ellos, traza una ruta, consulta detalles de contacto, revisa las opiniones de otros usuarios.\nPara encontrar un lugar: Desde la pantalla de inicio, presiona el ícono con un mapa en la barra de navegación inferior. En el mapa, escribe el lugar de tu interés en la barra de búsqueda superior y selecciónalo de las opciones desplegadas debajo de la barra. Al seleccionarlo, podrás visualizar su información y descubrir las funciones que TuristeandoAndo tiene para ti.';
      case 2:
        return 'Planea y organiza tus viajes tomando en cuenta los lugares que quieres visitar. Para crear un itinerario es importante que ingreses al sistema con una cuenta previamente creada. Al presionar sobre un lugar de interés (ya sea en alguno de los carruseles en la pantalla de inicio, en la pantalla del mapa o en la pantalla de favoritos; puedes acceder a ellas mediante la barra de navegación inferior), verás la información acerca de tal lugar, así como una sección con su calificación y diversos botones, localiza el botón con el nombre “Itinerario”. Al presionarlo, accederás a una pantalla que te mostrará el lugar dentro de una lista programada para el día actual. Para cambiar la fecha en la que planeas hacer tu visita a ese lugar, sólo debes presionar el ícono de reloj mostrado del lado derecho del mismo.';
      case 3:
        return 'Visualiza tus planes para tus viajes en una sola lista según la zona en la que te encuentres. Para visualizar un itinerario es importante que ingreses al sistema con una cuenta previamente creada. Al encontrarte en la pantalla de inicio, da clic en el ícono de la esquina superior izquierda; esta acción te permitirá visualizar un menú con varias opciones. Da clic en la opción “Rutas” para dirigirte a la pantalla que te permitirá visualizar un itinerario. Una vez ahí, podrás seleccionar la fecha que desees consultar a través del calendario desplegado al presionar sobre el ícono de la parte superior central.';
      case 4:
        return 'Personaliza los lugares a los que quieras ir y guárdalos para más tarde. Para añadir un lugar a favoritos: en la pantalla de inicio, podrás visualizar un carrusel de imágenes con el nombre de los lugares cercanos para ti. Al presionar sobre el ícono de corazón que se encuentra debajo del nombre, el lugar se añadirá a tu lista de favoritos. Para consultar lista de favoritos: En la barra de navegación inferior de la pantalla, dirígete al ícono de corazón; al presionarlo, podrás ver un carrusel de imágenes con los lugares que añadiste a tu lista.';
      case 5:
        return 'Actualiza tus preferencias de acuerdo a lo que desees hacer en diferentes momentos. Para cambiar tus preferencias: Al encontrarte en la pantalla de inicio, da clic en el ícono de la esquina superior izquierda; esta acción te permitirá visualizar un menú con varias opciones. Presiona la opción “Preferencias”, agrega y elimina las diferentes categorías según lo que estés buscando, presiona el botón “Continuar”. Los filtros de recomendaciones se actualizarán según tus nuevas preferencias.';
      default:
        return '';
    }
  }

  Widget _buildQuestionTile(int index, String question, String answer) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2), // Color gris con opacidad
            borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
          ),
          margin: EdgeInsets.symmetric(vertical: 8.0), // Margen vertical
          child: ListTile(
            title: Text(
              question,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(
              _isExpandedList[index] ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () {
              setState(() {
                _isExpandedList[index] = !_isExpandedList[index];
              });
            },
          ),
        ),
        if (_isExpandedList[index])
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          )
      ],
    );
  }
}
