import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/controlers/signup_controller.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class FrmregistroScreen extends StatelessWidget {
  FrmregistroScreen({Key? key}) : super(key: key);

  TextEditingController textFieldOutlineNombre = TextEditingController();
  TextEditingController textFieldOutlineApellido = TextEditingController();
  TextEditingController textFieldOutlineCorreo = TextEditingController();
  TextEditingController textFieldOutlineContrasena = TextEditingController();
  final controller = Get.put(SignupController());
  final formkey = GlobalKey<FormState>();
  void signup() {
    controller.signUp(
        email: textFieldOutlineCorreo.text,
        password: textFieldOutlineContrasena.text,
        name: textFieldOutlineNombre.text,
        lastName: textFieldOutlineApellido.text);
  }

  void logInAnonymously() async {
    await AuthMethods().logInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 38.v),
                child: Form(
                    key: formkey,
                    child: Column(children: [
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
                    ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 21.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgStroke2Red500,
            margin: EdgeInsets.only(left: 10.h, top: 6.v, bottom: 86.v),
            onTap: () {
              onTapStrokeTwo(context);
            }),
        centerTitle: true,
        title: AppbarTitle(
            text:
                " ⠀⠀Estás a unos pasos de una \n ⠀⠀experiencia turística más \n ⠀⠀ ⠀⠀ ⠀⠀ personal!"));
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
      hintText: "Correo electronico",
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
    return CustomElevatedButton(
      height: 45.v,
      text: "Registrarme",
      buttonStyle: CustomButtonStyles.fillPrimaryTL22,
      onPressed: () {
        if (formkey.currentState!.validate()) {
          signup();
        }
      },
    );
  }

  /// Section Widget
  Widget _buildCancelarQuieroSeguirComo(BuildContext context) {
    return CustomElevatedButton(
        height: 46.v,
        text: "Quiero seguir como invitado",
        buttonStyle: CustomButtonStyles.radiusTL23,
        onPressed: () {
          logInAnonymously();
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
