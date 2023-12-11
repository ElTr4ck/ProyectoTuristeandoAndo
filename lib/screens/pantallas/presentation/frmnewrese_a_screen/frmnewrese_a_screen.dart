import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_leading_image.dart';
import 'package:turisteando_ando/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:turisteando_ando/widgets/app_bar/custom_app_bar.dart';
import 'package:turisteando_ando/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';

class FrmnewreseAScreen extends StatelessWidget {
  const FrmnewreseAScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 20.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 286.h,
                          margin: EdgeInsets.only(left: 18.h, right: 19.h),
                          child: Text(
                              "¡Nos encantaría conocer tu opinión acerca de este lugar! Comparte tu experiencia y ayuda a otros a descubrir lo que hace especial a este destino.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium)),
                      SizedBox(height: 43.v),
                      _buildReview(context),
                      Spacer(),
                      CustomElevatedButton(
                          width: 104.h,
                          text: "Agregar fotos",
                          buttonStyle: CustomButtonStyles.fillTealTL12,
                          buttonTextStyle: theme.textTheme.labelMedium!),
                      SizedBox(height: 58.v),
                      Text("Califica este lugar",
                          style: theme.textTheme.titleLarge),
                      SizedBox(height: 23.v),
                      Container(
                          margin: EdgeInsets.only(left: 61.h, right: 64.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.h, vertical: 10.v),
                          decoration: AppDecoration.fillErrorContainer1
                              .copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder27),
                          child: CustomRatingBar(
                              initialRating: 5,
                              itemSize: 34,
                              color: appTheme.yellow700)),
                      SizedBox(height: 30.v),
                      CustomElevatedButton(
                          text: "Aceptar",
                          margin: EdgeInsets.only(left: 44.h, right: 45.h),
                          buttonStyle: CustomButtonStyles.fillPrimaryTL16),
                      SizedBox(height: 14.v),
                      CustomElevatedButton(
                          text: "Cancelar",
                          margin: EdgeInsets.only(left: 44.h, right: 45.h),
                          buttonStyle: CustomButtonStyles.fillTealTL16),
                      SizedBox(height: 2.v)
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 23.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown2,
            margin: EdgeInsets.only(left: 18.h, top: 5.v, bottom: 41.v),
            onTap: () {
              onTapRegresar(context);
            }),
        centerTitle: true,
        title: AppbarSubtitleTwo(text: "Museo Tamayo \n"));
  }

  /// Section Widget
  Widget _buildReview(BuildContext context) {
    return Container(
        width: 317.h,
        margin: EdgeInsets.only(right: 7.h),
        padding: EdgeInsets.all(12.h),
        decoration: AppDecoration.fillGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder33),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomImageView(
                    imagePath: ImageConstant.imgUserphoto135x34,
                    height: 35.v,
                    width: 34.h,
                    radius: BorderRadius.circular(17.h)),
                Padding(
                    padding: EdgeInsets.only(left: 6.h, top: 5.v, bottom: 7.v),
                    child:
                        Text("UserNameXx", style: theme.textTheme.titleMedium))
              ]),
              SizedBox(height: 8.v),
              Container(
                  width: 277.h,
                  margin: EdgeInsets.only(right: 15.h),
                  child: Text(
                      "Comparte tu experiencia y deja tu opinión sobre este lugar. Tu feedback es invaluable para nosotros.",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumErrorContainer)),
              SizedBox(height: 19.v)
            ]));
  }

  /// Navigates to the frmreseATabContainerScreen when the action is triggered.
  onTapRegresar(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.frmreseATabContainerScreen);
  }
}
