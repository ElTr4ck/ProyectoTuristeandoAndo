import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';
import 'package:turisteando_ando/widgets/custom_rating_bar.dart';

// ignore: must_be_immutable
class CercaItemWidget extends StatelessWidget {
  const CercaItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 95.h,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            SizedBox(
              height: 116.v,
              width: 95.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle1116x95,
                    height: 116.v,
                    width: 95.h,
                    radius: BorderRadius.circular(
                      24.h,
                    ),
                    alignment: Alignment.center,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 17.v,
                      width: 68.h,
                      margin: EdgeInsets.only(bottom: 4.v),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 17.v,
                              width: 68.h,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(
                                  8.h,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Teotihuacán",
                              style: CustomTextStyles.bodySmallBlack900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.v),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18.h),
              padding: EdgeInsets.symmetric(
                horizontal: 2.h,
                vertical: 4.v,
              ),
              decoration: AppDecoration.fillErrorContainer1.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder9,
              ),
              child: CustomRatingBar(
                ignoreGestures: true,
                initialRating: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
