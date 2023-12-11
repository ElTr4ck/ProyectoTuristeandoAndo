import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillErrorContainer => BoxDecoration(
        color: theme.colorScheme.errorContainer,
      );
  static BoxDecoration get fillErrorContainer1 => BoxDecoration(
        color: theme.colorScheme.errorContainer.withOpacity(0.34),
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray400.withOpacity(0.2),
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static BoxDecoration get fillOnPrimary1 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
  static BoxDecoration get fillPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      );
  static BoxDecoration get fillYellow => BoxDecoration(
        color: appTheme.yellow700,
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal100,
      );

  // Gradient decorations
  static BoxDecoration get gradientGrayToGray => BoxDecoration(
        border: Border.all(
          color: appTheme.gray400.withOpacity(0.45),
          width: 1.h,
        ),
        gradient: LinearGradient(
          begin: Alignment(0.01, 0.06),
          end: Alignment(0.96, 0.89),
          colors: [
            appTheme.gray10001,
            appTheme.gray5001,
          ],
        ),
      );
  static BoxDecoration get gradientGrayToGray5001 => BoxDecoration(
        border: Border.all(
          color: appTheme.gray100,
          width: 1.h,
        ),
        gradient: LinearGradient(
          begin: Alignment(0.01, 0.06),
          end: Alignment(0.96, 0.89),
          colors: [
            appTheme.gray10001,
            appTheme.gray5001,
          ],
        ),
      );
  static BoxDecoration get gradientOnPrimaryToGray => BoxDecoration(
        border: Border.all(
          color: appTheme.gray400.withOpacity(0.45),
          width: 1.h,
        ),
        gradient: LinearGradient(
          begin: Alignment(0.01, 0.06),
          end: Alignment(0.96, 0.89),
          colors: [
            theme.colorScheme.onPrimary.withOpacity(1),
            appTheme.gray10002,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration();
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder29 => BorderRadius.circular(
        29.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder40 => BorderRadius.circular(
        40.h,
      );
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius.circular(
        12.h,
      );
  
  static BorderRadius get circleBorder8 => BorderRadius.circular(
    8.h
  );

  // Custom borders
  static BorderRadius get customBorderTL20 => BorderRadius.vertical(
        top: Radius.circular(20.h),
      );

  // Rounded borders
  static BorderRadius get roundedBorder1 => BorderRadius.circular(
        1.h,
      );
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get roundedBorder24 => BorderRadius.circular(
        24.h,
      );
  static BorderRadius get roundedBorder27 => BorderRadius.circular(
        27.h,
      );
  static BorderRadius get roundedBorder33 => BorderRadius.circular(
        33.h,
      );
  static BorderRadius get roundedBorder9 => BorderRadius.circular(
        9.h,
      );
  static BorderRadius get roundedBorder57 => BorderRadius.circular(57.h);

  static BorderRadius get roundedBorder52 => BorderRadius.circular(52.h);
  
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
