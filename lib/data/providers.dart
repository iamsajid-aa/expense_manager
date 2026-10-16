import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database/app_database.dart';
import 'repositories/expense_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final expenseRepositoryProvider = Provider<ExpenseRepository>(
  (ref) => ExpenseRepository(ref.watch(databaseProvider)),
);

final expensesProvider = StreamProvider<List<ExpenseWithCategory>>(
  (ref) => ref.watch(expenseRepositoryProvider).watchAll(),
);

final categoriesProvider = StreamProvider<List<Category>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.categories).watch();
});