import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 40)();
  TextColumn get iconKey => text()();
  IntColumn get colorValue => integer()();
}

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amountMinor => integer()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get note => text().nullable()();
  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(tables: [Categories, Expenses])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'expense_manager'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await batch((b) {
            b.insertAll(categories, [
              CategoriesCompanion.insert(name: 'Food', iconKey: 'food', colorValue: 0xFFFF9800),
              CategoriesCompanion.insert(name: 'Transport', iconKey: 'transport', colorValue: 0xFF2196F3),
              CategoriesCompanion.insert(name: 'Shopping', iconKey: 'shopping', colorValue: 0xFFE91E63),
              CategoriesCompanion.insert(name: 'Bills', iconKey: 'bills', colorValue: 0xFF9C27B0),
              CategoriesCompanion.insert(name: 'Health', iconKey: 'health', colorValue: 0xFF4CAF50),
              CategoriesCompanion.insert(name: 'Other', iconKey: 'other', colorValue: 0xFF607D8B),
            ]);
          });
        },
      );
}