import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';

class FrmwelcomeScreen extends StatelessWidget {
  const FrmwelcomeScreen({Key? key}) : super(key: key);
  void logInAnonymously() async {
    await AuthMethods().logInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Container(
                width: mediaQueryData.size.width,
                height: mediaQueryData.size.height,
                decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgFrmwelcome),
                        fit: BoxFit.cover)),
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 8.v),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Spacer(),
                      CustomElevatedButton(
                          height: 51.v,
                          text: "Iniciar sesión",
                          margin: EdgeInsets.only(left: 30.h, right: 20.h),
                          buttonStyle: CustomButtonStyles.fillPrimaryTL22,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnPrimary17,
                          onPressed: () {
                            onTapIniciarSesin(context);
                          }),
                      SizedBox(height: 34.v),
                      _buildWelcomeScreen(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildWelcomeScreen(BuildContext context) {
    return Center(
      child: Container(
        width: 352.h,
        margin: EdgeInsets.only(right: 8.h, left: 9.h),
        padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.v),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.circleBorder29,
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgGroup8),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.35),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿No tienes una cuenta?",
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleMediumOnPrimary17,
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    onTapTxtRegistrate(context);
                  },
                  child: Text(
                    "Regístrate",
                    style: CustomTextStyles.titleMediumTeal100,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "ó",
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleMediumOnPrimary17,
                ),
                SizedBox(width: 10),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    logInAnonymously();
                    //onTapTxtContinuacomoinvitado(context);
                  },
                  child: Text(
                    "Continúa como invitado",
                    style: CustomTextStyles.titleMediumTeal100,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Navigates to the frmloginScreen when the action is triggered.
  onTapIniciarSesin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmloginScreen);
  }

  /// Navigates to the frmregistroScreen when the action is triggered.
  onTapTxtRegistrate(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmregistroScreen);
  }

  /// Navigates to the frminvitadoScreen when the action is triggered.
  onTapTxtContinuacomoinvitado(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frminvitadoScreen);
  }
}
