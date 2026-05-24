import 'package:flutter/widgets.dart';

import 'app_colors.dart';

abstract final class AppElevation {
  AppElevation._();

  static const Color _ink = AppColors.warmCharcoal;

  static const List<BoxShadow> level0 = <BoxShadow>[];

  static List<BoxShadow> level1 = [
    BoxShadow(
      color: _ink.withValues(alpha: 0.06),
      offset: const Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadow(
      color: _ink.withValues(alpha: 0.04),
      offset: const Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static List<BoxShadow> level2 = [
    BoxShadow(
      color: _ink.withValues(alpha: 0.08),
      offset: const Offset(0, 2),
      blurRadius: 6,
    ),
  ];

  static List<BoxShadow> level3 = [
    BoxShadow(
      color: _ink.withValues(alpha: 0.12),
      offset: const Offset(0, 4),
      blurRadius: 12,
    ),
  ];

  static List<BoxShadow> nav = [
    BoxShadow(
      color: _ink.withValues(alpha: 0.06),
      offset: const Offset(0, -1),
      blurRadius: 8,
    ),
  ];

  static List<BoxShadow> navHeavy = [
    BoxShadow(
      color: _ink.withValues(alpha: 0.08),
      offset: const Offset(0, -4),
      blurRadius: 12,
    ),
  ];

  static const Color scrim = Color(0x52211A15);
}
