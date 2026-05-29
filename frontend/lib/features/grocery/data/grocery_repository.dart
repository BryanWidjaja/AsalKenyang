import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/app_database.dart';
import '../../budget/data/budget_repository.dart';
import 'grocery_models.dart';

final groceryRepositoryProvider = Provider<GroceryRepository>((ref) {
  return GroceryRepository(ref.watch(appDatabaseProvider));
});

class GroceryRepository {
  const GroceryRepository(this._db);
  final AppDatabase _db;

  Stream<List<GroceryItemState>> watchGroceryStates() {
    return _db.select(_db.groceryTable).watch().map((rows) {
      return rows.map((row) => GroceryItemState(
        bahanKey: row.bahanKey,
        isChecked: row.isChecked,
      )).toList();
    });
  }

  Future<void> setChecked(String bahanKey, bool isChecked) async {
    await _db.transaction(() async {
      await _db.into(_db.groceryTable).insert(
        GroceryTableCompanion.insert(
          bahanKey: bahanKey,
          isChecked: Value(isChecked),
        ),
        mode: InsertMode.insertOrReplace,
      );

      await _db.into(_db.outboxTable).insert(
        OutboxTableCompanion.insert(
          entity: 'grocery',
          operation: 'update',
          payloadJson: jsonEncode({
            'bahanKey': bahanKey,
            'isChecked': isChecked,
          }),
        ),
      );
    });
  }
}
