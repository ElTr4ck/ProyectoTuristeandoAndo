import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeMontserratBluegray100cc =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.blueGray100,
      );
  // Headline style
  static get headlineSmallPoppins => theme.textTheme.headlineSmall!.poppins;
  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static get titleLargeBlack90022 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 25.fSize,
        background: white,
      );
  static get titleLargeOnPrimaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumNunitoOnPrimary =>
      theme.textTheme.titleMedium!.nunito.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleMediumNunitoOnPrimary18 =>
      theme.textTheme.titleMedium!.nunito.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 18.fSize,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleMediumOnPrimary17 => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 17.fSize,
      );
  static get titleMediumOnPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumTeal100 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.teal100,
      );
  static get titleSmallMontserratGray600 =>
      theme.textTheme.titleSmall!.montserrat.copyWith(
        color: appTheme.gray600,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallMontserratOnPrimaryContainer =>
      theme.textTheme.titleSmall!.montserrat.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w500,
      );

  static get white => null;
  // Body text style
  static get bodyMediumCyan900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.cyan900,
      );
  static get bodyMediumErrorContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get bodyMediumMontserrat =>
      theme.textTheme.bodyMedium!.montserrat.copyWith(
        fontSize: 14.fSize,
      );
  static get bodyMediumPollerOnePrimary =>
      theme.textTheme.bodyMedium!.pollerOne.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 14.fSize,
      );
  static get bodyMediumRed900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.red900,
      );
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallDMSansOnError =>
      theme.textTheme.bodySmall!.dMSans.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallGray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray700,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallMontserratBlack900 =>
      theme.textTheme.bodySmall!.montserrat.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 8.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallPrimaryRegular => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallRegular => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  // Headline text style
  static get headlineLarge30 => theme.textTheme.headlineLarge!.copyWith(
        fontSize: 30.fSize,
      );
  static get headlineSmallPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  static get headlineSmallSemiBold => theme.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w600,
      );
  // Label text style
  static get labelLargeMontserratTeal400 =>
      theme.textTheme.labelLarge!.montserrat.copyWith(
        color: appTheme.teal400,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeNunitoGray5002 =>
      theme.textTheme.labelLarge!.nunito.copyWith(
        color: appTheme.gray5002,
      );
  static get labelMediumMedium => theme.textTheme.labelMedium!.copyWith(
        fontWeight: FontWeight.w500,
      );
  // Title text style
  static get titleLargeInterBlack900 =>
      theme.textTheme.titleLarge!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeNunito => theme.textTheme.titleLarge!.nunito.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleMediumMedium => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleMediumMontserrat =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumMontserratOnPrimaryContainer =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppinsGray5002 =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: appTheme.gray5002,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallSemiBold => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get dMSans {
    return copyWith(
      fontFamily: 'DM Sans',
    );
  }

  TextStyle get pollerOne {
    return copyWith(
      fontFamily: 'Poller One',
    );
  }

  TextStyle get nunito {
    return copyWith(
      fontFamily: 'Nunito',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }
}
