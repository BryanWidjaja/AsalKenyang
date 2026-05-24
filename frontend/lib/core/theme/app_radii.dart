import 'package:flutter/widgets.dart';

abstract final class AppRadii {
  AppRadii._();

  static const double xs = 6;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;

  static const Radius rXs = Radius.circular(xs);
  static const Radius rSm = Radius.circular(sm);
  static const Radius rMd = Radius.circular(md);
  static const Radius rLg = Radius.circular(lg);
  static const Radius rXl = Radius.circular(xl);
  static const Radius rFull = Radius.circular(full);

  static const BorderRadius brXs = BorderRadius.all(rXs);
  static const BorderRadius brSm = BorderRadius.all(rSm);
  static const BorderRadius brMd = BorderRadius.all(rMd);
  static const BorderRadius brLg = BorderRadius.all(rLg);
  static const BorderRadius brXl = BorderRadius.all(rXl);
  static const BorderRadius brFull = BorderRadius.all(rFull);

  static const BorderRadius sheetTop = BorderRadius.only(
    topLeft: rXl,
    topRight: rXl,
  );

  static const BorderRadius navTop = BorderRadius.only(
    topLeft: rLg,
    topRight: rLg,
  );

  static const BorderRadius cardPhotoTop = BorderRadius.only(
    topLeft: rLg,
    topRight: rLg,
  );
}
