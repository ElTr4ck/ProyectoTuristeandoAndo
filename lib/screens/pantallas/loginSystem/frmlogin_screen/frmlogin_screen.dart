import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class FrmloginScreen extends StatelessWidget {
  FrmloginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController contrasenaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: SizedBox(
                    height: 778.v,
                    width: double.maxFinite,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                              height: 441.v,
                              width: double.maxFinite,
                              child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    CustomImageView(
                                        imagePath: ImageConstant.imgFondo,
                                        height: 441.v,
                                        width: 360.h,
                                        alignment: Alignment.center),
                                    CustomImageView(
                                        imagePath: ImageConstant.imgStroke2,
                                        height: 10.v,
                                        width: 5.h,
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                            left: 16.h, top: 16.v),
                                        onTap: () {
                                          onTapImgStrokeTwo(context);
                                        })
                                  ]))),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            //color: color.white,
                              margin: EdgeInsets.only(
                                  left: 34.h, right: 34.h, bottom: 5.v),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.h, vertical: 13.v),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder40),

                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 15.v),
                                    SizedBox(
                                        width: 149.h,
                                        child: Text("Bienvenido a Turisteando ",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles
                                                .titleLargeBlack90022)),
                                    Divider(indent: 20.h, endIndent: 20.h),
                                    SizedBox(height: 51.v),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 19.h, right: 20.h),
                                        child: CustomTextFormField(
                                            controller: emailController,
                                            hintText: "E-mail",
                                            textInputType:
                                                TextInputType.emailAddress)),
                                    SizedBox(height: 19.v),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.h),
                                        child: CustomTextFormField(
                                            controller: contrasenaController,
                                            hintText: "Contraseña",
                                            textInputAction:
                                                TextInputAction.done)),
                                    SizedBox(height: 78.v),
                                    CustomElevatedButton(
                                        height: 57.v,
                                        text: "Iniciar sesión",
                                        buttonTextStyle:
                                            theme.textTheme.titleLarge!,
                                        onPressed: (){
                                          onTapSetLocation(context);
                                        },
                                            ),
                                    SizedBox(height: 30.v),
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "¿Olvidaste tu contraseña?",
                                              style: CustomTextStyles
                                                  .titleMediumBlack900),
                                          TextSpan(text: " ")
                                        ]),
                                        textAlign: TextAlign.left),
                                    GestureDetector(
                                        onTap: () {
                                          onTapTxtHazClickAqu(context);
                                        },
                                        child: Text("Haz click aquí",
                                            style: theme.textTheme.titleMedium))
                                  ])))
                    ])))));
  }

  /// Navigates to the frmwelcomeScreen when the action is triggered.
  onTapImgStrokeTwo(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmwelcomeScreen);
  }

  /// Navigates to the frmcontraseAScreen when the action is triggered.
  onTapTxtHazClickAqu(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmcontraseAScreen);
  }

  onTapSetLocation(BuildContext context) {
    //Aqui va la logica del login, recomiendo usar una clase aparte o como lo tengan, cuando se cumpla la condicion ya mandas
    //a llamar al metodo Navigator.push
    Navigator.pushNamed(context, AppRoutes.frmSetLocation);
  }
}