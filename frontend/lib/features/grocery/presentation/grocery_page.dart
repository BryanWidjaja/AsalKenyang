import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_elevation.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/budget_gauge.dart';
import '../../../shared/widgets/grocery_item.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/top_bar.dart';

class _Item {
  const _Item(this.name, this.note, this.price);
  final String name;
  final String note;
  final String price;
}

class _Category {
  const _Category(this.icon, this.title, this.items);
  final IconData icon;
  final String title;
  final List<_Item> items;
}

const _categories = <_Category>[
  _Category(Icons.local_florist_rounded, 'Sayuran & Bumbu', [
    _Item('Bawang Merah (250g)', 'Untuk Nasi Goreng', 'Rp 5.000'),
    _Item('Sawi Hijau (1 ikat)', 'Menu Sehat', 'Rp 8.000'),
    _Item('Cabai Rawit (100g)', 'Opsional', 'Rp 3.000'),
  ]),
  _Category(Icons.set_meal_rounded, 'Lauk Pauk', [
    _Item('Telur Ayam (1/2 kg)', 'Stok Mingguan', 'Rp 15.000'),
    _Item('Tempe (2 papan)', 'Protein Murah', 'Rp 12.000'),
  ]),
  _Category(Icons.rice_bowl_rounded, 'Kebutuhan Pokok', [
    _Item('Beras Putih', 'Cek sisa di kosan', '-'),
  ]),
];

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  final Set<String> _checked = {'Bawang Merah (250g)', 'Tempe (2 papan)'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.shell(budgetText: 'Rp 47.000'),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.edge,
                AppSpacing.lg,
                AppSpacing.edge,
                AppSpacing.xl,
              ),
              children: [
                const _BudgetCard(),
                const SizedBox(height: AppSpacing.lg),
                for (final c in _categories) ...[
                  SectionHeader(title: c.title, icon: c.icon),
                  const SizedBox(height: AppSpacing.md),
                  _CategoryCard(
                    items: c.items,
                    checked: _checked,
                    onToggle: (name) => setState(() {
                      if (!_checked.add(name)) _checked.remove(name);
                    }),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  const _BudgetCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: AppRadii.brMd,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Estimasi Belanja', style: AppTypography.titleMd),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Budget sisa: Rp 120.000',
            style: AppTypography.body.copyWith(
              color: AppColors.onSurfaceVariant,
              fontFeatures: AppTypography.tnum,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const BudgetGauge(percent: 0.72),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Rp 47.000 terpakai',
                  style: AppTypography.caption.copyWith(
                    fontFeatures: AppTypography.tnum,
                  ),
                ),
              ),
              Text(
                'Aman',
                style: AppTypography.caption.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.items,
    required this.checked,
    required this.onToggle,
  });

  final List<_Item> items;
  final Set<String> checked;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
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
            for (var i = 0; i < items.length; i++) ...[
              GroceryItem(
                name: items[i].name,
                note: items[i].note,
                price: items[i].price,
                checked: checked.contains(items[i].name),
                onChanged: (_) => onToggle(items[i].name),
              ),
              if (i != items.length - 1)
                const Divider(height: 1, indent: AppSpacing.md, endIndent: AppSpacing.md),
            ],
          ],
        ),
      ),
    );
  }
}
