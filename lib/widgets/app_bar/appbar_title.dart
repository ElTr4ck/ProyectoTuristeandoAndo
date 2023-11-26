import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Container(
          width: 306.h,
          decoration: AppDecoration.outlineBlack,
          child: Text(
            text,
            maxLines: null,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.headlineSmallPoppins.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              height: 1.41,
            ),
          ),
        ),
      ),
    );
  }
}
