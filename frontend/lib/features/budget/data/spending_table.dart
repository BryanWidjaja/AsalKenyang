import 'package:drift/drift.dart';

@DataClassName('SpendingEntry')
class SpendingTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get walletId => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get title => text()();
  TextColumn get tags => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
