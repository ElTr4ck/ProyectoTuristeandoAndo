import 'package:flutter/material.dart';
import 'package:turisteando_ando/screensDev/core/app_export.dart';
import 'package:turisteando_ando/screensDev/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/screensDev/widgets/custom_text_form_field.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController contraseaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgFondo,
                height: 350.v,
                width: 360.h,
                alignment: Alignment.topCenter,
              ),
              Container(
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
                      //width: 900.h,
                      child: Text(
                        "Bienvenido a Turisteando",
                        maxLines: 2,
                        //overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.titleLargeBlack900,
                      ),
                    ),
                    CustomTextFormField(
                      width: 227.h,
                      controller: emailController,
                      hintText: "E-mail",
                      textInputType: TextInputType.emailAddress,
                      alignment: Alignment.bottomCenter,
                    ),
                    CustomTextFormField(
                      controller: contraseaController,
                      hintText: "Contraseña",
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 100.v),
                    CustomElevatedButton(
                      buttonStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff114C5F),
                        ),
                      ),
                      text: "Iniciar sesión",
                    ),
                    SizedBox(height: 27.v),
                  ],
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
