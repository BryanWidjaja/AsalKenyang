import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_elevation.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/top_bar.dart';
import '../../grocery/application/grocery_controller.dart';
import '../../plan/application/plan_controller.dart';
import '../../pantry/application/pantry_controller.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  static const String route = '/notifications';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final allMeals = ref.watch(planDetailsProvider);
    final groceryStates = ref.watch(groceryStatesProvider).value ?? [];
    final pantryState = ref.watch(pantryControllerProvider);
    final pantryQuantities = {
      for (final item in pantryState.items) item.bahanKey: item.quantity,
    };

    final todayMeals = allMeals.where((meal) {
      final d = meal.meal.date;
      return d.year == today.year &&
          d.month == today.month &&
          d.day == today.day;
    }).toList();

    final todayGroceryItems = aggregateGroceryItems(todayMeals, groceryStates);
    final toBuy = todayGroceryItems
        .where(
          (item) =>
              !item.isChecked &&
              !_hasEnoughPantryQuantity(item, pantryQuantities),
        )
        .toList();

    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.nested(title: 'Notifikasi'),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.edge,
            vertical: AppSpacing.md,
          ),
          children: [
            // ── Today's Meals ────────────────────────────────
            _SectionHeader(
              icon: Icons.restaurant_rounded,
              title: 'Menu Hari Ini',
              subtitle: _formatIndonesianDate(today),
            ),
            const SizedBox(height: AppSpacing.md),

            if (todayMeals.isEmpty)
              _EmptyCard(
                icon: Icons.event_busy_rounded,
                message: 'Belum ada rencana masak hari ini',
              )
            else
              for (final meal in todayMeals) ...[
                _MealCard(
                  recipeName: meal.recipe.name,
                  imageUrl: meal.recipe.imageUrl,
                  price: fmt.format(meal.recipe.estPrice),
                  cookTime: '${meal.recipe.cookTime} menit',
                  ingredientCount: meal.recipe.bahan.length,
                ),
                const SizedBox(height: AppSpacing.sm),
              ],

            const SizedBox(height: AppSpacing.lg),

            // ── Shopping Reminder ────────────────────────────
            _SectionHeader(
              icon: Icons.shopping_cart_rounded,
              title: 'Perlu Dibeli',
              subtitle: '${toBuy.length} bahan belum tersedia',
            ),
            const SizedBox(height: AppSpacing.md),

            if (toBuy.isEmpty)
              _EmptyCard(
                icon: Icons.check_circle_outline_rounded,
                message: 'Semua bahan sudah tersedia!',
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: AppRadii.brMd,
                  boxShadow: AppElevation.level1,
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < toBuy.length; i++) ...[
                      _GroceryRow(
                        name: toBuy[i].name,
                        quantity: toBuy[i].quantity,
                        price: fmt.format(toBuy[i].price),
                      ),
                      if (i < toBuy.length - 1)
                        Divider(
                          height: 1,
                          indent: AppSpacing.edge,
                          endIndent: AppSpacing.edge,
                          color: AppColors.outlineVariant.withValues(
                            alpha: 0.3,
                          ),
                        ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

bool _hasEnoughPantryQuantity(
  GroceryAggregatedItem item,
  Map<String, String?> pantryQuantities,
) {
  if (!pantryQuantities.containsKey(item.bahanKey)) return false;

  final pantryQuantity = pantryQuantities[item.bahanKey];
  final pantryParsed = _parseQuantity(pantryQuantity ?? '1');
  final neededParsed = _parseQuantity(item.quantity);
  if (pantryParsed == null || neededParsed == null) return true;
  if (pantryParsed.unit != neededParsed.unit) return true;

  return pantryParsed.amount >= neededParsed.amount;
}

_ParsedQuantity? _parseQuantity(String quantity) {
  final match = RegExp(
    r'^\s*(\d+(?:[,.]\d+)?)\s*(.*)$',
    caseSensitive: false,
  ).firstMatch(quantity);
  if (match == null) return null;

  final amount = double.tryParse(match.group(1)!.replaceAll(',', '.'));
  if (amount == null) return null;

  return _ParsedQuantity(amount, match.group(2)!.trim().toLowerCase());
}

class _ParsedQuantity {
  const _ParsedQuantity(this.amount, this.unit);

  final double amount;
  final String unit;
}

String _formatIndonesianDate(DateTime date) {
  const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
}

// ─── Section Header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.terracottaContainer,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.titleMd),
              Text(subtitle, style: AppTypography.caption),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Empty State Card ────────────────────────────────────────────────────────

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppRadii.brMd,
        boxShadow: AppElevation.level1,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.onSurfaceVariant, size: 28),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: AppTypography.body.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Meal Card ───────────────────────────────────────────────────────────────

class _MealCard extends StatelessWidget {
  const _MealCard({
    required this.recipeName,
    required this.imageUrl,
    required this.price,
    required this.cookTime,
    required this.ingredientCount,
  });

  final String recipeName;
  final String imageUrl;
  final String price;
  final String cookTime;
  final int ingredientCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppRadii.brMd,
        boxShadow: AppElevation.level1,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipeName,
                  style: AppTypography.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    _InfoChip(icon: Icons.timer_outlined, label: cookTime),
                    const SizedBox(width: AppSpacing.sm),
                    _InfoChip(
                      icon: Icons.egg_outlined,
                      label: '$ingredientCount bahan',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  price,
                  style: AppTypography.label.copyWith(
                    color: AppColors.primary,
                    fontFeatures: AppTypography.tnum,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.restaurant_rounded,
        color: AppColors.onSurfaceVariant,
      ),
    );
  }
}

// ─── Info Chip ───────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

// ─── Grocery Row ─────────────────────────────────────────────────────────────

class _GroceryRow extends StatelessWidget {
  const _GroceryRow({
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String name;
  final String quantity;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.edge,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.label),
                Text(quantity, style: AppTypography.caption),
              ],
            ),
          ),
          Text(
            price,
            style: AppTypography.label.copyWith(
              fontFeatures: AppTypography.tnum,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
