import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_text_form_field.dart';

class FrmcontraseAScreen extends StatelessWidget {
  FrmcontraseAScreen({Key? key}) : super(key: key);

  TextEditingController textFieldOutlineCorreo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSeventeen(context),
                      SizedBox(height: 43.v),
                      _buildTextFieldOutline(context),
                      SizedBox(height: 51.v),
                      CustomElevatedButton(
                          text: "Enviar",
                          margin: EdgeInsets.only(left: 46.h, right: 47.h),
                          buttonStyle: CustomButtonStyles.fillPrimaryTL16,
                          onPressed: () {
                            onTapEnviar(context);
                          }),
                      SizedBox(height: 14.v),
                      CustomElevatedButton(
                          text: "Cancelar",
                          margin: EdgeInsets.only(left: 46.h, right: 47.h),
                          buttonStyle: CustomButtonStyles.fillTeal,
                          onPressed: () {
                            onTapCancelar(context);
                          })
                    ]))));
  }

  /// Section Widget
  Widget _buildSeventeen(BuildContext context) {
    return SizedBox(
        height: 154.v,
        width: 328.h,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: 328.h,
                  decoration: AppDecoration.outlineBlack,
                  child: Text("¿Olvidaste tu contraseña?\n",
                      textAlign: TextAlign.center,
                      maxLines: null,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall!
                          .copyWith(height: 1.41)))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 26.h),
                  padding:
                  EdgeInsets.symmetric(horizontal: 22.h, vertical: 6.v),
                  decoration: AppDecoration.fillGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder12),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 1.v),
                        SizedBox(
                            width: 230.h,
                            child: Text(
                                "Ingresa el correo electrónico con el que te registraste. \nTe enviaremos un link para restablecer tu contraseña",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles
                                    .titleMediumOnPrimaryContainer
                                    .copyWith(height: 1.41)))
                      ])))
        ]));
  }

  /// Section Widget CORREO
  Widget _buildTextFieldOutline(BuildContext context) {
    return CustomTextFormField(
        controller: textFieldOutlineCorreo,
        hintText: "Correo electronico",
        textInputAction: TextInputAction.done,
        prefix: Container(
            margin: EdgeInsets.symmetric(horizontal: 13.h, vertical: 16.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgVector, height: 25.v, width: 22.h)),
        prefixConstraints: BoxConstraints(maxHeight: 59.v),
        borderDecoration:///************************
          TextFormFieldStyleHelper.custom
    );
  }

  /// Navigates to the frmcorreoScreen when the action is triggered.
  onTapEnviar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmcorreoScreen);
  }

  /// Navigates to the frmloginScreen when the action is triggered.
  onTapCancelar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmloginScreen);
  }
}
