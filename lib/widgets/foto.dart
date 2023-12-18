import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/pantallas/presentation/frmrese_a_tab_container_screen/frmrese_a_tab_container_screen2.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';

class Foto extends StatefulWidget {
  final String url; //url de la foto
  const Foto({required this.url, super.key});

  @override
  State<Foto> createState() => _FotoState(url);
}

class _FotoState extends State<Foto> {
  final String url;
  _FotoState(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Center(
            child: InteractiveViewer(
          panEnabled: false, // Set it to false
          boundaryMargin: EdgeInsets.all(100),
          minScale: 0.5,
          maxScale: 2,
          child: Image.network(url, loadingBuilder: (BuildContext context,
              Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; //condiciones para mostrar la imagen si ya esta cargada o CircularProgressIndicator
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }),
        )));
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return CustomAppBar(
      height: 60.v,
      leadingWidth: 24.h,
      leading: Padding(
          padding: EdgeInsets.only(top: 7.v, bottom: 16.v),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context); //pop para no volver a cargar el inicio
              },
              child: Icon(
                Icons.arrow_back_outlined,
                size: 30.h,
                color: Colors.grey,
              ))),
      centerTitle: true,
      title: Text(
        "Información del lugar",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Nunito'),
      ));
}
