import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 64, this.squircle = false});

  const BrandMark.splash({super.key}) : size = 100, squircle = true;

  final double size;
  final bool squircle;

  @override
  Widget build(BuildContext context) {
    final radius = squircle ? size * 0.32 : size / 2;
    return Semantics(
      label: 'AsalKenyang logo',
      image: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.terracottaContainer,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: const CustomPaint(
          painter: _AsalKenyangLogoPainter(),
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}

class _AsalKenyangLogoPainter extends CustomPainter {
  const _AsalKenyangLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    canvas
      ..save()
      ..translate((size.width - side) / 2, (size.height - side) / 2)
      ..scale(side / 100);

    final primary = Paint()..color = AppColors.primary;
    final primaryAccent = Paint()..color = AppColors.primaryContainer;
    final rice = Paint()..color = AppColors.riceWhite;
    final pandan = Paint()..color = AppColors.secondary;
    final pandanLight = AppColors.pandanContainer;
    final kunyit = Paint()..color = AppColors.kunyitContainer;
    final tertiary = Paint()..color = AppColors.tertiaryContainer;
    final strokePrimary = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final checkLeaf = Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 7;
    final leafPath = Path()
      ..moveTo(32, 45)
      ..lineTo(43, 56)
      ..lineTo(68, 29);
    canvas.drawPath(leafPath, checkLeaf);

    final leaf = Path()
      ..moveTo(50, 21)
      ..cubicTo(64, 20, 74, 29, 75, 45)
      ..cubicTo(61, 45, 51, 36, 50, 21)
      ..close();
    canvas.drawPath(leaf, pandan);
    canvas.drawPath(
      Path()
        ..moveTo(56, 28)
        ..cubicTo(61, 33, 65, 37, 70, 42),
      Paint()
        ..color = pandanLight
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 2.5,
    );

    canvas
      ..drawCircle(const Offset(70, 35), 10, kunyit)
      ..drawCircle(const Offset(70, 35), 4.5, tertiary);

    final riceMound = Path()
      ..moveTo(27, 51)
      ..cubicTo(33, 40, 42, 35, 52, 35)
      ..cubicTo(65, 35, 74, 43, 77, 51)
      ..close();
    canvas.drawPath(riceMound, rice);

    strokePrimary.strokeWidth = 3;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(20, 47, 60, 17),
        const Radius.circular(10),
      ),
      rice,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(20, 47, 60, 17),
        const Radius.circular(10),
      ),
      strokePrimary,
    );

    final grainPaint = Paint()
      ..color = AppColors.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;
    canvas
      ..drawLine(const Offset(39, 47), const Offset(45, 44), grainPaint)
      ..drawLine(const Offset(51, 44), const Offset(57, 47), grainPaint)
      ..drawLine(const Offset(61, 50), const Offset(67, 48), grainPaint);

    final bowl = Path()
      ..moveTo(23, 56)
      ..cubicTo(32, 61, 68, 61, 77, 56)
      ..cubicTo(75, 73, 64, 82, 50, 82)
      ..cubicTo(36, 82, 25, 73, 23, 56)
      ..close();
    canvas.drawPath(bowl, primary);

    canvas.drawPath(
      Path()
        ..moveTo(34, 66)
        ..cubicTo(42, 71, 58, 72, 66, 66),
      Paint()
        ..color = AppColors.primaryFixedDim
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 4,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(37, 79, 26, 6),
        const Radius.circular(3),
      ),
      primaryAccent,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _AsalKenyangLogoPainter oldDelegate) => false;
}
