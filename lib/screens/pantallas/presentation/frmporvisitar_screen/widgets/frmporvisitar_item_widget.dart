import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

// ignore: must_be_immutable
class FrmporvisitarItemWidget extends StatelessWidget {
  const FrmporvisitarItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 234.v,
      width: 163.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle7,
            height: 234.v,
            width: 163.h,
            radius: BorderRadius.circular(
              24.h,
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.h, 204.v, 8.h, 6.v),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 18.adaptSize,
                    width: 18.adaptSize,
                    margin: EdgeInsets.symmetric(vertical: 3.v),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgComponent20,
                          height: 18.adaptSize,
                          width: 18.adaptSize,
                          alignment: Alignment.center,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgFlechita,
                          height: 12.v,
                          width: 13.h,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 2.h),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 82.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.h,
                      vertical: 2.v,
                    ),
                    decoration: AppDecoration.fillErrorContainer.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder12,
                    ),
                    child: Text(
                      "Val´Quirico",
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgQuitarruta1,
                    height: 22.adaptSize,
                    width: 22.adaptSize,
                    margin: EdgeInsets.only(top: 1.v),
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
