import 'package:drift/drift.dart';

class FavoritesTable extends Table {
  TextColumn get recipeId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {recipeId};
}
