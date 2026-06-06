import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class MatchRing extends StatelessWidget {
  const MatchRing({
    super.key,
    required this.percent,
    this.size = 40,
    this.stroke = 4,
  });

  final double percent;
  final double size;
  final double stroke;

  Color _tierColor(AppStateColors state) {
    if (percent >= 0.8) {
      return state.matchHigh;
    }

    if (percent >= 0.5) {
      return state.matchMid;
    }

    return state.matchLow;
  }

  @override
  Widget build(BuildContext context) {
    final color = _tierColor(AppStateColors.of(context));
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          percent: percent.clamp(0.0, 1.0),
          color: color,
          stroke: stroke,
          track: AppColors.surfaceContainerHighest,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(stroke + 2),
            child: FittedBox(
              child: Text(
                '${(percent * 100).round()}%',
                style: AppTypography.label.copyWith(
                  color: color,
                  fontFeatures: AppTypography.tnum,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.percent,
    required this.color,
    required this.stroke,
    required this.track,
  });

  final double percent;
  final Color color;
  final double stroke;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - stroke) / 2;

    final trackPaint = Paint()
      ..color = track
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawCircle(center, radius, trackPaint);

    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percent,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.percent != percent ||
      old.color != color ||
      old.stroke != stroke ||
      old.track != track;
}
