import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_elevation.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/budget_summary_strip.dart';
import '../../../shared/widgets/grocery_item.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/top_bar.dart';
import '../../../shared/utils/ingredient_groups.dart';
import '../../budget/application/budget_controller.dart';

import '../application/grocery_controller.dart';

class GroceryPage extends ConsumerWidget {
  const GroceryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(groceryListProvider);
    final totalCost = ref.watch(groceryTotalCostProvider);
    final budgetState = ref.watch(budgetControllerProvider);
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final groupedItems = _groupItems(items);
    final remainingAfterShopping = budgetState.remainingBudget - totalCost;
    final totalBudget = budgetState.wallet?.totalBudget ?? 0;
    final remainingPercent = totalBudget == 0
        ? 0.0
        : (remainingAfterShopping / totalBudget).clamp(0, 1).toDouble();

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: TopBar.shell(budgetText: fmt.format(totalCost)),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.screenMaxWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.edge,
                AppSpacing.lg,
                AppSpacing.edge,
                AppSpacing.xl,
              ),
              children: [
                BudgetSummaryStrip(
                  estimasiText: fmt.format(totalCost),
                  sisaText: fmt.format(remainingAfterShopping),
                  remainingPercent: remainingPercent,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: Center(
                      child: Text('Belum ada barang di daftar belanja.'),
                    ),
                  )
                else
                  for (final entry in groupedItems.entries) ...[
                    SectionHeader(
                      title: entry.key,
                      icon: Icons.shopping_bag_rounded,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _CategoryCard(
                      items: entry.value,
                      onToggle: (bahanKey, isChecked) {
                        ref
                            .read(groceryControllerProvider)
                            .toggleCheck(bahanKey, isChecked);
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.items, required this.onToggle});

  final List<GroceryAggregatedItem> items;
  final void Function(String bahanKey, bool isChecked) onToggle;

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppRadii.brMd,
        boxShadow: AppElevation.level1,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: AppRadii.brMd,
        child: Column(
          children: [
            for (var index = 0; index < items.length; index++) ...[
              GroceryItem(
                name: items[index].name,
                quantity: items[index].quantity,
                note: 'Total estimasi: ${fmt.format(items[index].price)}',
                price:
                    '${fmt.format(items[index].unitPrice)}/${items[index].unitName}',
                checked: items[index].isChecked,
                onChanged: (value) => onToggle(items[index].bahanKey, value),
              ),
              if (index != items.length - 1)
                const Divider(
                  height: 1,
                  indent: AppSpacing.md,
                  endIndent: AppSpacing.md,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

Map<String, List<GroceryAggregatedItem>> _groupItems(
  List<GroceryAggregatedItem> items,
) {
  final groups = <String, List<GroceryAggregatedItem>>{
    'Sayuran & Bumbu': [],
    'Lauk Pauk': [],
    'Kebutuhan Pokok': [],
  };

  for (final item in items) {
    groups[_categoryFor(item.name)]!.add(item);
  }

  groups.removeWhere((_, value) => value.isEmpty);
  return groups;
}

String _categoryFor(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('ayam') ||
      isFishIngredient(name) ||
      lower.contains('telur') ||
      lower.contains('tahu') ||
      lower.contains('tempe') ||
      lower.contains('udang')) {
    return 'Lauk Pauk';
  }
  if (lower.contains('nasi') ||
      lower.contains('beras') ||
      lower.contains('mie') ||
      lower.contains('roti') ||
      lower.contains('tepung')) {
    return 'Kebutuhan Pokok';
  }
  return 'Sayuran & Bumbu';
}
