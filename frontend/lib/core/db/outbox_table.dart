import 'package:drift/drift.dart';

@DataClassName('OutboxEntry')
class OutboxTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entity => text()();
  TextColumn get operation => text()(); // 'insert', 'update', 'delete'
  TextColumn get payloadJson => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))(); // 'pending', 'error'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
