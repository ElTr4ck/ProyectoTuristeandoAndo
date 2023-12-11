import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';

class FrmreportarreseAScreen extends StatelessWidget {
  const FrmreportarreseAScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 2.v),
                child: Column(children: [
                  Container(
                      width: 291.h,
                      margin: EdgeInsets.only(left: 13.h, right: 14.h),
                      child: Text(
                          "Si has encontrado una reseña que consideras ofensiva o inapropiada, por favor, háznoslo saber. \n\nReporta la reseña y ayúdanos a garantizar que nuestro espacio sea seguro y acogedor para todos los usuarios.",
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium)),
                  SizedBox(height: 24.v),
                  _buildReview(context),
                  SizedBox(height: 96.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 109.h),
                          child: Text("Motivos",
                              style: theme.textTheme.titleLarge))),
                  SizedBox(height: 17.v),
                  _buildReview1(context),
                  SizedBox(height: 83.v),
                  CustomElevatedButton(
                      text: "Reportar",
                      margin: EdgeInsets.only(left: 41.h, right: 42.h),
                      buttonStyle: CustomButtonStyles.fillPrimaryTL16),
                  SizedBox(height: 14.v),
                  CustomElevatedButton(
                      text: "Cancelar",
                      margin: EdgeInsets.only(left: 41.h, right: 42.h),
                      buttonStyle: CustomButtonStyles.fillTealTL16),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 23.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown2,
            margin: EdgeInsets.only(left: 18.h, top: 17.v, bottom: 28.v),
            onTap: () {
              onTapRegresar(context);
            }),
        centerTitle: true,
        title: AppbarSubtitleOne(text: "Reportar Reseña"));
  }

  /// Section Widget
  Widget _buildReview(BuildContext context) {
    return Container(
        width: 317.h,
        margin: EdgeInsets.only(right: 1.h),
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder33),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              Padding(
                  padding: EdgeInsets.only(right: 49.h),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                            imagePath: ImageConstant.imgAvatar,
                            height: 32.adaptSize,
                            width: 32.adaptSize,
                            radius: BorderRadius.circular(16.h),
                            margin: EdgeInsets.only(top: 3.v, bottom: 7.v)),
                        Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 12.h),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Anonimo",
                                          style: theme.textTheme.titleMedium),
                                      SizedBox(height: 6.v),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 1.v),
                                                child: CustomRatingBar(
                                                    initialRating: 0,
                                                    itemSize: 12)),
                                            Text("10/25/2023 7:23:23 PM",
                                                style:
                                                    theme.textTheme.labelLarge)
                                          ])
                                    ])))
                      ])),
              SizedBox(height: 8.v),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 247.h,
                      margin: EdgeInsets.only(left: 43.h, right: 1.h),
                      child: Text(
                          "Este lugar es una porquería. El personal es tan inútil que me pregunto cómo consiguen trabajar aquí. No pierdan su tiempo ni su dinero",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium)))
            ]));
  }

  /// Section Widget
  Widget _buildReview1(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 1.h),
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder33),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomImageView(
                    imagePath: ImageConstant.imgUserphoto132x34,
                    height: 32.v,
                    width: 34.h,
                    radius: BorderRadius.circular(17.h),
                    margin: EdgeInsets.only(top: 2.v, bottom: 7.v)),
                Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("UserNameXx",
                              style: theme.textTheme.titleMedium),
                          SizedBox(height: 6.v),
                          Text("11/25/2023 10:53:02 AM",
                              style: theme.textTheme.labelLarge)
                        ]))
              ]),
              SizedBox(height: 8.v),
              Container(
                  width: 278.h,
                  margin: EdgeInsets.only(left: 10.h, right: 4.h),
                  child: Text(
                      "Me parece un comentario muy afensivo y nada a corde a la experiencia que se vive en el lugar.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium))
            ]));
  }

  /// Navigates to the frmreseATabContainerScreen when the action is triggered.
  onTapRegresar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmreseATabContainerScreen);
  }
}
