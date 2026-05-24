import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/app_typography.dart';

void main() {
  runApp(const AsalKenyangApp());
}

class AsalKenyangApp extends StatelessWidget {
  const AsalKenyangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AsalKenyang',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const _PlaceholderHome(),
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('AsalKenyang', style: AppTypography.budgetHero.copyWith(color: scheme.primary)),
            const SizedBox(height: 8),
            Text(
              'Masak dari sisa bahan, sesuai isi dompet.',
              style: AppTypography.body.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
