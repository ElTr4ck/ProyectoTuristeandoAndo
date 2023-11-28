import 'package:flutter/material.dart';
import 'package:ramirez_ayala_s_application16/core/app_export.dart';
import 'package:ramirez_ayala_s_application16/widgets/custom_drop_down.dart';

// ignore: must_be_immutable
class AppbarTrailingDropdown extends StatelessWidget {
  AppbarTrailingDropdown({
    Key? key,
    required this.hintText,
    required this.items,
    required this.onTap,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  List<String> items;

  Function(String) onTap;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomDropDown(
        width: 93.h,
        icon: Container(
          margin: EdgeInsets.only(left: 6.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowdown,
            height: 16.adaptSize,
            width: 16.adaptSize,
          ),
        ),
        hintText: "UserNameXx",
        items: items,
        onChanged: (value) {
          onTap(value!);
        },
      ),
    );
  }
}
