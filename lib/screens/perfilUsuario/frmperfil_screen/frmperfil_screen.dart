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
            SizedBox(height: 19.v),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.h),
                child: _buildBestCalif(context,
                    mejorCalificados: "Lugares para ti")),
            SizedBox(height: 8.v),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.h),
                child: _buildBestCalif(context,
                    mejorCalificados: "Mejor calificados")),
            SizedBox(height: 6.v),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.h),
                child:
                    _buildBestCalif(context, mejorCalificados: "En tendencia")),
            SizedBox(height: 47.v),
            _buildContenido(context),
            SizedBox(height: 14.v),
            _buildMarcadores(context),
            SizedBox(height: 6.v),
            _buildHistorial(context),
            SizedBox(height: 5.v),
            _buildRutaMensual(context),
            SizedBox(height: 50.v),
            _buildPreferencias(context),
            SizedBox(height: 16.v),
            _buildLenguaje(context),
            SizedBox(height: 5.v),
            _buildModoOscuro(context),
            SizedBox(height: 5.v),
            _buildCerrarSesion(context),
            SizedBox(height: 5.v)
          ]))
    ]))));
  }

  /// Section Widget
  Widget _buildEditarPerfil(BuildContext context) {
    return CustomElevatedButton(
        height: 20.v,
        width: 97.h,
        text: "Editar perfil",
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle:
            theme.textTheme.labelLarge!.copyWith(color: Colors.white),
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
              height: 200.v,
              width: 360.h,
              radius: BorderRadius.vertical(bottom: Radius.circular(33.h)),
              alignment: Alignment.topCenter),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(left: 31.h, right: 21.h),
                  child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
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
                              SizedBox(height: 85.v),
                              Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 105.adaptSize,
                                            width: 105.adaptSize,
                                            padding: EdgeInsets.all(5.h),
                                            decoration: AppDecoration
                                                .outlineBlack900
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder52),
                                            child: FutureBuilder<String>(
                                              future:
                                                  obtenerImagenUsuarioActual(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
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
                                                        BorderRadius.circular(
                                                            44.h),
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: //Obtener el nombre de usuario de la BD
                                                          FutureBuilder<String>(
                                                        future:
                                                            obtenerNombreUsuarioActual(),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot<
                                                                    String>
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
                                                              style: theme
                                                                      .textTheme
                                                                      .headlineSmall
                                                                      ?.copyWith(
                                                                          color: Colors
                                                                              .white) ??
                                                                  const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            );
                                                          }
                                                        },
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child:
                                                        SizedBox(height: 5.v),
                                                  ),
                                                  _buildEditarPerfil(context)
                                                ]))
                                      ]))
                            ]),
                      ))))
        ]));
  }

  /// Section Widget
  Widget _buildTuContenidoPersonalizado(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF114C5F), // Cambia esto al color que prefieras
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Text(
        "Tu contenido personalizado",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold),
        textAlign:
            TextAlign.center, // Ajusta el color del texto según tu diseño
      ),
    );
  }

  /// Section Widget
  Widget _buildContenido(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF114C5F), // Cambia esto al color que prefieras
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Text(
        "Contenido",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold),
        textAlign:
            TextAlign.center, // Ajusta el color del texto según tu diseño
      ),
    );
  }

  /// Section Widget
  Widget _buildMarcadores(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/frmmarcadores_screen');
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.h),
          child: SingleChildScrollView(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: 18.adaptSize,
                width: 18.adaptSize,
                padding: EdgeInsets.symmetric(vertical: 1.v),
                decoration: AppDecoration.fillPrimaryContainer,
                child: CustomImageView(
                    imagePath: ImageConstant.imgHeart,
                    height: 16.v,
                    width: 18.h,
                    alignment: Alignment.center)),
            Padding(
                padding: EdgeInsets.only(left: 7.h),
                child: Text("Marcadores", style: theme.textTheme.titleSmall)),
            Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5.v),
                child: CustomIconButton(
                    height: 10.v,
                    width: 6.h,
                    child: CustomImageView(
                        imagePath: ImageConstant.imgArrowRightBlack90010x6)))
          ])),
        ));
  }

  /// Section Widget
  Widget _buildHistorial(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.h),
      child: SingleChildScrollView(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomImageView(
            imagePath: ImageConstant.imgClock,
            height: 16.adaptSize,
            width: 16.adaptSize,
            margin: EdgeInsets.only(top: 2.v)),
        Padding(
            padding: EdgeInsets.only(left: 7.h),
            child: Text("Historial", style: theme.textTheme.titleSmall)),
        Spacer(),
        Padding(
            padding: EdgeInsets.only(top: 5.v, bottom: 4.v),
            child: CustomIconButton(
                height: 10.v,
                width: 6.h,
                child: CustomImageView(
                    imagePath: ImageConstant.imgArrowRight10x6)))
      ])),
    );
  }

  /// Section Widget
  Widget _buildRutaMensual(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/frmRutaDestacada.dart');
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.h),
          child: SingleChildScrollView(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomImageView(
                imagePath: ImageConstant.imgStar,
                height: 17.adaptSize,
                width: 17.adaptSize),
            Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text("Ruta destacada mensual",
                    style: theme.textTheme.titleSmall)),
            Spacer(),
            Padding(
                padding: EdgeInsets.only(top: 5.v, bottom: 4.v),
                child: CustomIconButton(
                    height: 10.v,
                    width: 6.h,
                    child: CustomImageView(
                        imagePath: ImageConstant.imgArrowRight10x6)))
          ])),
        ));
  }

  /// Section Widget
  Widget _buildPreferencias(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF114C5F), // Cambia esto al color que prefieras
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Text(
        "Preferencias",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold),
        textAlign:
            TextAlign.center, // Ajusta el color del texto según tu diseño
      ),
    );
  }

  /// Section Widget
  Widget _buildLenguaje(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.h),
      child: SingleChildScrollView(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            CustomImageView(
                imagePath: ImageConstant.imgTranslate,
                height: 20.v,
                width: 21.h,
                margin: EdgeInsets.only(bottom: 2.v)),
            Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Text("Lenguaje", style: theme.textTheme.titleSmall)),
            Spacer(),
            Padding(
                padding: EdgeInsets.only(top: 5.v, bottom: 6.v),
                child: CustomIconButton(
                    height: 10.v,
                    width: 6.h,
                    child: CustomImageView(
                        imagePath: ImageConstant.imgArrowRight10x6)))
          ])),
    );
  }

  /// Section Widget
  Widget _buildModoOscuro(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.h),
      child: SingleChildScrollView(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            CustomImageView(
                imagePath: ImageConstant.imgMoon, height: 22.v, width: 23.h),
            Padding(
                padding: EdgeInsets.only(left: 1.h, bottom: 2.v),
                child: Text("Modo Oscuro", style: theme.textTheme.titleSmall)),
            Spacer(),
            Padding(
                padding: EdgeInsets.only(top: 5.v, bottom: 6.v),
                child: CustomIconButton(
                    height: 10.v,
                    width: 6.h,
                    child: CustomImageView(
                        imagePath: ImageConstant.imgArrowRight10x6)))
          ])),
    );
  }

  /// Section Widget
  Widget _buildCerrarSesion(BuildContext context) {
    final controllerSignOut = SignoutController(context: context);
    Future<void> signOut() async {
      await controllerSignOut.signout();
    }

    return InkWell(
      onTap: () async {
        await signOut();
        // ignore: use_build_context_synchronously
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Wrapper()),
            (route) => false);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.h),
        child: SingleChildScrollView(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
              CustomImageView(
                  imagePath: ImageConstant.imgClosesession,
                  height: 17.v,
                  width: 19.h,
                  margin: EdgeInsets.only(top: 4.v)),
              Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text("Cerrar Sesión",
                      style: CustomTextStyles.titleSmallSemiBold)),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(top: 7.v, bottom: 3.v),
                  child: CustomIconButton(
                      height: 10.v,
                      width: 6.h,
                      child: CustomImageView(
                          imagePath: ImageConstant.imgArrowRight10x6)))
            ])),
      ),
    );
  }

  /// Common widget
  Widget _buildBestCalif(
    BuildContext context, {
    required String mejorCalificados,
  }) {
    return SingleChildScrollView(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(mejorCalificados,
          style:
              theme.textTheme.titleSmall!.copyWith(color: appTheme.black900)),
      Padding(
          padding: EdgeInsets.only(top: 4.v, bottom: 5.v),
          child: CustomIconButton(
              height: 11.v,
              width: 6.h,
              child: CustomImageView(
                  imagePath: ImageConstant.imgArrowRightBlack900)))
    ]));
  }

  /// Navigates to the frmeditaperfilScreen when the action is triggered.
  onTapEditarPerfil(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmEditaPerfil);
  }
}
