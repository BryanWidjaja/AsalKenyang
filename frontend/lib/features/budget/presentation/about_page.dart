import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/attribution_card.dart';
import '../../../shared/widgets/brand_mark.dart';
import '../../../shared/widgets/top_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String route = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.nested(title: 'Tentang'),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.edge,
                AppSpacing.md,
                AppSpacing.edge,
                AppSpacing.xl,
              ),
              children: const [
                _AppInfoCard(),
                SizedBox(height: AppSpacing.md),
                AttributionCard(
                  icon: Icons.dataset_rounded,
                  iconColor: AppColors.primary,
                  title: 'Sumber Data',
                  body:
                      'Informasi nilai gizi dan komposisi bahan makanan berbasis '
                      'pada Tabel Komposisi Pangan Indonesia (TKPI) yang '
                      'diterbitkan oleh Kementerian Kesehatan Republik Indonesia.',
                ),
                SizedBox(height: AppSpacing.sm),
                AttributionCard(
                  icon: Icons.interests_rounded,
                  iconColor: AppColors.secondary,
                  title: 'Ikonografi',
                  body:
                      'Menggunakan Material Symbols oleh Google, dilisensikan di '
                      'bawah Apache License Version 2.0.',
                ),
                SizedBox(height: AppSpacing.sm),
                AttributionCard(
                  icon: Icons.photo_camera_rounded,
                  iconColor: AppColors.tertiary,
                  title: 'Fotografi',
                  body:
                      'Gambar resep dan bahan makanan bersumber dari kontributor '
                      'komunitas dan platform lisensi terbuka (Unsplash, Pexels).',
                ),
                SizedBox(height: AppSpacing.lg),
                _Disclaimer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppInfoCard extends StatelessWidget {
  const _AppInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppRadii.brMd,
        border: Border.all(color: AppColors.surfaceVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BrandMark(size: 96),
          const SizedBox(height: AppSpacing.sm),
          Text('AsalKenyang', style: AppTypography.h2),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Versi 1.0.4 (Build 42)',
            style: AppTypography.label.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Teman setia di dapur kosan saat tanggal tua. Membantu '
            'merencanakan, memasak, dan berhemat dengan cerdas dan hangat.',
            style: AppTypography.body,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: AppRadii.brMd,
      ),
      child: Text(
        '*Estimasi harga bahan makanan dapat bervariasi tergantung lokasi '
        'warung, pasar tradisional, atau supermarket terdekat. Angka yang '
        'ditampilkan bersifat perkiraan untuk membantu perencanaan anggaran.',
        style: AppTypography.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
