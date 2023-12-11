import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

// ignore: must_be_immutable
class ComponentlugaresItemWidget extends StatelessWidget {
  const ComponentlugaresItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 21.v,
          width: 74.h,
          decoration: AppDecoration.outlineBlack,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 21.v,
                  width: 73.h,
                  decoration: BoxDecoration(
                    color: appTheme.lime100,
                    borderRadius: BorderRadius.circular(
                      10.h,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.h, 3.v, 9.h, 2.v),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgVectorPrimary,
                        height: 13.v,
                        width: 15.h,
                        margin: EdgeInsets.only(bottom: 2.v),
                      ),
                      Text(
                        "Museos",
                        style: CustomTextStyles.bodySmallPrimaryRegular,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
