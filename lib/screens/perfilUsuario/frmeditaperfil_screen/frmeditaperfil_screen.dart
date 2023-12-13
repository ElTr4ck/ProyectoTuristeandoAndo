import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/screens/perfilUsuario/frmperfil_screen/firestorePerfil_methods.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class FrmeditaperfilScreen extends StatefulWidget {
  FrmeditaperfilScreen({Key? key}) : super(key: key);
  @override
  _FrmeditaperfilScreenState createState() => _FrmeditaperfilScreenState();
}

class _FrmeditaperfilScreenState extends State<FrmeditaperfilScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: SizedBox(
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      _buildMainContent(context),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 21.v),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildPersonalDataButton(context),
                                SizedBox(height: 21.v),
                                Padding(
                                    padding: EdgeInsets.only(left: 21.h),
                                    child: Text("Nombre",
                                        style: CustomTextStyles
                                            .titleSmallSemiBold)),
                                SizedBox(height: 3.v),
                                _buildFullName(context),
                                SizedBox(height: 12.v),
                                Padding(
                                    padding: EdgeInsets.only(left: 21.h),
                                    child: Text("Apellido",
                                        style: CustomTextStyles
                                            .titleSmallSemiBold)),
                                SizedBox(height: 3.v),
                                _buildUsername(context),
                                SizedBox(height: 12.v),
                                Padding(
                                    padding: EdgeInsets.only(left: 21.h),
                                    child: Text("E-mail",
                                        style: CustomTextStyles
                                            .titleSmallSemiBold)),
                                SizedBox(height: 3.v),
                                _buildEmail(context),
                                SizedBox(height: 11.v),
                                Padding(
                                    padding: EdgeInsets.only(left: 21.h),
                                    child: Text("Contraseña",
                                        style: CustomTextStyles
                                            .titleSmallSemiBold)),
                                SizedBox(height: 6.v),
                                _buildPassword(context),
                                SizedBox(height: 5.v)
                              ]))
                    ])))),
            bottomNavigationBar: _buildUpdateInfoButton(context)));
  }

  Widget _buildMainContent(BuildContext context) {
    return SizedBox(
        height: 233.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  height: 191.v,
                  width: double.maxFinite,
                  child: Stack(alignment: Alignment.topCenter, children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgFondo191x360,
                        height: 191.v,
                        width: 360.h,
                        radius: BorderRadius.vertical(
                            bottom: Radius.circular(33.h)),
                        alignment: Alignment.center),
                    CustomAppBar(
                      leadingWidth: 30.h,
                      leading: Padding(
                          padding: EdgeInsets.only(top: 7.v, bottom: 16.v),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/frmperfil_screen.dart');
                              },
                              child: Icon(
                                Icons.arrow_back_outlined,
                                size: 30.h,
                                color: Colors.grey,
                              ))),
                      centerTitle: true,
                      title: FutureBuilder<String>(
                        future: obtenerNombreUsuarioActual(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LinearProgressIndicator(); // Muestra un indicador de carga mientras se espera el nombre de usuario
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text(
                              snapshot.data ??
                                  'Nombre de usuario no disponible',
                              style: theme.textTheme.headlineSmall
                                      ?.copyWith(color: Colors.black) ??
                                  const TextStyle(color: Colors.black),
                            );
                          }
                        },
                      ),
                    ),
                  ]))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(left: 121.h, right: 124.h),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                        height: 115.adaptSize,
                        width: 115.adaptSize,
                        padding: EdgeInsets.all(5.h),
                        decoration: AppDecoration.outlineBlack900.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder57),
                        child: FutureBuilder<String>(
                          future: obtenerImagenUsuarioActual(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se espera la foto del usuario
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return CustomImageView(
                                imagePath: snapshot.data ??
                                    ImageConstant
                                        .imageNotFound, // Usa la foto del usuario, o una imagen por defecto si no hay foto
                                height: 105.adaptSize,
                                width: 105.adaptSize,
                                radius: BorderRadius.circular(44.h),
                                alignment: Alignment.center,
                              );
                            }
                          },
                        )),
                    SizedBox(height: 7.v),

                    /// Opens the image picker to select an image from the gallery.
                    /// Returns the picked image file.
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                          maxWidth: 150.h,
                          maxHeight: 150.h,
                        );

                        if (pickedFile != null) {
                          final File imageFile = File(pickedFile.path);

                          // Sube la imagen a Firestore
                          final ref = FirebaseStorage.instance
                              .ref()
                              .child('profilePics')
                              .child(
                                  '${FirebaseAuth.instance.currentUser!.uid}.jpg');

                          await ref.putFile(imageFile);

                          final url = await ref.getDownloadURL();

                          // Actualiza el usuario en Firestore
                          await FirebaseFirestore.instance
                              .collection('usuarios')
                              .doc(FirebaseAuth.instance.currentUser?.uid)
                              .update({'photo': url});

                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 96.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 17.h, vertical: 1.v),
                        decoration: AppDecoration.fillOnPrimary.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder8),
                        child: Text("Cambiar foto",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelMedium),
                      ),
                    )
                  ])))
        ]));
  }

  Widget _buildPersonalDataButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Datos personales", buttonStyle: CustomButtonStyles.fillPrimary);
  }

  Widget _buildFullName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.h),
      child: CustomTextFormField(
          controller: fullNameController,
          hintText: "Nombre(s)",
          alignment: Alignment.center,
          autofocus: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese su nombre';
            }
            return null;
          }),
    );
  }

  Widget _buildUsername(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: CustomTextFormField(
            controller: usernameController,
            hintText: "Apellido",
            alignment: Alignment.center,
            autofocus: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su apellido';
              }
              return null;
            }));
  }

  Widget _buildEmail(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: CustomTextFormField(
          controller: emailController,
          hintText: "correo_ejemplo@gmail.com",
          textInputType: TextInputType.emailAddress,
          alignment: Alignment.center,
          autofocus: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese su correo electrónico';
            }
            return null;
          },
        ));
  }

  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.h),
      child: CustomTextFormField(
        autofocus: false,
        controller: passwordController,
        hintText: "Contraseña de la cuenta",
        textInputAction: TextInputAction.done,
        alignment: Alignment.centerLeft,
        suffix: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggleObscureText,
        ),
        obscureText: _obscureText,
        contentPadding: EdgeInsets.only(top: 11.v, bottom: 11.v),
        validator: (value) =>
            value!.isEmpty ? 'Por favor ingrese su contraseña' : null,
      ),
    );
  }

  Widget _buildUpdateInfoButton(BuildContext context) {
    return CustomElevatedButton(
      height: 33.v,
      width: 235.h,
      text: "Actualizar Información",
      margin: EdgeInsets.only(left: 61.h, right: 64.h, bottom: 15.v),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleSmallPoppinsGray5002,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            User? user = FirebaseAuth.instance.currentUser;
            await user?.updateEmail(emailController.text);
            await user?.updatePassword(passwordController.text);

            await FirebaseFirestore.instance
                .collection('usuarios')
                .doc(user?.uid)
                .set({
              'name': fullNameController.text,
              'lastname': usernameController.text,
              'emal': emailController.text,
            }, SetOptions(merge: true));

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Información actualizada con éxito')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al actualizar la información: $e')),
            );
          }
        } else {
          // Si al menos un campo no es válido, entonces muestra un mensaje
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Por favor complete todos los campos')),
          );
        }
      },
    );
  }

  onTapRegresar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmperfilScreen);
  }
}
