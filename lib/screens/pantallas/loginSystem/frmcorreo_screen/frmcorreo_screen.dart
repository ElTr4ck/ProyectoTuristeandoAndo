import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/repositories/auth/controlers/mail_verification.dart';
import 'package:turisteando_ando/repositories/auth/controlers/signout_controller.dart';
import 'package:turisteando_ando/screens/pantallas/loginSystem/frmwelcome_screen/frmwelcome_screen.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';

class FrmcorreoScreen extends StatefulWidget {
  const FrmcorreoScreen({Key? key}) : super(key: key);

  @override
  State<FrmcorreoScreen> createState() => _FrmcorreoScreenState();
}

class _FrmcorreoScreenState extends State<FrmcorreoScreen> {
  final controllerSignOut = Get.put(SignoutController());

  void signOut() async {
    await controllerSignOut.signout();
    Get.to(FrmwelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 17.v),
                child: Column(children: [
                  Container(
                      width: double.maxFinite,
                      decoration: AppDecoration.outlineBlack,
                      child: Text("¡Revisa tu correo electrónico!\n",
                          maxLines: null,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineSmall!
                              .copyWith(height: 1.41))),
                  SizedBox(height: 5.v),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 42.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.h, vertical: 9.v),
                      decoration: AppDecoration.fillGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder12),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 2.v),
                            SizedBox(
                                width: 244.h,
                                child: Text(
                                    "Hemos enviado un enlace para confirmar tu correo electrónico. \n Ingresa y sigue las instrucciones para completar el proceso.",
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: CustomTextStyles
                                        .titleLargeOnPrimaryContainer
                                        .copyWith(height: 1.41)))
                          ]))
                ])),
            bottomNavigationBar: _buildRegresarAInicio(context)));
  }

  /// Section Widget
  Widget _buildRegresarAInicio(BuildContext context) {
    return CustomElevatedButton(
        height: 40.v,
        text: "Sign out",
        margin: EdgeInsets.only(left: 30.h, right: 30.h, bottom: 41.v),
        buttonTextStyle: CustomTextStyles.titleMediumNunitoOnPrimary18,
        onPressed: () {
          signOut();
          //onTapRegresarAInicio(context);
        });
  }

  /// Navigates to the frmwelcomeScreen when the action is triggered.
  onTapRegresarAInicio(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmwelcomeScreen);
  }
}
