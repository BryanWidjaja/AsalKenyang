import 'package:drift/drift.dart';

@DataClassName('PantryEntry')
class PantryTable extends Table {
  TextColumn get id => text()(); // Server-assigned UUID
  TextColumn get userId => text()();
  TextColumn get bahanKey => text()(); // Canonical ingredient string
  TextColumn get quantity => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
