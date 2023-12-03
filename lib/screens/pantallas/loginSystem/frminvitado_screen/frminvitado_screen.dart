import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/repositories/auth/controlers/signout_controller.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmwelcome_screen/frmwelcome_screen.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';

class FrminvitadoScreen extends StatefulWidget {
  const FrminvitadoScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<FrminvitadoScreen> createState() => _FrminvitadoScreenState();
}

class _FrminvitadoScreenState extends State<FrminvitadoScreen> {
  final controller = Get.put(SignoutController());

  void signOut() async {
    await controller.signout();
    Get.to(FrmwelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 42.h,
            vertical: 25.v,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: AppDecoration.outlineBlack,
                child: Text(
                  "TURISTEANDO ANDO \n",
                  style: CustomTextStyles.titleLargeBlack900,
                ),
              ),
              SizedBox(height: 5.v),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 1.h,
                  vertical: 14.v,
                ),
                decoration: AppDecoration.fillGray.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 14.v),
                    SizedBox(
                      width: 272.h,
                      child: Text(
                        "¡Bienvenido como usuario invitado! Estamos encantados de que te unas a nosotros. \n\nSi bien no tendrás acceso a todas las funcionalidades y contenido exclusivo, aún puedes disfrutar de una parte de nuestra plataforma. \n\n ¡Comienza tu experiencia con nosotros ahora!",
                        maxLines: 11,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.titleSmallMontserratGray600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildContinueButton(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        signOut();
      },
      height: 40.v,
      text: "Continuar",
      buttonStyle: CustomButtonStyles.fillPrimaryTL22,
      margin: EdgeInsets.only(
        left: 30.h,
        right: 30.h,
        bottom: 32.v,
      ),
      buttonTextStyle: CustomTextStyles.titleMediumNunitoOnPrimary18,
    );
  }
}
