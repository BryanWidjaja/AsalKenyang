import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/brand_mark.dart';
import '../../../shared/widgets/indeterminate_bar.dart';
import '../../../core/sync/sync_engine.dart';
import '../../shell/presentation/home_shell.dart';
import '../application/auth_controller.dart';
import 'login_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  static const String route = '/';

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    final repo = ref.read(authRepositoryProvider);
    final results = await Future.wait<dynamic>([
      repo.hasSession(),
      Future<void>.delayed(const Duration(milliseconds: 800)),
    ]);
    if (!mounted) return;
    final hasSession = results[0] as bool;
    if (hasSession) {
      // Fire and forget sync
      ref.read(syncEngineProvider).syncOutbox();
    }
    Navigator.of(context).pushReplacementNamed(
      hasSession ? HomeShell.route : LoginPage.route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.screenMaxWidth,
            ),
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
