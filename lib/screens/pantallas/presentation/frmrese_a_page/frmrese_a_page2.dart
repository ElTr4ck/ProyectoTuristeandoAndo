import '../frmrese_a_page/widgets/frmrese_a_item_widget2.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmnewrese_a_screen/frmnewrese_a_screen.dart';


class FrmreseAPage extends StatefulWidget {
  final String id;

  const FrmreseAPage({required this.id, Key? key}) : super(key: key);

  @override
  FrmreseAPageState createState() => FrmreseAPageState();
}

class FrmreseAPageState extends State<FrmreseAPage> with AutomaticKeepAliveClientMixin<FrmreseAPage> {
  List<Map<String, dynamic>> listaDatos = [];
  void onTapTxtAceptar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmnewreseAScreen);
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      // Tu lógica para obtener datos asíncronamente
      QuerySnapshot<Map<String, dynamic>> usuariosSnapshot =
      await FirebaseFirestore.instance.collection('usuarios').get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> usuariosDocumentos = usuariosSnapshot.docs;

      for (QueryDocumentSnapshot<Map<String, dynamic>> usuarioDocumento in usuariosDocumentos) {
        Map<String, dynamic> usuarioDatos = usuarioDocumento.data();
        String uid = usuarioDatos['uid'];

        Query<Map<String, dynamic>> preferenciasQuery = FirebaseFirestore.instance
            .collection('usuarios')
            .doc(uid)
            .collection('reviews')
            .where('idplace', isEqualTo: widget.id);

        QuerySnapshot<Map<String, dynamic>> preferenciasSnapshot = await preferenciasQuery.get();
        List<QueryDocumentSnapshot<Map<String, dynamic>>> documentosReviews = preferenciasSnapshot.docs;

        if (documentosReviews.isNotEmpty) {
          // Crea un mapa que contendrá la información del usuario junto con sus revisiones
          Map<String, dynamic> usuarioConRevisiones = {
            'usuarioDatos': usuarioDatos,
            'revisiones': documentosReviews.map((documentoReview) => documentoReview.data()).toList(),
          };

          // Agrega el mapa a la listaDatos
          listaDatos.add(usuarioConRevisiones);

          print('Usuario: $uid');
        }
      }
      print('Datos: $listaDatos');
      print(listaDatos.length);
      return listaDatos;
    } catch (e) {
      print('Error al obtener preferencias: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomCircularProgressIndicator(size: 1.0);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Padding(
            padding: EdgeInsets.only(top: 5.0), // Ajusta el valor según sea necesario
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "No hay reseñas registradas.",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  margin: EdgeInsets.symmetric(vertical: 6.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusStyle.roundedBorder9,
                  ),
                  child: Container(
                    height: 17.0,
                    width: 138.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder9,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 17.0,
                            width: 129.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FrmnewreseAScreen(id: widget.id,),
                                ),
                              );
                            },
                            child: Text(
                              "Escribir una reseña",
                              style: CustomTextStyles.labelLargeNunitoGray5002,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Cuando la consulta está completa, construye la interfaz de usuario
          List<Map<String, dynamic>> listaDatos = snapshot.data!;
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 21.0),
                child: Column(
                  children: [
                    SizedBox(height: 5.0),
                    Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Align(
                        alignment: Alignment.center, // Alineación cambiada a centro
                        child: Container(
                          decoration: AppDecoration.outlineBlack,
                          child: Text(
                            "Reseñas de la aplicación",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 17.0,
                          width: 138.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder9,
                          ),
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FrmnewreseAScreen(id: widget.id)),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusStyle.roundedBorder9,
                              ),
                            ),
                            child: Text(
                              "Escribir una reseña",
                              style: CustomTextStyles.labelLargeNunitoGray5002,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: generateResenasWidgets().length,
                        itemBuilder: (context, index) =>
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.v),
                              child: generateResenasWidgets()[index],
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  List<Widget> generateResenasWidgets() {
    List<Widget> reviewWidgets = [];
    for (var userReviewData in listaDatos) {
      for (var review in userReviewData['revisiones']) {
        // Pasa tanto los datos de la revisión como los datos del usuario al widget
        reviewWidgets.add(
          FrmreseAItemWidget(
            onTapView: (jsonData) => print('Revisada: $jsonData'),
            userData: userReviewData['usuarioDatos'],  // <-- aquí pasamos los datos del usuario
            reviewData: review,                        // <-- aquí pasamos la revisión individual
          ),
        );
      }
    }
    return reviewWidgets;
  }
  @override
  bool get wantKeepAlive => true;

  void onTapView(BuildContext context, {required Map<String, dynamic> jsonData}) {
    print('Revision presionada: $jsonData');
  }

}

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;

  CustomCircularProgressIndicator({required this.size});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder33,
        ),
      width: size,
      height: size,
          child: Center(
          child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF114C5F)),
    strokeWidth: 6.0,
    backgroundColor: Colors.grey,
    value: size / 10.0,
    ),
    ),
      ),
    );
  }
}
