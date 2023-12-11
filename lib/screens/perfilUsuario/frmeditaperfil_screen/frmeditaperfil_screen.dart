import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_title.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class FrmeditaperfilScreen extends StatelessWidget {
  FrmeditaperfilScreen({Key? key}) : super(key: key);

  TextEditingController fullNameController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                                        style: CustomTextStyles.titleSmallSemiBold)),
                                SizedBox(height: 3.v),
                                _buildFullName(context),
                                SizedBox(height: 12.v),
                                Padding(
                                    padding: EdgeInsets.only(left: 21.h),
                                    child: Text("Nombre de usuario",
                                        style: CustomTextStyles.titleSmallSemiBold)),
                                SizedBox(height: 3.v),
                                _buildUsername(context),
                                SizedBox(height: 12.v),
                                Padding(
                                    padding: EdgeInsets.only(left: 21.h),
                                    child: Text("E-mail",
                                        style: CustomTextStyles.titleSmallSemiBold)),
                                SizedBox(height: 3.v),
                                _buildEmail(context),
                                SizedBox(height: 11.v),
                                Padding(
                                    padding: EdgeInsets.only(left: 21.h),
                                    child: Text("Dirección",
                                        style: CustomTextStyles.titleSmallSemiBold)),
                                SizedBox(height: 7.v),
                                _buildAddress(context),
                                SizedBox(height: 11.v),
                                Padding(
                                    padding: EdgeInsets.only(left: 21.h),
                                    child: Text("Contraseña",
                                        style: CustomTextStyles.titleSmallSemiBold)),
                                SizedBox(height: 4.v),
                                _buildPassword(context),
                                SizedBox(height: 5.v)
                              ]))
                    ]))),
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
                        height: 52.v,
                        leadingWidth: 38.h,
                        leading: AppbarLeadingImage(
                            imagePath: ImageConstant.imgRegresar,
                            margin: EdgeInsets.only(
                                left: 33.h, top: 12.v, bottom: 12.v),
                            onTap: () {
                              onTapRegresar(context);
                            }),
                        title: AppbarTitle(
                            text: "UserNameXx",
                            margin: EdgeInsets.only(left: 86.h)))
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
                        child: CustomImageView(
                            imagePath: ImageConstant.imgImgprofile105x105,
                            height: 105.adaptSize,
                            width: 105.adaptSize,
                            radius: BorderRadius.circular(52.h),
                            alignment: Alignment.center)),
                    SizedBox(height: 7.v),
                    Container(
                        width: 96.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 17.h, vertical: 1.v),
                        decoration: AppDecoration.fillOnPrimary.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder8),
                        child: Text("Cambiar foto",
                            style: theme.textTheme.labelMedium))
                  ])))
        ]));
  }


  Widget _buildPersonalDataButton(BuildContext context) {
    return CustomElevatedButton(text: "Datos personales");
  }


  Widget _buildFullName(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: CustomTextFormField(
            controller: fullNameController,
            hintText: "Nombre completo",
            alignment: Alignment.center));
  }


  Widget _buildUsername(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: CustomTextFormField(
            controller: usernameController,
            hintText: "Nombre de usuario",
            alignment: Alignment.center));
  }


  Widget _buildEmail(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: CustomTextFormField(
            controller: emailController,
            hintText: "correo_ejemplo@gmail.com",
            textInputType: TextInputType.emailAddress,
            alignment: Alignment.center));
  }


  Widget _buildAddress(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: CustomTextFormField(
            controller: addressController,
            hintText: "Calle, número. Código postal, Localidad...",
            alignment: Alignment.center));
  }


  Widget _buildPassword(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.h),
        child: CustomTextFormField(
            controller: passwordController,
            hintText: "Contraseña de la cuenta",
            textInputAction: TextInputAction.done,
            alignment: Alignment.center,
            suffix: Container(
                margin: EdgeInsets.fromLTRB(30.h, 13.v, 12.h, 12.v),
                child: CustomImageView(
                    imagePath: ImageConstant.imgMostrar,
                    height: 15.v,
                    width: 16.h)),
            suffixConstraints: BoxConstraints(maxHeight: 40.v),
            obscureText: true,
            contentPadding:
                EdgeInsets.only(left: 12.h, top: 11.v, bottom: 11.v)));
  }


  Widget _buildUpdateInfoButton(BuildContext context) {
    return CustomElevatedButton(
        height: 33.v,
        width: 235.h,
        text: "Actualizar Información",
        margin: EdgeInsets.only(left: 61.h, right: 64.h, bottom: 15.v),
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleSmallPoppinsGray5002);
  }


  onTapRegresar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmperfilScreen);
  }
}
