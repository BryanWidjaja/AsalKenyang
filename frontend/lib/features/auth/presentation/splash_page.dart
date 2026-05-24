import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/brand_mark.dart';
import '../../../shared/widgets/indeterminate_bar.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String route = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.edge,
                vertical: AppSpacing.xl,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  const BrandMark.splash(),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'AsalKenyang',
                    style: AppTypography.budgetHero.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  const IndeterminateBar(),
                  const SizedBox(height: AppSpacing.lg),
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                      'Siapin bahan, atur dompet...',
                      style: AppTypography.label.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
