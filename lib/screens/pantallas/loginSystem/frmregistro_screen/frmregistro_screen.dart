import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/controlers/signup_controller.dart';
import 'package:turisteando_ando/repositories/auth/wrapper.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_text_form_field.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title_image.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_drop_down.dart';

// ignore_for_file: must_be_immutable
class FrmregistroScreen extends StatelessWidget {
  FrmregistroScreen({Key? key}) : super(key: key);

  TextEditingController textFieldOutlineNombre = TextEditingController();
  TextEditingController textFieldOutlineApellido = TextEditingController();
  TextEditingController textFieldOutlineCorreo = TextEditingController();
  TextEditingController textFieldOutlineContrasena = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(context),
            body: Form(
                key: formkey,
                child: Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgLogo,
                          height: 150,
                          width: 150,
                          alignment: Alignment.topCenter,
                        ),
                        SizedBox(height: 20.v),
                        _buildSeventeen(context),
                        SizedBox(height: 32.v),
                        _buildTextFieldOutline(context),
                        SizedBox(height: 15.v),
                        _buildTextFieldOutline1(context),
                        SizedBox(height: 15.v),
                        _buildTextFieldOutline2(context),
                        SizedBox(height: 15.v),
                        _buildTextFieldOutline3(context),
                        Spacer(),
                        _buildRegistrarme(context),
                        SizedBox(height: 8.v),
                        _buildCancelarQuieroSeguirComo(context)
                      ]),
                ))));
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

  Widget _buildSeventeen(BuildContext context) {
    return SizedBox(
      height: 100.v,
      width: 328.h,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        // Ensure CustomImageView is placed before the text widgets
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 328.h,
            decoration: AppDecoration.outlineBlack,
            child: Text(
              "¡Estás a unos pasos de una experiencia turística más personal!",
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  /// Section Widget NOMBRE
  Widget _buildTextFieldOutline(BuildContext context) {
    return CustomTextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Campo obligatorio";
          } else if (value.toString().length > 20 ||
              RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value!)) {
            return "Ingresa un nombre valido";
          }
          return null;
        },
        controller: textFieldOutlineNombre,
        hintText: "Nombre",
        prefix: Container(
            margin: EdgeInsets.symmetric(horizontal: 13.h, vertical: 16.v),

            ///margin: EdgeInsets.fromLTRB(16.h, 17.v, 16.h, 16.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgUserUser,
                height: 25.v,
                width: 24.h)),
        prefixConstraints: BoxConstraints(maxHeight: 59.v),
        borderDecoration: TextFormFieldStyleHelper.radiusTL12);
  }

  /// Section Widget APELLIDOS
  Widget _buildTextFieldOutline1(BuildContext context) {
    ///
    return CustomTextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Campo obligatorio";
          } else if (value.toString().length > 20 ||
              RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value!)) {
            return "Ingresa un apellido valido";
          }
          return null;
        },
        controller: textFieldOutlineApellido,
        hintText: "Apellidos",
        prefix: Container(
            margin: EdgeInsets.symmetric(horizontal: 13.h, vertical: 16.v),

            ///margin: EdgeInsets.fromLTRB(16.h, 17.v, 16.h, 16.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgUserUser,
                height: 25.v,
                width: 24.h)),
        alignment: Alignment.center,
        prefixConstraints: BoxConstraints(maxHeight: 59.v),
        borderDecoration: TextFormFieldStyleHelper.radiusTL12);
  }

  /// Section Widget CORREO
  Widget _buildTextFieldOutline2(BuildContext context) {
    return CustomTextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo obligatorio";
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!)) {
          return "Correo invalido";
        }
        return null;
      },
      controller: textFieldOutlineCorreo,
      hintText: "Correo electrónico",
      textInputAction: TextInputAction.done,
      prefix: Container(
          margin: EdgeInsets.symmetric(horizontal: 13.h, vertical: 16.v),
          child: CustomImageView(
              imagePath: ImageConstant.imgVector, height: 25.v, width: 22.h)),
      prefixConstraints: BoxConstraints(maxHeight: 59.v),
      borderDecoration:

          ///************************
          TextFormFieldStyleHelper.custom,

      ///borderRadius: BorderRadius.circular(15.0),
      ///borderSide: BorderSide(
      ///    color: Color(0xFF9cd2d3))
    );
  }

  /// Section Widget CONTRASENA
  Widget _buildTextFieldOutline3(BuildContext context) {
    return CustomTextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Campo obligatorio";
          } else if (value.length < 6) {
            return "La contraseña debe contener al menos 6 caracteres";
          }
          return null;
        },
        obscureText: true,
        controller: textFieldOutlineContrasena,
        hintText: "Contraseña",
        textInputAction: TextInputAction.done,
        prefix: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 16.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgPassword1,
                height: 25.v,
                width: 24.h)),
        prefixConstraints: BoxConstraints(maxHeight: 59.v),
        borderDecoration: TextFormFieldStyleHelper.custom);
  }

  /// Section Widget
  Widget _buildRegistrarme(BuildContext context) {
    final controller = SignupController(context: context);
    Future<bool> signup() async {
      bool res = await controller.signUp(
          email: textFieldOutlineCorreo.text,
          password: textFieldOutlineContrasena.text,
          name: textFieldOutlineNombre.text,
          lastName: textFieldOutlineApellido.text);
      return res;
    }

    return CustomElevatedButton(
      height: 45.v,
      text: "Registrarse",
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
      onPressed: () async {
        if (formkey.currentState!.validate()) {
          bool res = await signup();
          if (res) Navigator.pop(context);
        }
      },
    );
  }

  /// Section Widget
  Widget _buildCancelarQuieroSeguirComo(BuildContext context) {
    Future<bool> logInAnonymously() async {
      bool res = await AuthMethods().logInAnonymously(context);
      return res;
    }

    return CustomElevatedButton(
        height: 46.v,
        text: "Continuar como invitado",
        buttonStyle: CustomButtonStyles.fillTeal,
        buttonTextStyle: CustomTextStyles.titleMediumOnPrimary17,
        onPressed: () async {
          bool res = await logInAnonymously();
          // ignore: use_build_context_synchronously
          if (res) {
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => new Wrapper()),
                (route) => false);
          }

          //onTapCancelarQuieroSeguirComo(context);
        });
  }

  /// Navigates to the frmwelcomeScreen when the action is triggered.
  onTapStrokeTwo(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmwelcomeScreen);
  }

  /// Navigates to the frminvitadoScreen when the action is triggered.
  onTapCancelarQuieroSeguirComo(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frminvitadoScreen);
  }
}
