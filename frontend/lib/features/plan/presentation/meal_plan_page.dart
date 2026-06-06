import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
import '../../budget/application/budget_controller.dart';
import '../application/plan_controller.dart';

class MealPlanPage extends ConsumerStatefulWidget {
  const MealPlanPage({super.key});

  @override
  ConsumerState<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends ConsumerState<MealPlanPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final allMeals = ref.watch(planDetailsProvider);
    final budgetState = ref.watch(budgetControllerProvider);
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final weekStart = _startOfWeek(_selectedDay);
    final weekDays = List.generate(
      7,
      (index) => weekStart.add(Duration(days: index)),
    );
    final weekMeals = allMeals
        .where((meal) => _startOfWeek(meal.meal.date) == weekStart)
        .toList();
    final totalPlan = weekMeals.fold<int>(
      0,
      (sum, meal) => sum + meal.recipe.estPrice,
    );
    final remainingAfterPlan = budgetState.remainingBudget - totalPlan;
    final totalBudget = budgetState.wallet?.totalBudget ?? 0;
    final remainingPercent = totalBudget == 0
        ? 0.0
        : (remainingAfterPlan / totalBudget).clamp(0, 1).toDouble();

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: TopBar.shell(budgetText: fmt.format(budgetState.remainingBudget)),
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
                AppSpacing.md,
                AppSpacing.edge,
                AppSpacing.xl + 88,
              ),
              children: [
                _CalendarPanel(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  meals: allMeals,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() => _focusedDay = focusedDay);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                BudgetSummaryStrip(
                  estimasiText: fmt.format(totalPlan),
                  sisaText: fmt.format(remainingAfterPlan),
                  remainingPercent: remainingPercent,
                ),
                const SizedBox(height: AppSpacing.lg),
                for (final day in weekDays) ...[
                  DayPlanCard(
                    day: _dayName(day.weekday),
                    date: _dateLabel(day),
                    dimmed: _mealsForDay(weekMeals, day).isEmpty,
                    onAdd: () => Navigator.of(
                      context,
                    ).pushNamed('/recipe-browse', arguments: day),
                    recipes: [
                      for (final meal in _mealsForDay(weekMeals, day))
                        PlannedRecipeRow(
                          title: meal.recipe.name,
                          subtitle:
                              '${fmt.format(meal.recipe.estPrice)} · ${_capitalize(meal.meal.mealSlot)}',
                          imageUrl: meal.recipe.imageUrl,
                          onTap: () => ref
                              .read(planControllerProvider)
                              .removeMeal(meal.meal.id),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _Footer(totalItems: weekMeals.length),
    );
  }
}

class _CalendarPanel extends StatelessWidget {
  const _CalendarPanel({
    required this.focusedDay,
    required this.selectedDay,
    required this.meals,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final List<PlannedMealDetail> meals;
  final void Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final ValueChanged<DateTime> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppRadii.brMd,
        boxShadow: AppElevation.level1,
        border: Border.all(color: AppColors.surfaceContainerHigh),
      ),
      child: TableCalendar<PlannedMealDetail>(
        firstDay: DateTime(now.year - 1, 1, 1),
        lastDay: DateTime(now.year + 1, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        eventLoader: (day) => _mealsForDay(meals, day),
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,
        startingDayOfWeek: StartingDayOfWeek.monday,
        availableCalendarFormats: const {CalendarFormat.month: 'Bulan'},
        calendarFormat: CalendarFormat.month,
        rowHeight: 42,
        daysOfWeekHeight: 28,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: AppTypography.titleMd,
          leftChevronIcon: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.primary,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: AppTypography.caption,
          weekendStyle: AppTypography.caption.copyWith(
            color: AppColors.primary,
          ),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          cellMargin: const EdgeInsets.all(4),
          defaultTextStyle: AppTypography.body,
          weekendTextStyle: AppTypography.body,
          todayDecoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.16),
            shape: BoxShape.circle,
          ),
          todayTextStyle: AppTypography.body.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w700,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: AppTypography.body.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        calendarBuilders: CalendarBuilders<PlannedMealDetail>(
          markerBuilder: (context, day, events) {
            if (events.isEmpty) {
              return null;
            }

            return Positioned(
              bottom: 4,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.totalItems});

  final int totalItems;

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
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: PrimaryButton(
            label: 'Buat Daftar Belanja',
            icon: Icons.shopping_bag_rounded,
            onPressed: totalItems == 0
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Daftar belanja diperbarui dari rencana.',
                        ),
                      ),
                    );
                  },
          ),
        ),
      ),
    );
  }
}

List<PlannedMealDetail> _mealsForDay(
  List<PlannedMealDetail> meals,
  DateTime day,
) {
  return meals.where((meal) {
    final date = meal.meal.date;
    return date.year == day.year &&
        date.month == day.month &&
        date.day == day.day;
  }).toList();
}

DateTime _startOfWeek(DateTime date) {
  final local = DateTime(date.year, date.month, date.day);
  return local.subtract(Duration(days: local.weekday - DateTime.monday));
}

String _dayName(int weekday) {
  const names = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];
  return names[weekday - 1];
}

String _dateLabel(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return '${date.day} ${months[date.month - 1]}';
}

String _capitalize(String text) {
  if (text.isEmpty) {
    return text;
  }

  return text[0].toUpperCase() + text.substring(1);
}
