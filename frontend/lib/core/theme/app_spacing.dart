import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  AppSpacing._();

  static const double s0 = 0;
  static const double s0_5 = 2;
  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s7 = 28;
  static const double s8 = 32;
  static const double s10 = 40;
  static const double s12 = 48;
  static const double s16 = 64;

  static const double xs = s1;
  static const double sm = s2;
  static const double md = s3;
  static const double edge = s4;
  static const double lg = s6;
  static const double xl = s8;
  static const double touchTarget = s12;

  static const double screenMaxWidth = 600;

  static const EdgeInsets screenEdge = EdgeInsets.symmetric(horizontal: edge);
  static const EdgeInsets cardInner = EdgeInsets.all(md);
  static const EdgeInsets cardInnerLg = EdgeInsets.all(edge);
  static const EdgeInsets buttonInner = EdgeInsets.symmetric(
    horizontal: edge,
    vertical: sm,
  );

  static const SizedBox gapXs = SizedBox(width: xs, height: xs);
  static const SizedBox gapSm = SizedBox(width: sm, height: sm);
  static const SizedBox gapMd = SizedBox(width: md, height: md);
  static const SizedBox gapEdge = SizedBox(width: edge, height: edge);
  static const SizedBox gapLg = SizedBox(width: lg, height: lg);
  static const SizedBox gapXl = SizedBox(width: xl, height: xl);
}
