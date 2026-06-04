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
    final surface = Paint()..color = AppColors.surfaceContainerLowest;
    final warmSurface = Paint()..color = AppColors.surfaceContainer;
    final display = Paint()..color = AppColors.pandanContainer;
    final strokePrimary = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    strokePrimary.strokeWidth = 3;

    final spoonHandle = Paint()
      ..color = AppColors.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    canvas.drawLine(const Offset(62, 30), const Offset(54, 54), spoonHandle);
    final spoonBowl = Path()
      ..moveTo(65, 11)
      ..cubicTo(74, 12, 79, 21, 75, 31)
      ..cubicTo(71, 41, 61, 42, 56, 33)
      ..cubicTo(51, 24, 55, 10, 65, 11)
      ..close();
    canvas.drawPath(spoonBowl, rice);
    canvas.drawPath(spoonBowl, strokePrimary);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(16, 53, 12, 20),
        const Radius.circular(7),
      ),
      primary,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(72, 53, 12, 20),
        const Radius.circular(7),
      ),
      primary,
    );

    final cookerBody = RRect.fromRectAndRadius(
      const Rect.fromLTWH(18, 43, 64, 40),
      const Radius.circular(15),
    );
    canvas.drawRRect(cookerBody, surface);
    canvas.drawRRect(cookerBody, strokePrimary);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(24, 38, 52, 18),
        const Radius.circular(10),
      ),
      warmSurface,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(24, 38, 52, 18),
        const Radius.circular(10),
      ),
      strokePrimary,
    );

    final riceMound = Path()
      ..moveTo(24, 48)
      ..cubicTo(31, 36, 42, 31, 52, 34)
      ..cubicTo(65, 31, 76, 39, 79, 49)
      ..cubicTo(66, 55, 37, 55, 24, 48)
      ..close();
    canvas.drawPath(riceMound, rice);
    canvas.drawPath(riceMound, strokePrimary);

    final grainPaint = Paint()
      ..color = AppColors.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;
    canvas
      ..drawLine(const Offset(36, 46), const Offset(42, 43), grainPaint)
      ..drawLine(const Offset(49, 42), const Offset(56, 45), grainPaint)
      ..drawLine(const Offset(61, 48), const Offset(69, 46), grainPaint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(30, 61, 40, 13),
        const Radius.circular(7),
      ),
      warmSurface,
    );
    strokePrimary.strokeWidth = 2.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(30, 61, 40, 13),
        const Radius.circular(7),
      ),
      strokePrimary,
    );
    canvas
      ..drawCircle(const Offset(40, 67.5), 3.5, display)
      ..drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(48, 64.5, 13, 6),
          const Radius.circular(3),
        ),
        primaryAccent,
      );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(34, 80, 32, 6),
        const Radius.circular(3),
      ),
      primaryAccent,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _AsalKenyangLogoPainter oldDelegate) => false;
}
