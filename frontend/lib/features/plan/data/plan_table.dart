import 'package:drift/drift.dart';

class PlanTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get recipeId => text()();
  TextColumn get mealSlot => text().withDefault(const Constant('siang'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
