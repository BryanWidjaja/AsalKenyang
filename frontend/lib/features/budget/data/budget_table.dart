import 'package:drift/drift.dart';

@DataClassName('BudgetEntry')
class BudgetTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get totalBudget => integer()();
  BoolColumn get monthlyReset => boolean().withDefault(const Constant(true))();
  IntColumn get startDay => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
