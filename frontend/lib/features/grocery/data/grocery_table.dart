import 'package:drift/drift.dart';

class GroceryTable extends Table {
  TextColumn get bahanKey => text()();
  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {bahanKey};
}
