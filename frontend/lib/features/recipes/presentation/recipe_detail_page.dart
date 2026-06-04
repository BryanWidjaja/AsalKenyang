import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_elevation.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_image.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/secondary_button.dart';
import '../../../shared/widgets/step_card.dart';
import '../../../shared/widgets/top_bar.dart';

import '../../budget/application/budget_controller.dart';
import '../../plan/application/plan_controller.dart';
import '../application/favorites_controller.dart';
import '../application/recipe_providers.dart';
import '../data/recipe_models.dart';

class RecipeDetailPage extends ConsumerWidget {
  const RecipeDetailPage({super.key});

  static const String route = '/recipe-detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Recipe) return _RecipeDetailBody(recipe: args);

    final recipesAsync = ref.watch(allRecipesProvider);
    return recipesAsync.when(
      data: (recipes) {
        final recipe = _findRecipe(recipes, args);
        if (recipe == null) {
          return const Scaffold(body: Center(child: Text('Recipe not found')));
        }
        return _RecipeDetailBody(recipe: recipe);
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}

Recipe? _findRecipe(List<Recipe> recipes, Object? args) {
  if (args is String) {
    for (final recipe in recipes) {
      if (recipe.id == args) return recipe;
    }
    return null;
  }
  return recipes.isEmpty ? null : recipes.first;
}

class _RecipeDetailBody extends ConsumerWidget {
  const _RecipeDetailBody({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final perServing = recipe.porsi <= 0
        ? recipe.estPrice
        : (recipe.estPrice / recipe.porsi).round();
    final caloriesPerServing = recipe.porsi <= 0
        ? recipe.estCalories
        : (recipe.estCalories / recipe.porsi).round();

    final favorites = ref.watch(favoritesControllerProvider).value ?? [];
    final isFavorited = favorites.any(
      (favorite) => favorite.recipeId == recipe.id,
    );

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: TopBar.detail(
        isFavorited: isFavorited,
        onFavoriteToggle: () async {
          await ref
              .read(favoritesControllerProvider.notifier)
              .toggleFavorite(recipe.id);
        },
      ),
      bottomNavigationBar: _ActionBar(recipe: recipe),
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
                  children: [
                    _Hero(
                      imageUrl: recipe.imageUrl,
                      priceText: 'Aman (${fmt.format(perServing)}/porsi)',
                    ),
                    _TitleMeta(
                      name: recipe.name,
                      time: '${recipe.cookTime} Menit',
                      servings: '${recipe.porsi} Porsi',
                      calories: '$caloriesPerServing kkal/porsi',
                    ),
                    _BahanSection(price: recipe.estPrice, bahan: recipe.bahan),
                    _StepsSection(steps: recipe.langkah),
                    const _Disclaimer(),
                    const SizedBox(height: AppSpacing.lg),
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
  const _Hero({required this.imageUrl, required this.priceText});
  final String imageUrl;
  final String priceText;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppImage(
            imageUrl: imageUrl,
            placeholderIcon: Icons.restaurant_rounded,
            placeholderIconSize: 48,
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
                  const Icon(
                    Icons.eco_rounded,
                    size: 18,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    priceText,
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
  const _TitleMeta({
    required this.name,
    required this.time,
    required this.servings,
    required this.calories,
  });

  final String name;
  final String time;
  final String servings;
  final String calories;

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
          Text(name, style: AppTypography.h1),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.sm,
            children: [
              _MetaItem(icon: Icons.timer_outlined, label: time),
              _MetaItem(icon: Icons.restaurant_rounded, label: servings),
              _MetaItem(
                icon: Icons.local_fire_department_outlined,
                label: calories,
              ),
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
  const _BahanSection({required this.price, required this.bahan});

  final int price;
  final List<Bahan> bahan;

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

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
                'Total: ${fmt.format(price)}',
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
              final columns = constraints.maxWidth < 430 ? 1 : 2;
              final colWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final b in bahan)
                    SizedBox(
                      width: colWidth,
                      child: _CompactBahanTile(
                        name: b.nama,
                        amount: _amountLabel(b),
                        price: b.harga > 0 ? fmt.format(b.harga) : 'Gratis',
                        unitPrice: _unitPriceLabel(b, fmt),
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

class _CompactBahanTile extends StatelessWidget {
  const _CompactBahanTile({
    required this.name,
    required this.amount,
    required this.price,
    this.unitPrice,
  });

  final String name;
  final String amount;
  final String price;
  final String? unitPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 72),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppRadii.brMd,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.35),
        ),
        boxShadow: AppElevation.level1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainer,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.kitchen_rounded,
              size: 18,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: AppTypography.label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  amount,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontFeatures: AppTypography.tnum,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (unitPrice != null)
                  Text(
                    unitPrice!,
                    style: AppTypography.overline.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontFeatures: AppTypography.tnum,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            price,
            style: AppTypography.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontFeatures: AppTypography.tnum,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

String? _unitPriceLabel(Bahan bahan, NumberFormat fmt) {
  if (bahan.harga <= 0) return null;

  final parsed = _parseQuantity(bahan.jumlah);
  if (parsed == null || parsed.amount <= 0) {
    final grams = bahan.gram;
    if (grams == null || grams <= 0) return null;
    final unitPrice = (bahan.harga / grams).round();
    return '${fmt.format(unitPrice)}/g estimasi';
  }

  final unitPrice = (bahan.harga / parsed.amount).round();
  return '${fmt.format(unitPrice)}/${parsed.unit}';
}

String _amountLabel(Bahan bahan) {
  final quantity = bahan.jumlah.trim();
  final estimate = _gramEstimateLabel(bahan.gram);

  if (!_needsEstimatedQuantity(quantity)) return quantity;
  if (estimate == null) {
    return quantity.isEmpty ? 'Estimasi belum ada' : quantity;
  }

  return estimate;
}

bool _needsEstimatedQuantity(String quantity) {
  final normalized = quantity.trim().toLowerCase();
  if (normalized.isEmpty) return true;
  if (normalized == 'secukupnya' || normalized == 'sesuai selera') return true;
  if (normalized.contains('secukupnya')) return true;
  if (normalized.contains('sesuai selera')) return true;
  return !RegExp(r'\d').hasMatch(normalized);
}

String? _gramEstimateLabel(double? grams) {
  if (grams == null || grams <= 0) return null;
  final rounded = grams >= 1000 ? grams / 1000 : grams;
  final unit = grams >= 1000 ? 'kg' : 'g';
  final amount = rounded % 1 == 0
      ? rounded.toStringAsFixed(0)
      : rounded.toStringAsFixed(1).replaceAll('.', ',');
  return '~$amount $unit';
}

_ParsedQuantity? _parseQuantity(String quantity) {
  final match = RegExp(
    r'^\s*(\d+(?:[,.]\d+)?)\s*(.*)$',
    caseSensitive: false,
  ).firstMatch(quantity);
  if (match == null) return null;

  final amount = double.tryParse(match.group(1)!.replaceAll(',', '.'));
  final unit = match.group(2)!.trim().toLowerCase();
  if (amount == null || unit.isEmpty) return null;

  return _ParsedQuantity(amount, unit);
}

class _ParsedQuantity {
  const _ParsedQuantity(this.amount, this.unit);

  final double amount;
  final String unit;
}

class _StepsSection extends StatelessWidget {
  const _StepsSection({required this.steps});
  final List<String> steps;

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
          for (var i = 0; i < steps.length; i++) ...[
            StepCard(index: i + 1, text: steps[i]),
            if (i != steps.length - 1) const SizedBox(height: AppSpacing.md),
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

class _ActionBar extends ConsumerWidget {
  const _ActionBar({required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        onPressed: () async {
                          try {
                            await ref
                                .read(budgetControllerProvider.notifier)
                                .addSpending(
                                  recipe.estPrice,
                                  'Masak: ${recipe.name}',
                                  ['cook', 'recipe:${recipe.id}'],
                                );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Berhasil menambahkan pengeluaran!',
                                ),
                              ),
                            );
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                          } catch (error) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Gagal menyimpan pengeluaran: $error',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SecondaryButton(
                        label: 'Tambah ke rencana',
                        icon: Icons.calendar_month_rounded,
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (date != null && context.mounted) {
                            final waktu = await _showWaktuMakanSheet(context);
                            if (waktu == null) return;
                            try {
                              await ref
                                  .read(planControllerProvider)
                                  .addMeal(date, recipe.id, waktu);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Berhasil menambahkan ke rencana!',
                                  ),
                                ),
                              );
                            } catch (error) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Gagal menambahkan ke rencana: $error',
                                  ),
                                ),
                              );
                            }
                          }
                        },
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

Future<String?> _showWaktuMakanSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.surfaceContainerLowest,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Waktu Makan', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              title: const Text('Pagi', style: AppTypography.bodyLg),
              onTap: () => Navigator.of(context).pop('pagi'),
            ),
            ListTile(
              title: const Text('Siang', style: AppTypography.bodyLg),
              onTap: () => Navigator.of(context).pop('siang'),
            ),
            ListTile(
              title: const Text('Sore', style: AppTypography.bodyLg),
              onTap: () => Navigator.of(context).pop('sore'),
            ),
            ListTile(
              title: const Text('Malam', style: AppTypography.bodyLg),
              onTap: () => Navigator.of(context).pop('malam'),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      );
    },
  );
}
