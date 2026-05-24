import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  AppTypography._();

  static const String _family = 'Plus Jakarta Sans';
  static const List<String> _fallback = ['Inter'];

  static const List<FontFeature> tnum = [FontFeature.tabularFigures()];

  static const TextStyle budgetHero = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 40 / 36,
    letterSpacing: -0.5,
    fontFeatures: tnum,
    color: AppColors.onSurface,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 34 / 28,
    letterSpacing: -0.25,
    color: AppColors.onSurface,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 30 / 24,
    letterSpacing: -0.25,
    color: AppColors.onSurface,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 26 / 20,
    letterSpacing: 0,
    color: AppColors.onSurface,
  );

  static const TextStyle titleMd = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    letterSpacing: 0,
    color: AppColors.onSurface,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 22 / 16,
    letterSpacing: 0.1,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyLg = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0.15,
    color: AppColors.onSurface,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.2,
    color: AppColors.onSurface,
  );

  static const TextStyle label = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 18 / 14,
    letterSpacing: 0.3,
    color: AppColors.onSurface,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.3,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 14 / 11,
    letterSpacing: 0.5,
    color: AppColors.onSurfaceVariant,
  );

  static const Map<String, TextStyle> style = {
    'budget-hero': budgetHero,
    'h1': h1,
    'h2': h2,
    'h3': h3,
    'title-md': titleMd,
    'subtitle': subtitle,
    'body-lg': bodyLg,
    'body': body,
    'label': label,
    'caption': caption,
    'overline': overline,
  };

  static TextTheme get textTheme => const TextTheme(
    displayLarge: budgetHero,
    headlineLarge: h1,
    headlineMedium: h2,
    headlineSmall: h3,
    titleLarge: titleMd,
    titleMedium: subtitle,
    titleSmall: label,
    bodyLarge: bodyLg,
    bodyMedium: body,
    bodySmall: caption,
    labelLarge: label,
    labelMedium: caption,
    labelSmall: overline,
  );
}
