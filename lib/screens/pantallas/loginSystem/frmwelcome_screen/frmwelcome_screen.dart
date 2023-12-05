import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/repositories/auth/auth_methods.dart';
import 'package:turisteando_ando/repositories/auth/wrapper.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';

class FrmwelcomeScreen extends StatelessWidget {
  const FrmwelcomeScreen({Key? key}) : super(key: key);

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
    Future<bool> logInAnonymously() async {
      bool res = await AuthMethods().logInAnonymously(context);
      return res;
    }

    return Container(
      width: 352.h,
      margin: EdgeInsets.only(right: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.v),
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
                child: Text("Registrate", style: theme.textTheme.titleMedium),
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
                onTap: () async {
                  bool res = await logInAnonymously();
                  if (res) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                        MaterialPageRoute(builder: (context) => new Wrapper()));
                  }
                },
                child: Text("Continua como invitado",
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /*
  onTap: () async {
                      bool res = await logInAnonymously();
                      if (res) {
                        // ignore: use_build_context_synchronously
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) => new Wrapper()));
                      }
  */

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
