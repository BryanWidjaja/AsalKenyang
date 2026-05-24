import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF9B2F00);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFC2410C);
  static const Color onPrimaryContainer = Color(0xFFFFECE7);
  static const Color primaryFixed = Color(0xFFFFDBD0);
  static const Color primaryFixedDim = Color(0xFFFFB59D);
  static const Color onPrimaryFixed = Color(0xFF390C00);
  static const Color onPrimaryFixedVariant = Color(0xFF832600);
  static const Color inversePrimary = Color(0xFFFFB59D);

  static const Color secondary = Color(0xFF2C694D);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFB0F1CC);
  static const Color onSecondaryContainer = Color(0xFF337052);
  static const Color secondaryFixed = Color(0xFFB0F1CC);
  static const Color secondaryFixedDim = Color(0xFF95D4B1);
  static const Color onSecondaryFixed = Color(0xFF002113);
  static const Color onSecondaryFixedVariant = Color(0xFF0E5136);

  static const Color tertiary = Color(0xFF6F4F00);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF8E6604);
  static const Color onTertiaryContainer = Color(0xFFFFEED5);
  static const Color tertiaryFixed = Color(0xFFFFDEA6);
  static const Color tertiaryFixedDim = Color(0xFFF1BF5D);
  static const Color onTertiaryFixed = Color(0xFF271900);
  static const Color onTertiaryFixedVariant = Color(0xFF5D4200);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color background = Color(0xFFFCF8F4);
  static const Color onBackground = Color(0xFF211A15);
  static const Color surface = Color(0xFFFCF8F4);
  static const Color onSurface = Color(0xFF211A15);
  static const Color surfaceVariant = Color(0xFFF2E4D8);
  static const Color onSurfaceVariant = Color(0xFF59413A);
  static const Color surfaceDim = Color(0xFFE6D7CF);
  static const Color surfaceBright = Color(0xFFFFF8F5);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFFFF1E9);
  static const Color surfaceContainer = Color(0xFFFAEBE2);
  static const Color surfaceContainerHigh = Color(0xFFF4E5DD);
  static const Color surfaceContainerHighest = Color(0xFFEEE0D7);
  static const Color surfaceTint = Color(0xFFAC3400);
  static const Color inverseSurface = Color(0xFF372F29);
  static const Color inverseOnSurface = Color(0xFFFDEEE5);

  static const Color outline = Color(0xFF8D7168);
  static const Color outlineVariant = Color(0xFFD7C5B6);

  static const Color riceWhite = Color(0xFFFCF8F4);
  static const Color warmCharcoal = Color(0xFF211A15);
  static const Color terracottaContainer = Color(0xFFFFDBCA);
  static const Color pandanContainer = Color(0xFFB6EFCF);
  static const Color kunyitContainer = Color(0xFFFFDF9C);
  static const Color pedasTag = Color(0xFFFFDAD5);
}

@immutable
class AppStateColors extends ThemeExtension<AppStateColors> {
  const AppStateColors({
    required this.affordable,
    required this.affordableContainer,
    required this.unaffordable,
    required this.unaffordableContainer,
    required this.missing,
    required this.missingContainer,
    required this.info,
    required this.infoContainer,
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.gauge1,
    required this.gauge2,
    required this.gauge3,
    required this.gauge4,
    required this.matchHigh,
    required this.matchMid,
    required this.matchLow,
  });

  final Color affordable;
  final Color affordableContainer;
  final Color unaffordable;
  final Color unaffordableContainer;
  final Color missing;
  final Color missingContainer;
  final Color info;
  final Color infoContainer;
  final Color success;
  final Color successContainer;
  final Color warning;
  final Color warningContainer;
  final Color gauge1;
  final Color gauge2;
  final Color gauge3;
  final Color gauge4;
  final Color matchHigh;
  final Color matchMid;
  final Color matchLow;

