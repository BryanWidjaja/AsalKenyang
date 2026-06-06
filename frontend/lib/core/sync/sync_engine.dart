import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../db/app_database.dart';
import '../../features/budget/data/budget_remote_source.dart';
import '../../features/pantry/data/pantry_repository.dart';
import '../../features/pantry/data/pantry_models.dart';
import '../../features/plan/data/plan_remote_source.dart';
import '../../features/grocery/data/grocery_remote_source.dart';
import '../../features/budget/data/budget_repository.dart';
import '../../features/recipes/data/favorites_remote_source.dart';

final syncEngineProvider = Provider<SyncEngine>((ref) {
  return SyncEngine(
    ref.watch(appDatabaseProvider),
    ref.watch(budgetRemoteSourceProvider),
    ref.watch(pantryRemoteSourceProvider),
    ref.watch(planRemoteSourceProvider),
    ref.watch(groceryRemoteSourceProvider),
    ref.watch(favoritesRemoteSourceProvider),
  );
});

class SyncEngine {
  const SyncEngine(
    this._db,
    this._budgetRemote,
    this._pantryRemote,
    this._planRemote,
    this._groceryRemote,
    this._favoritesRemote,
  );

  final AppDatabase _db;
  final BudgetRemoteSource _budgetRemote;
  final PantryRemoteSource _pantryRemote;
  final PlanRemoteSource _planRemote;
  final GroceryRemoteSource _groceryRemote;
  final FavoritesRemoteSource _favoritesRemote;

  Future<void> syncOutbox() async {
    final pending = await (_db.select(_db.outboxTable)
          ..where((table) => table.status.equals('pending'))
          ..orderBy([(table) => drift.OrderingTerm(expression: table.createdAt)]))
        .get();

    for (final entry in pending) {
      try {
        final payload = jsonDecode(entry.payloadJson);

        if (entry.entity == 'wallet' && entry.operation == 'update') {
          await _budgetRemote.updateWallet(payload['totalBudget'] as int);
        } else if (entry.entity == 'spending' && entry.operation == 'insert') {
          await _budgetRemote.addSpending(
            payload['amount'] as int,
            payload['title'] as String,
            List<String>.from(payload['tags'] as List),
          );
        } else if (entry.entity == 'pantry') {
          if (payload['items'] is List) {
            final itemsList = payload['items'] as List;
            final items = itemsList.map((rawItem) {
              final map = rawItem as Map<String, dynamic>;
              return PantryItem(
                id: map['bahanKey'] as String,
                userId: 'local',
                bahanKey: map['bahanKey'] as String,
                quantity: map['quantity'] as String?,
                createdAt: DateTime.now(),
              );
            }).toList();
            await _pantryRemote.replaceItems(items);
          }
        } else if (entry.entity == 'plan' && entry.operation == 'insert') {
          await _syncPlanWeek(DateTime.parse(payload['date'] as String));
        } else if (entry.entity == 'plan' && entry.operation == 'delete') {
          final dateText = payload['date'] as String?;
          await _syncPlanWeek(
            dateText == null ? DateTime.now() : DateTime.parse(dateText),
          );
        } else if (entry.entity == 'grocery' && entry.operation == 'update') {
          await _groceryRemote.toggleCheck(
            payload['bahanKey'] as String,
            payload['isChecked'] as bool,
          );
        } else if (entry.entity == 'favorites' && entry.operation == 'insert') {
          await _favoritesRemote.addFavorite(payload['recipeId'] as String);
        } else if (entry.entity == 'favorites' && entry.operation == 'delete') {
          await _favoritesRemote.removeFavorite(payload['recipeId'] as String);
        }

        await (_db.update(_db.outboxTable)..where((table) => table.id.equals(entry.id)))
            .write(OutboxTableCompanion(status: const drift.Value('done'), updatedAt: drift.Value(DateTime.now())));
      } catch (error) {
        break;
      }
    }
  }

  Future<void> _syncPlanWeek(DateTime date) async {
    final weekStart = _startOfWeek(date);
    final rows = await _db.select(_db.planTable).get();

    final uniqueEntries = <String, Map<String, Object?>>{};
    for (final row in rows.where((row) => _startOfWeek(row.date) == weekStart)) {
      final dayIndex = row.date.difference(weekStart).inDays;
      final key = '${dayIndex}_${row.mealSlot}';
      uniqueEntries[key] = {
        'dayIndex': dayIndex,
        'mealSlot': row.mealSlot,
        'recipeId': row.recipeId,
      };
    }

    await _planRemote.replaceWeek(weekStart, uniqueEntries.values.toList());
  }

  DateTime _startOfWeek(DateTime date) {
    final local = DateTime(date.year, date.month, date.day);
    return local.subtract(Duration(days: local.weekday - DateTime.monday));
  }
}
