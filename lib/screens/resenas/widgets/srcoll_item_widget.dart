import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

// ignore: must_be_immutable
class SrcollItemWidget extends StatelessWidget {
  const SrcollItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container( //DECORATION CONTAINER
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder33,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(right: 17.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgAvatar32x32, //PHOTOS OF THE BD ACORDING TO THE REVIEW´S USER
                    height: 32.adaptSize,
                    width: 32.adaptSize,
                    radius: BorderRadius.circular(
                      16.h,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //AutofillHints.name,  //NAME USER
                          "NameUserXx",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(
                          width: 132.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgClose,
                                height: 12.v,
                                width: 60.h,
                                margin: EdgeInsets.symmetric(vertical: 1.v),
                              ),
                              Text(
                                "10/25/2023",//DATE
                                style: theme.textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.imgTrashBlack900,
                    height: 16.v,
                    width: 16.h,
                    margin: EdgeInsets.symmetric(vertical: 15.v),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.v),
          Text(
            "Museo Jumex", //NAME PLACE
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 1.v),
          SizedBox(
            width: 293.h,
            child: Text(
              "Éste lugar es una porquería. El personal es tan inútil que me pregunto cómo consiguen trabajar aquí. No pierdan su tiempo ni su dinero",
              maxLines: null,
              //check this section because don´t show the complete review
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 14.v),
          Padding(
            padding: EdgeInsets.only(right: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgRectangle993,//img BD
                    height: 100.v,
                    width: 100.h,
                    radius: BorderRadius.circular(
                      24.h,
                    ),
                    margin: EdgeInsets.only(right: 5.h),
                  ),
                ),
                Expanded(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgRectangle996, //img BD
                    height: 100.v,
                    width: 100.h,
                    radius: BorderRadius.circular(
                      24.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 5.h),
                  ),
                ),
                Expanded(
                  child: CustomImageView(
                    imagePath: ImageConstant.imgRectangle995, //img BD
                    height: 100.v,
                    width: 100.h,
                    radius: BorderRadius.circular(
                      24.h,
                    ),
                    margin: EdgeInsets.only(left: 5.h),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