  static const light = AppStateColors(
    affordable: AppColors.secondary,
    affordableContainer: AppColors.pandanContainer,
    unaffordable: AppColors.error,
    unaffordableContainer: AppColors.errorContainer,
    missing: Color(0xFFC97A0A),
    missingContainer: Color(0xFFFFE0AE),
    info: Color(0xFF5B7585),
    infoContainer: Color(0xFFD7E4EC),
    success: Color(0xFF1E7F4B),
    successContainer: AppColors.pandanContainer,
    warning: Color(0xFFC97A0A),
    warningContainer: Color(0xFFFFE0AE),
    gauge1: AppColors.secondary,
    gauge2: AppColors.kunyitContainer,
    gauge3: AppColors.primaryContainer,
    gauge4: AppColors.error,
    matchHigh: AppColors.secondary,
    matchMid: AppColors.tertiaryContainer,
    matchLow: AppColors.primaryContainer,
  );

  static AppStateColors of(BuildContext context) =>
      Theme.of(context).extension<AppStateColors>() ?? light;

  @override
  AppStateColors copyWith({
    Color? affordable,
    Color? affordableContainer,
    Color? unaffordable,
    Color? unaffordableContainer,
    Color? missing,
    Color? missingContainer,
    Color? info,
    Color? infoContainer,
    Color? success,
    Color? successContainer,
    Color? warning,
    Color? warningContainer,
    Color? gauge1,
    Color? gauge2,
    Color? gauge3,
    Color? gauge4,
    Color? matchHigh,
    Color? matchMid,
    Color? matchLow,
  }) {
    return AppStateColors(
      affordable: affordable ?? this.affordable,
      affordableContainer: affordableContainer ?? this.affordableContainer,
      unaffordable: unaffordable ?? this.unaffordable,
      unaffordableContainer:
          unaffordableContainer ?? this.unaffordableContainer,
      missing: missing ?? this.missing,
      missingContainer: missingContainer ?? this.missingContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      gauge1: gauge1 ?? this.gauge1,
      gauge2: gauge2 ?? this.gauge2,
      gauge3: gauge3 ?? this.gauge3,
      gauge4: gauge4 ?? this.gauge4,
      matchHigh: matchHigh ?? this.matchHigh,
      matchMid: matchMid ?? this.matchMid,
      matchLow: matchLow ?? this.matchLow,
    );
  }

  @override
  AppStateColors lerp(ThemeExtension<AppStateColors>? other, double t) {
    if (other is! AppStateColors) return this;
    return AppStateColors(
      affordable: Color.lerp(affordable, other.affordable, t)!,
      affordableContainer:
          Color.lerp(affordableContainer, other.affordableContainer, t)!,
      unaffordable: Color.lerp(unaffordable, other.unaffordable, t)!,
      unaffordableContainer:
          Color.lerp(unaffordableContainer, other.unaffordableContainer, t)!,
      missing: Color.lerp(missing, other.missing, t)!,
      missingContainer:
          Color.lerp(missingContainer, other.missingContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      success: Color.lerp(success, other.success, t)!,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t)!,
      gauge1: Color.lerp(gauge1, other.gauge1, t)!,
      gauge2: Color.lerp(gauge2, other.gauge2, t)!,
      gauge3: Color.lerp(gauge3, other.gauge3, t)!,
      gauge4: Color.lerp(gauge4, other.gauge4, t)!,
      matchHigh: Color.lerp(matchHigh, other.matchHigh, t)!,
      matchMid: Color.lerp(matchMid, other.matchMid, t)!,
      matchLow: Color.lerp(matchLow, other.matchLow, t)!,
    );
  }
}

ColorScheme buildAppColorScheme() => const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      primaryFixed: AppColors.primaryFixed,
      primaryFixedDim: AppColors.primaryFixedDim,
      onPrimaryFixed: AppColors.onPrimaryFixed,
      onPrimaryFixedVariant: AppColors.onPrimaryFixedVariant,
      inversePrimary: AppColors.inversePrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      secondaryFixed: AppColors.secondaryFixed,
      secondaryFixedDim: AppColors.secondaryFixedDim,
      onSecondaryFixed: AppColors.onSecondaryFixed,
      onSecondaryFixedVariant: AppColors.onSecondaryFixedVariant,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      tertiaryFixed: AppColors.tertiaryFixed,
      tertiaryFixedDim: AppColors.tertiaryFixedDim,
      onTertiaryFixed: AppColors.onTertiaryFixed,
      onTertiaryFixedVariant: AppColors.onTertiaryFixedVariant,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceDim: AppColors.surfaceDim,
      surfaceBright: AppColors.surfaceBright,
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      surfaceTint: AppColors.surfaceTint,
    );
