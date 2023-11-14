import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turisteando_ando/resources/auth_methods.dart';
import 'package:turisteando_ando/screensDev/utils/colors.dart';
import 'package:turisteando_ando/screensDev/utils/utils.dart';
import 'package:turisteando_ando/screensDev/widgets/text_field_input.dart';

import 'package:turisteando_ando/screensDev/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/screensDev/widgets/custom_text_form_field.dart';
import 'package:turisteando_ando/screensDev/core/app_export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      //
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgFondo,
                height: 300.v,
                width: 400.h,
                alignment: Alignment.topCenter,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 34.h,
                    right: 34.h,
                    bottom: 5.v,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 55.v,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder40,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 200.h,
                        child: Text(
                          "Bienvenido a Turisteando ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.titleLargeBlack900,
                        ),
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: "E-mail",
                        textInputType: TextInputType.emailAddress,
                        alignment: Alignment.bottomCenter,
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: "Contraseña",
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                      ),
                      SizedBox(height: 78.v),
                      CustomElevatedButton(
                        buttonStyle: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff114C5F))),
                        onPressed: loginUser,
                        text: "Iniciar sesión",
                      ),
                      SizedBox(height: 27.v),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 297.h,
                  margin: EdgeInsets.only(bottom: 48.v),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "¿Olvidaste tu contraseña?",
                          style: CustomTextStyles.titleMediumBlack900,
                        ),
                        TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: "Haz click aquí",
                          style: CustomTextStyles.titleMediumTeal200,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
