import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';

class IndeterminateBar extends StatefulWidget {
  const IndeterminateBar({
    super.key,
    this.width = 192,
    this.height = 6,
    this.duration = const Duration(milliseconds: 1500),
  });

  final double width;
  final double height;
  final Duration duration;

  @override
  State<IndeterminateBar> createState() => _IndeterminateBarState();
}

class _IndeterminateBarState extends State<IndeterminateBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: AppRadii.brFull,
        child: Stack(
          children: [
            Container(color: AppColors.surfaceVariant),
            AnimatedBuilder(
              animation: _ctrl,
              builder: (context, _) {
                final slabW = widget.width * 0.5;
                final travel = widget.width + slabW * 2;
                final x = -slabW + travel * _ctrl.value;
                return Positioned(
                  left: x,
                  top: 0,
                  bottom: 0,
                  width: slabW,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppRadii.brFull,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
