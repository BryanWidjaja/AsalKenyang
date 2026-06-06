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
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 4) {
        await migrator.addColumn(pantryTable, pantryTable.quantity);
      }

      if (from < 5) {
        await migrator.addColumn(planTable, planTable.mealSlot);
      }

      await migrator.createAll();
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
        databaseDirectory: null,
      ),
    );
  });
}
