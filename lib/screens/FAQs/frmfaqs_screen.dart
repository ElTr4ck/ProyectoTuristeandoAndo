import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/repositories/auth/firestore_methods.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title_image.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';

class FrmfaqsScreen extends StatefulWidget {
  FrmfaqsScreen({Key? key}) : super(key: key);

  @override
  _MyFrmfaqsScreenState createState() => _MyFrmfaqsScreenState();
}

class _MyFrmfaqsScreenState extends State<FrmfaqsScreen> {
  @override
  void initState() {
    super.initState();
    fetchData(); //obtengo las faq de la bd
  }

//QUESTIONS AND ANSWERS CREATED BY DOCUMENTATION TEAM
  List<List<String>> dropdownItemList = [];
  List<bool> _isExpandedList = []; //variable para lista expandida
  fetchData() async {
    List<Map<String, dynamic>> datos = await StoreMethods().getFAQS();
    List<List<String>> aux = [];

    for (int i = 0; i < datos.length; i++) {
      List<String> faq = [];
      faq.add(
          datos[i]["pregunta"]); //guardo la pregunta y repuesta en una lista
      faq.add(datos[i]["respuesta"]);
      _isExpandedList
          .add(false); //variable para saber si se meustra la lista expandida
      aux.add(faq); //guardo la lista faq en otra lista
    }

    setState(() {
      dropdownItemList.addAll(aux); //actualizo la listas de preguntas
      print(dropdownItemList);
    });
  }

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
                    height: 499.v,
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
        padding: EdgeInsets.symmetric(horizontal: 7.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(dropdownItemList.length, (index) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.v),
                  child: _buildQuestionTile(
                    index, //index, lo utilizo para saber si se muestra la lista expandida
                    dropdownItemList[index][0], //pregunta
                    dropdownItemList[index][1], //respuesta
                  ));
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTile(int index, String question, String answer) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2), // Color gris con opacidad
            borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
          ),
          //margin: EdgeInsets.symmetric(vertical: 0.5), // Margen vertical
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
