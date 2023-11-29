import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
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
                          buttonTextStyle: theme.textTheme.titleLarge!,
                          onPressed: () {
                            onTapIniciarSesin(context);
                          }),
                      SizedBox(height: 34.v),
                      _buildWelcomeScreen(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildWelcomeScreen(BuildContext context) {
    return Container(
        width: 352.h,
        margin: EdgeInsets.only(right: 8.h),
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
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
              width: 117.h,
              margin: EdgeInsets.only(bottom: 1.v),
              decoration: AppDecoration.outlineBlack,
              child: Text(
                  "⠀⠀⠀¿No tienes \n⠀⠀ cuenta?",
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleMediumOnPrimary17)),
          Padding(
              padding: EdgeInsets.only(left: 11.h),
              child: Column(children: [
                GestureDetector(
                    onTap: () {
                      onTapTxtRegistrate(context);
                    },
                    child:
                        Text("⠀⠀⠀Registrate", style: theme.textTheme.titleMedium)),
                GestureDetector(
                    onTap: () {
                      onTapTxtContinuacomoinvitado(context);
                    },
                    child: Text("⠀⠀⠀Continua como invitado",
                        style: CustomTextStyles.titleMediumTeal100))
              ]))
        ]));
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