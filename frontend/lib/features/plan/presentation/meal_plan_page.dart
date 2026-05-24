import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_elevation.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/budget_summary_strip.dart';
import '../../../shared/widgets/day_plan_card.dart';
import '../../../shared/widgets/planned_recipe_row.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/top_bar.dart';

class _PlannedMeal {
  const _PlannedMeal(this.title, this.subtitle);
  final String title;
  final String subtitle;
}

class _Day {
  const _Day(this.day, this.date, this.meals);
  final String day;
  final String date;
  final List<_PlannedMeal> meals;
}

const _days = <_Day>[
  _Day('Senin', '16 Okt', [
    _PlannedMeal('Nasi Goreng Telur', 'Rp 8.000 • Pagi'),
    _PlannedMeal('Sayur Sop Bening', 'Rp 12.000 • Malam'),
  ]),
  _Day('Selasa', '17 Okt', []),
  _Day('Rabu', '18 Okt', [
    _PlannedMeal('Ayam Goreng Sambal', 'Rp 20.000 • Malam'),
  ]),
  _Day('Kamis', '19 Okt', []),
  _Day('Jumat', '20 Okt', []),
  _Day('Sabtu', '21 Okt', []),
  _Day('Minggu', '22 Okt', []),
];

class MealPlanPage extends StatelessWidget {
  const MealPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.shell(budgetText: 'Rp 22.000'),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.edge,
                      AppSpacing.md,
                      AppSpacing.edge,
                      AppSpacing.md,
                    ),
                    children: [
                      Text('Rencana Minggu Ini', style: AppTypography.titleMd),
                      const SizedBox(height: AppSpacing.sm),
                      const BudgetSummaryStrip(
                        estimasiText: 'Rp 128.000',
                        sisaText: 'Rp 22.000',
                        remainingPercent: 0.15,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      for (var i = 0; i < _days.length; i++) ...[
                        DayPlanCard(
                          day: _days[i].day,
                          date: _days[i].date,
                          dimmed: _days[i].meals.isEmpty && i > 2,
                          onAdd: () {},
                          recipes: [
                            for (final m in _days[i].meals)
                              PlannedRecipeRow(
                                title: m.title,
                                subtitle: m.subtitle,
                                onTap: () {},
                              ),
                          ],
                        ),
                        if (i != _days.length - 1)
                          const SizedBox(height: AppSpacing.md),
                      ],
                    ],
                  ),
                ),
                const _Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.riceWhite,
        borderRadius: AppRadii.navTop,
        boxShadow: AppElevation.navHeavy,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: PrimaryButton(
        label: 'Buat Daftar Belanja',
        icon: Icons.shopping_cart_checkout_rounded,
        onPressed: () {},
      ),
    );
  }
}
