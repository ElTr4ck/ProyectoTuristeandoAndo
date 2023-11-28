import 'package:flutter/material.dart';
import 'package:ramirez_ayala_s_application16/core/app_export.dart';
import 'package:ramirez_ayala_s_application16/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class SeventyItemWidget extends StatelessWidget {
  const SeventyItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 241.v,
      width: 189.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle1240x188,
            height: 240.v,
            width: 188.h,
            radius: BorderRadius.circular(
              24.h,
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 12.h,
                right: 16.h,
                bottom: 13.v,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 103.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.h,
                      vertical: 2.v,
                    ),
                    decoration: AppDecoration.fillErrorContainer.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder12,
                    ),
                    child: Text(
                      "Museo Tamayo",
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  SizedBox(height: 1.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 53.h,
                        margin: EdgeInsets.only(top: 5.v),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.h,
                          vertical: 3.v,
                        ),
                        decoration: AppDecoration.fillErrorContainer.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgStar63,
                              height: 14.adaptSize,
                              width: 14.adaptSize,
                              radius: BorderRadius.circular(
                                1.h,
                              ),
                            ),
                            Text(
                              "4.6",
                              style: CustomTextStyles.bodySmall10,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 3.v),
                        child: CustomIconButton(
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          padding: EdgeInsets.all(6.h),
                          child: CustomImageView(
                            imagePath:
                                ImageConstant.imgIconlyBoldHeartRed40024x24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
