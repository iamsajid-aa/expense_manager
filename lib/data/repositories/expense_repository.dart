import 'package:drift/drift.dart';
import '../database/app_database.dart';

class ExpenseWithCategory {
  final Expense expense;
  final Category category;
  ExpenseWithCategory(this.expense, this.category);
}

class ExpenseRepository {
  final AppDatabase _db;
  ExpenseRepository(this._db);

  Stream<List<ExpenseWithCategory>> watchAll() {
    final query = _db.select(_db.expenses).join([
      innerJoin(_db.categories,
          _db.categories.id.equalsExp(_db.expenses.categoryId)),
    ])
      ..orderBy([OrderingTerm.desc(_db.expenses.date)]);

    return query.watch().map((rows) => rows
        .map((r) => ExpenseWithCategory(
              r.readTable(_db.expenses),
              r.readTable(_db.categories),
            ))
        .toList());
  }

  Future<void> add({
    required int amountMinor,
    required int categoryId,
    String? note,
    required DateTime date,
  }) =>
      _db.into(_db.expenses).insert(ExpensesCompanion.insert(
            amountMinor: amountMinor,
            categoryId: categoryId,
            note: Value(note),
            date: date,
          ));

  Future<void> delete(int id) =>
      (_db.delete(_db.expenses)..where((t) => t.id.equals(id))).go();
}