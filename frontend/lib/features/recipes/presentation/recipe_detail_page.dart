import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_elevation.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/bahan_card.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/secondary_button.dart';
import '../../../shared/widgets/step_card.dart';
import '../../../shared/widgets/top_bar.dart';

class _Bahan {
  const _Bahan(this.name, this.amount, this.price, this.icon);
  final String name;
  final String amount;
  final String price;
  final IconData icon;
}

const _bahan = <_Bahan>[
  _Bahan('Labu Siam', '250g', 'Rp 4.000', Icons.shopping_bag_rounded),
  _Bahan('Kacang Panjang', '1 ikat', 'Rp 3.000', Icons.grass_rounded),
  _Bahan('Cabai Merah', '50g', 'Rp 5.000', Icons.local_fire_department_rounded),
  _Bahan('Bawang Merah', '5 siung', 'Rp 4.000', Icons.spa_rounded),
];

const _steps = <String>[
  'Potong dadu labu siam dan iris tipis kacang panjang seukuran korek api. '
      'Cuci bersih semua sayuran dengan air mengalir.',
  'Didihkan 500ml air di panci, masukkan bumbu racik lodeh dan santan instan. '
      'Aduk perlahan agar santan tidak pecah dan tercampur rata.',
  'Masukkan sayuran yang sudah dipotong. Masak dengan api sedang selama 5-7 '
      'menit hingga sayur empuk. Sajikan selagi hangat.',
];

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key});

  static const String route = '/recipe-detail';

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: TopBar.detail(
        isFavorited: _favorited,
        onFavoriteToggle: () => setState(() => _favorited = !_favorited),
      ),
      bottomNavigationBar: const _ActionBar(),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.screenMaxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _Hero(),
                    _TitleMeta(),
                    _BahanSection(),
                    _StepsSection(),
                    _Disclaimer(),
                    SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: AppColors.surfaceVariant,
            alignment: Alignment.center,
            child: const Icon(
              Icons.restaurant_rounded,
              size: 48,
              color: AppColors.outline,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.warmCharcoal.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.edge,
            bottom: AppSpacing.md,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: AppRadii.brFull,
                boxShadow: AppElevation.level2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.eco_rounded, size: 18, color: AppColors.secondary),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Aman (Rp 12.000/porsi)',
                    style: AppTypography.label.copyWith(
                      fontFeatures: AppTypography.tnum,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleMeta extends StatelessWidget {
  const _TitleMeta();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.edge,
        AppSpacing.lg,
        AppSpacing.edge,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sayur Lodeh Tanggal Tua', style: AppTypography.h1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: const [
              _MetaItem(icon: Icons.timer_outlined, label: '20 Menit'),
              SizedBox(width: AppSpacing.lg),
              _MetaItem(icon: Icons.restaurant_rounded, label: '2 Porsi'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: AppColors.onSurfaceVariant),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.body.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _BahanSection extends StatelessWidget {
  const _BahanSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.edge,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text('Bahan-bahan', style: AppTypography.titleMd),
              ),
              Text(
                'Total: Rp 24.000',
                style: AppTypography.label.copyWith(
                  color: AppColors.primary,
                  fontFeatures: AppTypography.tnum,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = AppSpacing.sm;
              final colWidth = (constraints.maxWidth - gap) / 2;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final b in _bahan)
                    SizedBox(
                      width: colWidth,
                      child: BahanCard(
                        name: b.name,
                        amount: b.amount,
                        price: b.price,
                        icon: b.icon,
                      ),
                    ),
                  SizedBox(
                    width: constraints.maxWidth,
                    child: const BahanCard.wide(
                      name: 'Santan Instan',
                      amount: '65ml',
                      price: 'Rp 3.500',
                      icon: Icons.water_drop_rounded,
                      gaugePercent: 1,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StepsSection extends StatelessWidget {
  const _StepsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.edge,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cara Memasak', style: AppTypography.titleMd),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < _steps.length; i++) ...[
            StepCard(index: i + 1, text: _steps[i]),
            if (i != _steps.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.edge,
        AppSpacing.md,
        AppSpacing.edge,
        0,
      ),
      child: Text(
        'Kalori & harga bersifat estimasi · bukan saran medis/keuangan',
        style: AppTypography.overline.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.riceWhite,
        borderRadius: AppRadii.navTop,
        boxShadow: AppElevation.navHeavy,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.screenMaxWidth,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.edge,
                    AppSpacing.md,
                    AppSpacing.edge,
                    AppSpacing.md,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryButton(
                        label: 'Masak',
                        icon: Icons.soup_kitchen_rounded,
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SecondaryButton(
                        label: 'Tambah ke rencana',
                        icon: Icons.calendar_month_rounded,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
