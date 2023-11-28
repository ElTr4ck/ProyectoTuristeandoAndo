import 'package:flutter/material.dart';
import 'package:ramirez_ayala_s_application16/core/app_export.dart';

// ignore: must_be_immutable
class RecommendedItemWidget extends StatelessWidget {
  RecommendedItemWidget({
    Key? key,
    this.onTapImgAcuarioInbursa,
  }) : super(
          key: key,
        );

  VoidCallback? onTapImgAcuarioInbursa;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.gradientOnPrimaryToGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      width: 174.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle196x166,
            height: 96.v,
            width: 166.h,
            radius: BorderRadius.circular(
              24.h,
            ),
            onTap: () {
              onTapImgAcuarioInbursa!.call();
            },
          ),
          Text(
            "Acuario Inbursa",
            style: theme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
