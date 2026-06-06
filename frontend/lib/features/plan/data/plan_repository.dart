import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/app_database.dart';
import '../../budget/data/budget_repository.dart';
import 'plan_models.dart';

final planRepositoryProvider = Provider<PlanRepository>((ref) {
  return PlanRepository(ref.watch(appDatabaseProvider));
});

class PlanRepository {
  const PlanRepository(this._db);
  final AppDatabase _db;

  Stream<List<PlannedMeal>> watchPlan() {
    return _db.select(_db.planTable).watch().map((rows) {
      return rows.map((row) => PlannedMeal(
        id: row.id,
        date: row.date,
        recipeId: row.recipeId,
        mealSlot: row.mealSlot,
      )).toList();
    });
  }

  Future<void> addMeal(PlannedMeal meal) async {
    await _db.transaction(() async {
      final existing =
          await (_db.select(_db.planTable)..where(
                (table) =>
                    table.date.equals(meal.date) &
                    table.mealSlot.equals(meal.mealSlot),
              ))
              .get();

      for (final entry in existing) {
        await (_db.delete(
          _db.planTable,
        )..where((table) => table.id.equals(entry.id))).go();
      }

      await _db.into(_db.planTable).insert(
        PlanTableCompanion.insert(
          id: meal.id,
          date: meal.date,
          recipeId: meal.recipeId,
          mealSlot: Value(meal.mealSlot),
        ),
        mode: InsertMode.replace,
      );

      await _db.into(_db.outboxTable).insert(
        OutboxTableCompanion.insert(
          entity: 'plan',
          operation: 'insert',
          payloadJson: jsonEncode({
            'id': meal.id,
            'date': meal.date.toIso8601String(),
            'recipeId': meal.recipeId,
            'mealSlot': meal.mealSlot,
          }),
        ),
      );
    });
  }

  Future<void> removeMeal(String id) async {
    await _db.transaction(() async {
      final existing =
          await (_db.select(_db.planTable)
                ..where((table) => table.id.equals(id)))
              .getSingleOrNull();
      await (_db.delete(
        _db.planTable,
      )..where((table) => table.id.equals(id))).go();

      await _db.into(_db.outboxTable).insert(
        OutboxTableCompanion.insert(
          entity: 'plan',
          operation: 'delete',
          payloadJson: jsonEncode({
            'id': id,
            if (existing != null) 'date': existing.date.toIso8601String(),
          }),
        ),
      );
    });
  }
}
