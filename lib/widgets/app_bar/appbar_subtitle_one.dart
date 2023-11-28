import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

// ignore: must_be_immutable
class AppbarSubtitleOne extends StatelessWidget {
  AppbarSubtitleOne({
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
          decoration: AppDecoration.outlineBlack,
          child: Text(
            text,
            style: CustomTextStyles.headlineSmallSemiBold.copyWith(
              color: appTheme.black900,
            ),
          ),
        ),
      ),
    );
  }
}
