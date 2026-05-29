import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'outbox_table.dart';
import '../../features/budget/data/budget_table.dart';
import '../../features/budget/data/spending_table.dart';
import '../../features/pantry/data/pantry_table.dart';
import '../../features/plan/data/plan_table.dart';
import '../../features/grocery/data/grocery_table.dart';
import '../../features/recipes/data/favorites_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    OutboxTable,
    BudgetTable,
    SpendingTable,
    PantryTable,
    PlanTable,
    GroceryTable,
    FavoritesTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // v3 → v4: add quantity column to pantry_table
      if (from < 4) {
        await m.addColumn(pantryTable, pantryTable.quantity);
      }
      // v4 → v5: add mealSlot column to plan_table
      if (from < 5) {
        await m.addColumn(planTable, planTable.mealSlot);
      }
      // Also create any tables that might be missing entirely
      await m.createAll();
    },
    beforeOpen: (details) async {
      await createMigrator().createAll();
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return driftDatabase(
      name: 'asalkenyang_db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
      native: const DriftNativeOptions(
        databaseDirectory: null, // Let drift_flutter choose
      ),
    );
  });
}
