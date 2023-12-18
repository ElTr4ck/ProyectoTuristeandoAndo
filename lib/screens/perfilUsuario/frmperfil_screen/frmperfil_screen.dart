import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/repositories/auth/controlers/signout_controller.dart';
import 'package:turisteando_ando/repositories/auth/wrapper.dart';
import 'package:turisteando_ando/screens/perfilUsuario/frmperfil_screen/firestorePerfil_methods.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_icon_button.dart';

class FrmperfilScreen extends StatelessWidget {
  const FrmperfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
      _buildTen(context),
      Container(
          padding: EdgeInsets.symmetric(vertical: 26.v),
          child: Column(children: [
            _buildTuContenidoPersonalizado(context),
            SizedBox(height: 14.v),
            _buildContenido(context),
            SizedBox(height: 14.v),
            _buildPreferencias(context),
            SizedBox(height: 16.v),
          ]))
    ]))));
  }

  Widget _buildWhiteBox(String text, IconData iconData, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.black,
              ),
              SizedBox(width: 8.0),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Nunito',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlueBox(String text) {
    return GestureDetector(
      child: Container(
        height: 35.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 76, 95),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Alinea al centro horizontalmente
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTuContenidoPersonalizado(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBlueBox("Contenido Personalizado"),
        SizedBox(height: 10.0),
        _buildWhiteBox(
          "Para ti",
          Icons.interests,
        ),
        _buildWhiteBox(
          "Mejores calificados",
          Icons.emoji_events,
        ),
        _buildWhiteBox(
          "En tendencia",
          Icons.trending_up,
        ),
      ],
    );
  }

  Widget _buildContenido(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBlueBox("Tu contenido"),
        SizedBox(height: 10.0),
        _buildWhiteBox(
          "Marcadores",
          Icons.favorite,
          onTap: () {
            Navigator.pushNamed(context, '/frmmarcadores_screen');
          },
        ),
        _buildWhiteBox(
          "Historial",
          Icons.update,
        ),
        _buildWhiteBox(
          "Ruta destacada",
          Icons.star,
          onTap: () {
            Navigator.pushNamed(context, '/frmRutaDestacada.dart');
          },
        ),
      ],
    );
  }

  Widget _buildPreferencias(BuildContext context) {
    final controllerSignOut = SignoutController(context: context);
    Future<void> signOut() async {
      await controllerSignOut.signout();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBlueBox("Tu contenido"),
        SizedBox(height: 10.0),
        _buildWhiteBox(
          "Idioma",
          Icons.language,
        ),
        _buildWhiteBox(
          "Modo oscuro",
          Icons.dark_mode,
        ),
        _buildWhiteBox(
          "Cerrar sesión",
          Icons.exit_to_app,
          onTap: () async {
            await signOut();
            // ignore: use_build_context_synchronously
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Wrapper()),
                (route) => false);
          },
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildEditarPerfil(BuildContext context) {
    return CustomElevatedButton(
        height: 20.v,
        width: 100.h,
        text: "Editar perfil",
        buttonStyle: CustomButtonStyles.fillTeal,
        buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
        onPressed: () {
          onTapEditarPerfil(context);
        },
        alignment: Alignment.centerRight);
  }

  /// Section Widget
  Widget _buildTen(BuildContext context) {
    return SizedBox(
        height: 252.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          CustomImageView(
              imagePath: ImageConstant.imgFondo,
              height: 193.v,
              width: 360.h,
              radius: BorderRadius.vertical(bottom: Radius.circular(33.h)),
              alignment: Alignment.topCenter),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(left: 31.h, right: 21.h),
                  child: SingleChildScrollView(
                      child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 500.v),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAppBar(
                            leadingWidth: 30.h,
                            leading: Padding(
                                padding:
                                    EdgeInsets.only(top: 7.v, bottom: 16.v),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/frminicio_page');
                                    },
                                    child: Icon(
                                      Icons.arrow_back_outlined,
                                      size: 30.h,
                                      color: Colors.grey,
                                    ))),
                            centerTitle: true,
                            title: Text("Perfil",
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 90.v),
                          Align(
                              alignment: Alignment.center,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 105.adaptSize,
                                        width: 105.adaptSize,
                                        padding: EdgeInsets.all(5.h),
                                        decoration: AppDecoration
                                            .outlineBlack900
                                            .copyWith(
                                                borderRadius: BorderRadiusStyle
                                                    .roundedBorder52),
                                        child: FutureBuilder<String>(
                                          future: obtenerImagenUsuarioActual(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<String> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator(); // Muestra un indicador de carga mientras se espera la foto del usuario
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              return CustomImageView(
                                                imagePath: snapshot.data ??
                                                    ImageConstant
                                                        .imageNotFound, // Usa la foto del usuario, o una imagen por defecto si no hay foto
                                                height: 95.adaptSize,
                                                width: 95.adaptSize,
                                                radius:
                                                    BorderRadius.circular(44.h),
                                                alignment: Alignment.center,
                                              );
                                            }
                                          },
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.v, bottom: 24.v),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 200.h,
                                                  decoration: AppDecoration
                                                      .outlineBlack,
                                                  alignment: Alignment.center,
                                                  child: //Obtener el nombre de usuario de la BD
                                                      FutureBuilder<String>(
                                                    future:
                                                        obtenerNombreUsuarioActual(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<String>
                                                            snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return LinearProgressIndicator(); // Muestra un indicador de carga mientras se espera el nombre de usuario
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                            'Error: ${snapshot.error}');
                                                      } else {
                                                        return Text(
                                                          snapshot.data ??
                                                              'Nombre de usuario no disponible',
                                                          style: theme.textTheme
                                                                  .headlineSmall
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .white) ??
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        );
                                                      }
                                                    },
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: SizedBox(height: 5.v),
                                              ),
                                              _buildEditarPerfil(context)
                                            ]))
                                  ]))
                        ]),
                  ))))
        ]));
  }

  /// Navigates to the frmeditaperfilScreen when the action is triggered.
  onTapEditarPerfil(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmEditaPerfil);
  }
}
